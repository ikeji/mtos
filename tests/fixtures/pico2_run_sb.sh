# Test larger writes — copy parse.tc (~57 KB) to see when it fails.
cat /src/string_buffer.tc > /sd/SB.TC
wc /sd/SB.TC
cat /src/parse.tc > /sd/P.TC
wc /sd/P.TC
echo CAT_DONE
