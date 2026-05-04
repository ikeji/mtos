# Smoke test md5sum: known file /hello.txt = 'hello, mtfs\n', plus
# /sd/parse.bin so we can compare against host gen2 reference.
md5sum /hello.txt
md5sum /sd/parse.bin
echo MD5_DONE
