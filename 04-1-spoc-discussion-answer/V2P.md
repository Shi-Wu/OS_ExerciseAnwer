
页大小（page size）为32 Bytes(2^5)
页表项1B

8KB的虚拟地址空间(2^13)
一级页表：2^5
PDBR content: 0xd80（1101_100 0_0000, page 0x6c）

page 6c: e1(1110 0001) b5(1011 0101) a1(1010 0001) c1(1100 0001)
         b3(1011 0011) e4(1110 0100) a6(1010 0110) bd(1011 1101)
二级页表：2^5
页内偏移：2^5

4KB的物理内存空间（physical memory）(2^12)
物理帧号：2^7

0xd80(110 1100-00000)page 6c:
		 0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
page 6c: e1 b5 a1 c1 b3 e4 a6 bd 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 
page 3d: f6 7f 5d 4d 7f 04 29 7f 1e 7f ef 51 0c 1c 7f 7f 7f 76 d1 16 7f 17 ab 55 9a 65 ba 7f 7f 0b 7f 7f 
page 76: 1a 1b 1c 10 0c 15 08 19 1a 1b 12 1d 11 0d 14 1e 1c 18 02 12 0f 13 1a 07 16 03 06 18 0a 19 03 04 
page 21: 7f 7f 36 8e 7f 33 d5 82 7f 7f 79 2b 7f 7f 7f 7f 7f f1 7f 7f 71 7f 7f 7f 63 7f 2f dd 67 7f f9 32 
disk 1c: 0f 13 01 0c 12 1a 01 09 09 05 0a 1e 0f 02 18 1e 1c 12 0c 19 11 05 14 0e 15 06 08 09 09 15 0a 14 

1) Virtual Address 6653:
	(0110 0110 0101 0011)
	(0 11001 10010 10011)
  --> pde index:0x19(11001)  pde contents:(0x7f, 01111111, valid 0, pfn 0x7f(page 0x7f))
	--> Fault (page table entry not valid) 
    

2) Virtual Address 1c13:
	(0001 1100 0001 0011)
	(0 00111 00000 10011)
  --> pde index:0x07(00111)  pde contents:(0xbd, 1011 1101, valid 1, pfn 0x3d(page 0x3d))
  	--> pte index:0x00(00000)  pte contents:(0xf6, 1 111_0110, valid 1, pfn 0x76)
	  --> To Physical Address 0xed3(1110 1101 0011) --> Value: 12


3) Virtual Address 6890:
	(0110 1000 1001 0000)
----------


4) Virtual Address 0af6:
	(0000 1010 1111 0110)
	(0 00010 10111 10110)
  --> pde index:0x02(00010)  pde contents:(0xa1, 1010 0001, valid 1, pfn 0x21(page 0x21))
  	--> pte index:0x17(10111)  pte contents:(0x7f, 0 111_1111, valid 0, pfn 0x7f)
	  --> Fault (page table entry not valid) 
	  （有两种情况：a.对应的物理页帧swap out在硬盘上；b.既没有在内存中，页没有在硬盘上，这时页帧号为0x7F）


5) Virtual Address 1e6f:
	(0001 1110 0110 1111)
	(0 00111 10011 01111)
  --> pde index:0x07(00111)  pde contents:(0xbd, 1011 1101, valid 1, pfn 0x3d(page 0x3d))
  	--> pte index:0x13(10011)  pte contents:(0x1c, 0 001_1100, valid 0, pfn 0x1c)
      --> To Disk Sector Address 0x38f(001_1 1000 1111) --> Value: 1e
