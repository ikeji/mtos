// sd.js — SD card in SPI mode, as seen through hw/rtl/soc/spi_master.v.
// Implements what kernel/platform/tn20k/block_sd.tc uses: CMD0, CMD8,
// CMD55 + ACMD41, CMD58 (reports SDHC so arguments are sector numbers),
// CMD59, CMD17 (single read), CMD24 (single write), CMD25 (multi-block
// write with 0xFC data / 0xFD stop tokens). CRC is ignored. The image is
// a Uint8Array whose length is a multiple of 512; writes modify it in
// place and bump `writes` so the host can persist it.

export class SdCard {
  constructor(image) {
    if (image.length % 512) throw new Error("SD image size must be a multiple of 512");
    this.img = image;
    this.sectors = image.length / 512;
    this.cs = false;          // true = CS asserted (low)
    this.idle = true;         // R1 bit0 until ACMD41 completes
    this.acmd = false;
    this.state = "cmd";       // cmd | write (awaiting token) | wdata | wsingle
    this.cmdBuf = [];
    this.resp = [];           // bytes queued for MISO
    this.sector = 0;
    this.dataBuf = [];
    this.writes = 0;          // sectors written (dirty counter)
    this.onWrite = null;
  }

  setCs(asserted) {
    this.cs = asserted;
    if (!asserted) { this.state = "cmd"; this.cmdBuf = []; this.resp = []; }
  }

  // One 8-bit SPI transfer: takes the MOSI byte, returns the MISO byte.
  xfer(mosi) {
    if (!this.cs) return 0xff;
    switch (this.state) {
      case "wdata":
        this.dataBuf.push(mosi);
        if (this.dataBuf.length === 514) {               // 512 data + 2 CRC
          this.writeSector(this.sector, this.dataBuf);
          this.sector++;
          this.dataBuf = [];
          this.resp = [0x05, 0x00];                      // data accepted, then busy
          this.state = this.single ? "cmd" : "write";
        }
        return 0xff;
      case "write":
        if (this.resp.length) return this.resp.shift();
        if (mosi === 0xfc) { this.state = "wdata"; this.dataBuf = []; this.single = false; return 0xff; }
        if (mosi === 0xfd) { this.state = "cmd"; this.resp = [0xff, 0x00]; return 0xff; }  // stop: gap, busy
        return 0xff;
      case "wsingle":
        if (this.resp.length) return this.resp.shift();
        if (mosi === 0xfe) { this.state = "wdata"; this.dataBuf = []; this.single = true; return 0xff; }
        return 0xff;
      default: // cmd
        if (this.resp.length) return this.resp.shift();
        if (this.cmdBuf.length === 0 && (mosi & 0xc0) !== 0x40) return 0xff;
        this.cmdBuf.push(mosi);
        if (this.cmdBuf.length === 6) {
          const cmd = this.cmdBuf[0] & 0x3f;
          const arg = ((this.cmdBuf[1] << 24) | (this.cmdBuf[2] << 16) | (this.cmdBuf[3] << 8) | this.cmdBuf[4]) >>> 0;
          this.cmdBuf = [];
          this.execute(cmd, arg);
        }
        return 0xff;
    }
  }

  execute(cmd, arg) {
    const r1 = this.idle ? 0x01 : 0x00;
    if (this.acmd) {
      this.acmd = false;
      if (cmd === 41) { this.idle = false; this.resp = [0xff, 0x00]; return; }
    }
    switch (cmd) {
      case 0: this.idle = true; this.resp = [0xff, 0x01]; break;
      case 8: this.resp = [0xff, r1, 0x00, 0x00, 0x01, 0xaa]; break;
      case 55: this.acmd = true; this.resp = [0xff, r1]; break;
      case 58: this.resp = [0xff, r1, 0xc0, 0xff, 0x80, 0x00]; break;   // OCR: ready + CCS (SDHC)
      case 59: this.resp = [0xff, r1]; break;
      case 17:
        if (arg >= this.sectors) { this.resp = [0xff, 0x00, 0xff, 0x08]; break; }   // out-of-range error token
        this.resp = [0xff, 0x00, 0xff, 0xfe, ...this.img.subarray(arg * 512, arg * 512 + 512), 0xff, 0xff];
        break;
      case 24:
        if (arg >= this.sectors) { this.resp = [0xff, 0x40]; break; }
        this.sector = arg; this.resp = [0xff, 0x00]; this.state = "wsingle"; break;
      case 25:
        if (arg >= this.sectors) { this.resp = [0xff, 0x40]; break; }
        this.sector = arg; this.resp = [0xff, 0x00]; this.state = "write"; break;
      default: this.resp = [0xff, 0x04 | r1]; break;                         // illegal command
    }
  }

  writeSector(sector, buf) {
    if (sector >= this.sectors) return;
    this.img.set(buf.slice(0, 512), sector * 512);
    this.writes++;
    if (this.onWrite) this.onWrite(sector);
  }
}
