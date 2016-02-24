#!/bin/sh
rm -f xc xem emhello os0 os1 os2 os3
gcc -o xc -O3 -m32 -Ilinux -Iroot/lib root/bin/c.c
gcc -o xem -O3 -m32 -Ilinux -Iroot/lib root/bin/em.c -lm
./xc -o emhello -Iroot/lib root/usr/emhello.c
./xc -o os0 -Iroot/lib root/usr/os/os0.c
./xc -o os1 -Iroot/lib root/usr/os/os1.c
./xc -o os2 -Iroot/lib root/usr/os/os2.c
./xc -o os3 -Iroot/lib root/usr/os/os3.c
./xem emhello
./xem os0
./xem os1
./xem os2
./xem os3
