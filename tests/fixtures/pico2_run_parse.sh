# Run the OS-compiled /sd/parse.bin produced by pico2_compile_parse.sh
# and verify it produces the same AST as the in-tree /bin/parse when
# given /hw.tc as input. Byte-exact comparison would need a cmp tool
# we don't have on pico2, so we wc both files and cat the test output
# for visual inspection.
parse < /hw.tc > /sd/ref.ast
wc /sd/ref.ast
/sd/parse.bin < /hw.tc > /sd/test.ast
wc /sd/test.ast
cat /sd/test.ast
echo RUN_PARSE_DONE
