// pll_40m5.v — Gowin rPLL: 27 MHz crystal → 40.5 MHz system clock.
// fCLKOUT = fCLKIN * (FBDIV_SEL+1) / (IDIV_SEL+1) = 27 * 3 / 2; VCO = 40.5 * 16 = 648 MHz.
module pll_40m5 (input wire clkin, output wire clkout, output wire lock);
    wire clkoutp, clkoutd, clkoutd3;
    rPLL #(
        .FCLKIN("27"), .IDIV_SEL(1), .FBDIV_SEL(2), .ODIV_SEL(16),
        .DYN_IDIV_SEL("false"), .DYN_FBDIV_SEL("false"), .DYN_ODIV_SEL("false"),
        .PSDA_SEL("0000"), .DYN_DA_EN("false"), .DUTYDA_SEL("1000"),
        .CLKOUT_FT_DIR(1'b1), .CLKOUTP_FT_DIR(1'b1), .CLKOUT_DLY_STEP(0), .CLKOUTP_DLY_STEP(0),
        .CLKFB_SEL("internal"), .CLKOUT_BYPASS("false"), .CLKOUTP_BYPASS("false"), .CLKOUTD_BYPASS("false"),
        .DYN_SDIV_SEL(2), .DEVICE("GW2AR-18C")
    ) pll (
        .CLKOUT(clkout), .LOCK(lock), .CLKOUTP(clkoutp), .CLKOUTD(clkoutd), .CLKOUTD3(clkoutd3),
        .RESET(1'b0), .RESET_P(1'b0), .CLKIN(clkin), .CLKFB(1'b0),
        .FBDSEL(6'b0), .IDSEL(6'b0), .ODSEL(6'b0), .PSDA(4'b0), .DUTYDA(4'b0), .FDLY(4'b0));
endmodule
