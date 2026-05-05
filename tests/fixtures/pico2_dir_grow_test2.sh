# Push past 128 dir entries to actually cross a cluster boundary.
# With ~83 entries already on /sd from earlier dir_grow, we need
# 50+ more to definitely spill into a freshly-allocated cluster.
echo START_DG2
echo B1 > /sd/h01.t
echo B1 > /sd/h02.t
echo B1 > /sd/h03.t
echo B1 > /sd/h04.t
echo B1 > /sd/h05.t
echo B1 > /sd/h06.t
echo B1 > /sd/h07.t
echo B1 > /sd/h08.t
echo B1 > /sd/h09.t
echo B1 > /sd/h10.t
echo B1 > /sd/h11.t
echo B1 > /sd/h12.t
echo B1 > /sd/h13.t
echo B1 > /sd/h14.t
echo B1 > /sd/h15.t
echo B1 > /sd/h16.t
echo B1 > /sd/h17.t
echo B1 > /sd/h18.t
echo B1 > /sd/h19.t
echo B1 > /sd/h20.t
echo B1 > /sd/h21.t
echo B1 > /sd/h22.t
echo B1 > /sd/h23.t
echo B1 > /sd/h24.t
echo B1 > /sd/h25.t
echo B1 > /sd/h26.t
echo B1 > /sd/h27.t
echo B1 > /sd/h28.t
echo B1 > /sd/h29.t
echo B1 > /sd/h30.t
echo B1 > /sd/h31.t
echo B1 > /sd/h32.t
echo B1 > /sd/h33.t
echo B1 > /sd/h34.t
echo B1 > /sd/h35.t
echo B1 > /sd/h36.t
echo B1 > /sd/h37.t
echo B1 > /sd/h38.t
echo B1 > /sd/h39.t
echo B1 > /sd/h40.t
echo B1 > /sd/h41.t
echo B1 > /sd/h42.t
echo B1 > /sd/h43.t
echo B1 > /sd/h44.t
echo B1 > /sd/h45.t
echo B1 > /sd/h46.t
echo B1 > /sd/h47.t
echo B1 > /sd/h48.t
echo B1 > /sd/h49.t
echo B1 > /sd/h50.t
echo CROSSED_BOUNDARY
echo Z > /sd/i01.t
echo Z > /sd/i02.t
echo Z > /sd/i03.t
cat /sd/h50.t
cat /sd/i01.t
cat /sd/i03.t
echo DG2_DONE
