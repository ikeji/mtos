# Confirm /sd/parse.bin (M7-full output) parses /hw.tc identically to
# the in-tree /bin/parse. Hash each .ast separately (md5sum's task
# arena is small; running it on multiple files in one invocation
# trips an OOM because the per-file `io` buffer doesn't get re-used).
md5sum /sd/parse.bin
parse < /hw.tc > /sd/ref.ast
/sd/parse.bin < /hw.tc > /sd/test.ast
md5sum /sd/ref.ast
md5sum /sd/test.ast
echo RUN_PARSE_DONE
