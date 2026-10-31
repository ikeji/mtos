#!/bin/bash
# test_genvidict.sh — round-trip test for userland/scripts/genvidict.py.
# Feeds a small synthetic SKK dictionary (EUC-JP) through the generator
# and checks the decoded result: okuri-ari section skipped, annotations
# and (concat ...) dropped, non-hiragana readings and JIS X 0208-external
# candidates filtered, --max-cands honoured, --empty valid. ~0.1 s.
set -u
ROOT=$(cd "$(dirname "$0")/../.." && pwd)
GEN="$ROOT/userland/scripts/genvidict.py"
TMP=$(mktemp -d); trap 'rm -rf "$TMP"' EXIT
fail=0

# Build the input in UTF-8 and convert to EUC-JP like the real files.
# 𠮷 (U+20BB7, outside JIS X 0208 / BMP) and ① (NEC extension, not in
# plain euc_jp) must be filtered; ｱ (half-width kana) too.
cat > "$TMP/in.utf8" <<'EOF'
;; -*- mode: fundamental; coding: euc-jp -*-
;; okuri-ari entries.
よm /読/詠/
;; okuri-nasi entries.
かんじ /漢字/幹事;annot/感じ/
あ /阿/(concat "a\057b")/亜/
いち /一/壱/１/
わ /話/和/我/輪/倭/
カナ /仮名/
#1 /一/
ー /長音/
きょう /今日/京/強/狭/橋/鏡/胸/共/驚/
らーめん /拉麺/
EOF
iconv -f utf-8 -t euc-jp "$TMP/in.utf8" > "$TMP/in.skk" || { echo "iconv failed"; exit 1; }
# Lines iconv cannot encode are appended as raw EUC-JP bytes: a candidate
# with 0x8E (half-width ｱ) and one with 0x8F (JIS X 0212 丂).
printf '\xa4\xcb /\x8e\xb1/\xc6\xfc/\n' >> "$TMP/in.skk"    # に /ｱ/日/
printf '\xa4\xd8 /\x8f\xb0\xa1/\xca\xbf/\n' >> "$TMP/in.skk"  # へ /丂/平/

check() {  # check NAME EXPECTED ACTUAL
    if [ "$2" = "$3" ]; then echo "ok   $1"; else echo "FAIL $1: expected [$2] got [$3]"; fail=1; fi
}

python3 -I "$GEN" "$TMP/in.skk" "$TMP/out.dat" 2> "$TMP/stats" || { cat "$TMP/stats"; exit 1; }
python3 -I "$GEN" --dump "$TMP/out.dat" > "$TMP/dump" || { echo "dump failed"; exit 1; }

check "entries sorted, filtered" \
"あ /阿/亜/
いち /一/壱/１/
かんじ /漢字/幹事/感じ/
きょう /今日/京/強/狭/橋/鏡/胸/共/
に /日/
へ /平/
らーめん /拉麺/
わ /話/和/我/輪/倭/" "$(cat "$TMP/dump")"
check "stats line" "genvidict: 8 entries, 24 candidates" "$(sed 's/, [0-9]* bytes.*//' "$TMP/stats")"

# Alignment: every entry and candidate is an even number of bytes, so
# total_bytes (u32 at offset 8) must be even and equal the file size.
size=$(wc -c < "$TMP/out.dat")
total=$(python3 -I -c "import struct,sys;print(struct.unpack_from('<I',open(sys.argv[1],'rb').read(),8)[0])" "$TMP/out.dat")
check "total_bytes == file size" "$size" "$total"
check "even size" 0 $((size % 2))

python3 -I "$GEN" "$TMP/in.skk" "$TMP/out4.dat" --max-cands 4 2>/dev/null
check "--max-cands 4" "きょう /今日/京/強/狭/" "$(python3 -I "$GEN" --dump "$TMP/out4.dat" | grep '^きょう ')"

python3 -I "$GEN" "$TMP/in.skk" "$TMP/out2.dat" --max-read 2 2>/dev/null
check "--max-read 2 drops long readings" "あ
いち
に
へ
わ" "$(python3 -I "$GEN" --dump "$TMP/out2.dat" | cut -d' ' -f1)"

python3 -I "$GEN" --empty "$TMP/empty.dat"
check "--empty size" 400 "$(wc -c < "$TMP/empty.dat")"
check "--empty dump" "" "$(python3 -I "$GEN" --dump "$TMP/empty.dat")"

if [ $fail -eq 0 ]; then echo "test_genvidict: all passed"; else echo "test_genvidict: FAILED"; fi
exit $fail
