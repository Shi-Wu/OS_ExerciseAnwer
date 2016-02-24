#!/bin/sh
rm -f xc xem emhello
gcc -o xc -O3 -m32 -Ilinux -Iroot/lib root/bin/c.c
gcc -o xem -g -m32 -Ilinux -Iroot/lib root/bin/em.c -lm
./xc -o emhello -Iroot/lib root/usr/emhello.c
./xc -s -Iroot/lib root/usr/emhello.c > emhello.txt
gdb ./xem emhello
