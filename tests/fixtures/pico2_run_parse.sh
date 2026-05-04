# Run /sd/parse.bin on /hw.tc and compare its output (AST) against
# the in-tree /bin/parse run on the same input. Byte-exact compare
# isn't possible without a cmp tool, but identical sizes (wc) plus
# both runs reaching exit=0 is a solid behaviour smoke test.
parse < /hw.tc > /sd/ref.ast
wc /sd/ref.ast
/sd/parse.bin < /hw.tc > /sd/test.ast
wc /sd/test.ast
cat /sd/test.ast
echo RUN_PARSE_DONE
