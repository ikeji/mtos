#!/usr/bin/env python3
# uart_probe.py PORT — send "ping\n", print whatever comes back for 1.5 s.
import os, sys, termios, time
port = sys.argv[1]
fd = os.open(port, os.O_RDWR | os.O_NOCTTY | os.O_NONBLOCK)
a = termios.tcgetattr(fd)
a[0]=0; a[1]=0; a[2]=termios.CS8|termios.CREAD|termios.CLOCAL; a[3]=0
a[4]=a[5]=termios.B115200
termios.tcsetattr(fd, termios.TCSANOW, a)
time.sleep(0.2)
try: os.read(fd, 4096)
except BlockingIOError: pass
os.write(fd, b"ping\n")
buf=b""; t=time.time()
while time.time()-t < 1.5:
    try: buf += os.read(fd, 4096)
    except BlockingIOError: time.sleep(0.02)
print(port, repr(buf))
