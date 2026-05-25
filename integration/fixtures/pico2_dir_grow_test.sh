# pico2_dir_grow_test.sh — exercise the fatfs dir_create chain
# growth fix (commit 773b746). Pre-fix, /sd capped at 128 entries
# (4 KB cluster ÷ 32 B entry) and every fresh `> /sd/foo` past
# that returned -1, manifesting as msh "spawn failed". Post-fix,
# dir_create allocates a new cluster and writes the entry there.
#
# Creates 60 short-named files, verifying each succeeds and reads
# back the value we wrote. Combined with /sd's existing 17 base
# files (runtime.s + libtc.s + 10 kernel module .s + 5 stragglers)
# we cross 77 total entries — not enough alone but exercises a
# chunk of growth space without burning many minutes per write.
echo START_DG
echo A01 > /sd/g01.t
echo A02 > /sd/g02.t
echo A03 > /sd/g03.t
echo A04 > /sd/g04.t
echo A05 > /sd/g05.t
echo A06 > /sd/g06.t
echo A07 > /sd/g07.t
echo A08 > /sd/g08.t
echo A09 > /sd/g09.t
echo A10 > /sd/g10.t
echo A11 > /sd/g11.t
echo A12 > /sd/g12.t
echo A13 > /sd/g13.t
echo A14 > /sd/g14.t
echo A15 > /sd/g15.t
echo A16 > /sd/g16.t
echo A17 > /sd/g17.t
echo A18 > /sd/g18.t
echo A19 > /sd/g19.t
echo A20 > /sd/g20.t
echo A21 > /sd/g21.t
echo A22 > /sd/g22.t
echo A23 > /sd/g23.t
echo A24 > /sd/g24.t
echo A25 > /sd/g25.t
echo A26 > /sd/g26.t
echo A27 > /sd/g27.t
echo A28 > /sd/g28.t
echo A29 > /sd/g29.t
echo A30 > /sd/g30.t
echo A31 > /sd/g31.t
echo A32 > /sd/g32.t
echo A33 > /sd/g33.t
echo A34 > /sd/g34.t
echo A35 > /sd/g35.t
echo A36 > /sd/g36.t
echo A37 > /sd/g37.t
echo A38 > /sd/g38.t
echo A39 > /sd/g39.t
echo A40 > /sd/g40.t
echo A41 > /sd/g41.t
echo A42 > /sd/g42.t
echo A43 > /sd/g43.t
echo A44 > /sd/g44.t
echo A45 > /sd/g45.t
echo A46 > /sd/g46.t
echo A47 > /sd/g47.t
echo A48 > /sd/g48.t
echo A49 > /sd/g49.t
echo A50 > /sd/g50.t
echo A51 > /sd/g51.t
echo A52 > /sd/g52.t
echo A53 > /sd/g53.t
echo A54 > /sd/g54.t
echo A55 > /sd/g55.t
echo A56 > /sd/g56.t
echo A57 > /sd/g57.t
echo A58 > /sd/g58.t
echo A59 > /sd/g59.t
echo A60 > /sd/g60.t
ls /sd | wc -l
cat /sd/g01.t
cat /sd/g60.t
echo DG_DONE
