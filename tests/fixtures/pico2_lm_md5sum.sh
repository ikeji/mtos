# pico2_lm_md5sum.sh — md5sum all LINKMODE intermediates left on /sd
# after a self_replicate LINKMODE=1 run. Use to bisect device-vs-host
# byte-exact divergence.
md5sum /sd/p.idx /sd/kc.idx /sd/pp.idx /sd/bf.idx /sd/bs.idx /sd/ff.idx /sd/mf.idx /sd/tf.idx /sd/pf.idx /sd/vf.idx /sd/ld.idx /sd/kp.idx /sd/pt.idx
md5sum /sd/p.tx /sd/kc.tx /sd/pp.tx /sd/bf.tx /sd/bs.tx /sd/ff.tx /sd/mf.tx /sd/tf.tx /sd/pf.tx /sd/vf.tx /sd/ld.tx /sd/kp.tx /sd/pt.tx
md5sum /sd/p.ro /sd/kc.ro /sd/pp.ro /sd/bf.ro /sd/bs.ro /sd/ff.ro /sd/mf.ro /sd/tf.ro /sd/pf.ro /sd/vf.ro /sd/ld.ro /sd/kp.ro /sd/pt.ro
md5sum /sd/p.dt /sd/kc.dt /sd/pp.dt /sd/bf.dt /sd/bs.dt /sd/ff.dt /sd/mf.dt /sd/tf.dt /sd/pf.dt /sd/vf.dt /sd/ld.dt /sd/kp.dt /sd/pt.dt
md5sum /sd/p.rl /sd/kc.rl /sd/pp.rl /sd/bf.rl /sd/bs.rl /sd/ff.rl /sd/mf.rl /sd/tf.rl /sd/pf.rl /sd/vf.rl /sd/ld.rl /sd/kp.rl /sd/pt.rl
md5sum /sd/full.lab /sd/k.bin
echo LM_MD5SUM_DONE
