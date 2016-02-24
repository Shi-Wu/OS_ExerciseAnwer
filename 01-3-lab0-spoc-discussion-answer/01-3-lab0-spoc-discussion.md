# 分析和实验funcall.c，需要完成的内容包括


 - ## 修改代码，可正常显示小组两位同学的学号（用字符串）

```c

#include <u.h>
int ret;
out(port, val)
{
  asm(LL,8);   // load register a with port
  asm(LBL,16); // load register b with val
  asm(BOUT);   // output byte to console
}

int write(int f, char *s, int n)
{
  int i;
  ret = 1;
  i=n;
  while (i--)
    out(f, *s++);
  return i;
}  

main()
{

  //Change S1/S2 ID to your student ID, and change 12 to new str length
  ret = write(1, "2013011304 2013011305" , 21);
  asm(HALT);
}
 ```

- ## 生成funcall.c的汇编码，理解其实现并给汇编码写注释

```
root/usr/funcall.c  1: #include <u.h>
root/lib/u.h  1: // u.h
root/lib/u.h  2:
root/lib/u.h  3: // instruction set
root/lib/u.h  4: enum {
root/lib/u.h  5:   HALT,ENT ,LEV ,JMP ,JMPI,JSR ,JSRA,LEA ,LEAG,CYC ,MCPY,MCMP,MCHR,MSET, // system
root/lib/u.h  6:   LL  ,LLS ,LLH ,LLC ,LLB ,LLD ,LLF ,LG  ,LGS ,LGH ,LGC ,LGB ,LGD ,LGF , // load a
root/lib/u.h  7:   LX  ,LXS ,LXH ,LXC ,LXB ,LXD ,LXF ,LI  ,LHI ,LIF ,
root/lib/u.h  8:   LBL ,LBLS,LBLH,LBLC,LBLB,LBLD,LBLF,LBG ,LBGS,LBGH,LBGC,LBGB,LBGD,LBGF, // load b
root/lib/u.h  9:   LBX ,LBXS,LBXH,LBXC,LBXB,LBXD,LBXF,LBI ,LBHI,LBIF,LBA ,LBAD,
root/lib/u.h  10:   SL  ,SLH ,SLB ,SLD ,SLF ,SG  ,SGH ,SGB ,SGD ,SGF ,                     // store
root/lib/u.h  11:   SX  ,SXH ,SXB ,SXD ,SXF ,
root/lib/u.h  12:   ADDF,SUBF,MULF,DIVF,                                                   // arithmetic
root/lib/u.h  13:   ADD ,ADDI,ADDL,SUB ,SUBI,SUBL,MUL ,MULI,MULL,DIV ,DIVI,DIVL,
root/lib/u.h  14:   DVU ,DVUI,DVUL,MOD ,MODI,MODL,MDU ,MDUI,MDUL,AND ,ANDI,ANDL,
root/lib/u.h  15:   OR  ,ORI ,ORL ,XOR ,XORI,XORL,SHL ,SHLI,SHLL,SHR ,SHRI,SHRL,
root/lib/u.h  16:   SRU ,SRUI,SRUL,EQ  ,EQF ,NE  ,NEF ,LT  ,LTU ,LTF ,GE  ,GEU ,GEF ,      // logical
root/lib/u.h  17:   BZ  ,BZF ,BNZ ,BNZF,BE  ,BEF ,BNE ,BNEF,BLT ,BLTU,BLTF,BGE ,BGEU,BGEF, // conditional
root/lib/u.h  18:   CID ,CUD ,CDI ,CDU ,                                                   // conversion
root/lib/u.h  19:   CLI ,STI ,RTI ,BIN ,BOUT,NOP ,SSP ,PSHA,PSHI,PSHF,PSHB,POPB,POPF,POPA, // misc
root/lib/u.h  20:   IVEC,PDIR,SPAG,TIME,LVAD,TRAP,LUSP,SUSP,LCL ,LCA ,PSHC,POPC,MSIZ,
root/lib/u.h  21:   PSHG,POPG,NET1,NET2,NET3,NET4,NET5,NET6,NET7,NET8,NET9,
root/lib/u.h  22:   POW ,ATN2,FABS,ATAN,LOG ,LOGT,EXP ,FLOR,CEIL,HYPO,SIN ,COS ,TAN ,ASIN, // math
root/lib/u.h  23:   ACOS,SINH,COSH,TANH,SQRT,FMOD,
root/lib/u.h  24:   IDLE
root/lib/u.h  25: };
root/lib/u.h  26:
root/lib/u.h  27: // system calls
root/lib/u.h  28: enum {
root/lib/u.h  29:   S_fork=1, S_exit,   S_wait,   S_pipe,   S_write,  S_read,   S_close,  S_kill,
root/lib/u.h  30:   S_exec,   S_open,   S_mknod,  S_unlink, S_fstat,  S_link,   S_mkdir,  S_chdir,
root/lib/u.h  31:   S_dup2,   S_getpid, S_sbrk,   S_sleep,  S_uptime, S_lseek,  S_mount,  S_umount,
root/lib/u.h  32:   S_socket, S_bind,   S_listen, S_poll,   S_accept, S_connect,
root/lib/u.h  33: };
root/lib/u.h  34:
root/lib/u.h  35: typedef unsigned char uchar;
root/lib/u.h  36: typedef unsigned short ushort;
root/lib/u.h  37: typedef unsigned int uint;
root/lib/u.h  38:
root/usr/funcall.c  2: int ret;
root/usr/funcall.c  3: out(port, val)
root/usr/funcall.c  4: {
root/usr/funcall.c  5:   asm(LL,8);   // load register a with port
00000000  0000080e  LL    8
root/usr/funcall.c  6:   asm(LBL,16); // load register b with val
00000004  00001026  LBL   16
root/usr/funcall.c  7:   asm(BOUT);   // output byte to console
00000008  0000009a  BOUT
root/usr/funcall.c  8: }
root/usr/funcall.c  9:
root/usr/funcall.c  10: int write(int f, char *s, int n)
0000000c  00000002  LEV   0
root/usr/funcall.c  11: {
root/usr/funcall.c  12:   int i;
root/usr/funcall.c  13:   ret = 1;
00000010  fffff801  ENT   0xfffffff8 (D -8)		// sp -= 8
00000014  00000123  LI    0x1 (D 1)				// a = 1
00000018  00000045  SG    0x0 (D 0)				// *(global_addr)=a; global_addr = operand0 + pc
root/usr/funcall.c  14:   i=n;
0000001c  0000200e  LL    0x20 (D 32)			// a = *(32 + sp)	n	// a=content(local_addr) ; local addr= operand0 + sp
00000020  00000440  SL    0x4 (D 4)				// *(4 + sp) = a	i	// *(local_addr)=a; local_addr = operand0 + sp
root/usr/funcall.c  15:   while (i--)
00000024  00000003  JMP   <fwd>
root/usr/funcall.c  16:     out(f, *s++);
00000028  0000180e  LL    0x18 (D 24)			// a = *(24 + sp)
0000002c  ffffff57  SUBI  0xffffffff (D -1)		// a -= (-1)			// a -= operand0
00000030  00001840  SL    0x18 (D 24)			// *(24 + sp) = a
00000034  ffffff1f  LXC   0xffffffff (D -1)		// a = *( [-1] )					// a=content(virt_addr); virt_addr = vir2phy(operand0)
00000038  0000009d  PSHA						//	// sp -= 8, *sp = a
0000003c  0000180e  LL    0x18 (D 24)			// a = *(24 + sp)
00000040  0000009d  PSHA						//	// sp -= 8, *sp = a
00000044  ffffb805  JSR   0xffffffb8 (TO 0x0)	// save current pc, *sp=pc, sp -= 8; jump to operand0 OR pc+=operand0.
00000048  00001001  ENT   0x10 (D 16)			// sp += 16				//
root/usr/funcall.c  17:   return i;
0000004c  0000040e  LL    4
00000050  00000157  SUBI  1
00000054  00000440  SL    4
00000058  00000154  ADDI  1
0000005c  00000086  BNZ   <fwd>
00000060  0000040e  LL    4
00000064  00000802  LEV   8
root/usr/funcall.c  18: }  
root/usr/funcall.c  19:
root/usr/funcall.c  20: main()
00000068  00000802  LEV   8 // pc= *sp, sp + = operand0+8
root/usr/funcall.c  21: {
root/usr/funcall.c  22:
root/usr/funcall.c  23:   //Change S1/S2 ID to your student ID, and change 12 to new str length
root/usr/funcall.c  24:   ret = write(1, "2013011304 2013011305" , 21);
0000006c  0000159e  PSHI  21 // sp -= 8, *sp = operand0 store lentgh
00000070  00000008  LEAG  0 // a = sp/pc + operand0
00000074  0000009d  PSHA    // sp -= 8, *sp = a store zhan
00000078  0000019e  PSHI  1 //store 1
0000007c  ffff9005  JSR   -112  // save current pc, *sp=pc, sp -= 8; jump to operand0 OR pc+=operand0.
00000080  00001801  ENT   24 // sp += operand0
00000084  00000045  SG    0 // *(global_addr)=a; global_addr = operand0 + pc
root/usr/funcall.c  25:   asm(HALT);
00000088  00000000  HALT
root/usr/funcall.c  26: }
root/usr/funcall.c  27:
0000008c  00000002  LEV   0 //  pc= *sp, sp + = operand0+8,

 ```
- ## 尝试用xem的简单调试功能单步调试代码，回答如下问题：

```
 gcc -o xem -g -m32 -Ilinux -Iroot/lib root/bin/em.c -lm
```
使用上述命令编译出可调试的xem，再使用如下命令进行调试
```
h:	print help commands.
q:	quit.
c:	continue.
s:	single step for one instruction.
i:	display registers.
x:	display memory, the input address is hex number (e.g x 10000)
```

   - ### funcall中的堆栈有多大？是内核态堆栈还是用户态堆栈
	  - 124MB 内核态

   - ### funcall中的全局变量ret放在内存中何处？如何对它寻址？

	  - 放在代码和字符串后，利用LG,SG进行全局变量直接寻址（sp+24得到他的地址）。

   - ###  funcall中的字符串放在内存中何处？如何对它寻址？

	  - 放在代码后，通过堆栈和寄存器配合寻址。

   - ###  局部变量i在内存中的何处？如何对它寻址？

	  - 放在栈中，（sp+4）进行堆栈寻址

   - ###  当前系统是处于中断使能状态吗？

	  - 否

   - ###  funcall中的函数参数是如何传递的？函数返回值是如何传递的？

    - 参数是通过堆栈传递的，返回值是存在寄存器a中。

   - ###  分析并说明funcall执行文件的格式和内容
	  - 文件开始是文件头信息hdr，后面是需要加载的程序,最后是常量数据和全局变量数据。


# 分析和实验os0.c，需要完成的内容包括：


 - 生成os0.c的汇编码，理解其实现并给汇编码写注释
```
root/usr/os/os0.c  1: // os0.c -- simple timer isr test
root/usr/os/os0.c  2:
root/usr/os/os0.c  3: #include <u.h>
root/lib/u.h  1: // u.h
root/lib/u.h  2:
root/lib/u.h  3: // instruction set
root/lib/u.h  4: enum {
root/lib/u.h  5:   HALT,ENT ,LEV ,JMP ,JMPI,JSR ,JSRA,LEA ,LEAG,CYC ,MCPY,MCMP,MCHR,MSET, // system
root/lib/u.h  6:   LL  ,LLS ,LLH ,LLC ,LLB ,LLD ,LLF ,LG  ,LGS ,LGH ,LGC ,LGB ,LGD ,LGF , // load a
root/lib/u.h  7:   LX  ,LXS ,LXH ,LXC ,LXB ,LXD ,LXF ,LI  ,LHI ,LIF ,
root/lib/u.h  8:   LBL ,LBLS,LBLH,LBLC,LBLB,LBLD,LBLF,LBG ,LBGS,LBGH,LBGC,LBGB,LBGD,LBGF, // load b
root/lib/u.h  9:   LBX ,LBXS,LBXH,LBXC,LBXB,LBXD,LBXF,LBI ,LBHI,LBIF,LBA ,LBAD,
root/lib/u.h  10:   SL  ,SLH ,SLB ,SLD ,SLF ,SG  ,SGH ,SGB ,SGD ,SGF ,                     // store
root/lib/u.h  11:   SX  ,SXH ,SXB ,SXD ,SXF ,
root/lib/u.h  12:   ADDF,SUBF,MULF,DIVF,                                                   // arithmetic
root/lib/u.h  13:   ADD ,ADDI,ADDL,SUB ,SUBI,SUBL,MUL ,MULI,MULL,DIV ,DIVI,DIVL,
root/lib/u.h  14:   DVU ,DVUI,DVUL,MOD ,MODI,MODL,MDU ,MDUI,MDUL,AND ,ANDI,ANDL,
root/lib/u.h  15:   OR  ,ORI ,ORL ,XOR ,XORI,XORL,SHL ,SHLI,SHLL,SHR ,SHRI,SHRL,
root/lib/u.h  16:   SRU ,SRUI,SRUL,EQ  ,EQF ,NE  ,NEF ,LT  ,LTU ,LTF ,GE  ,GEU ,GEF ,      // logical
root/lib/u.h  17:   BZ  ,BZF ,BNZ ,BNZF,BE  ,BEF ,BNE ,BNEF,BLT ,BLTU,BLTF,BGE ,BGEU,BGEF, // conditional
root/lib/u.h  18:   CID ,CUD ,CDI ,CDU ,                                                   // conversion
root/lib/u.h  19:   CLI ,STI ,RTI ,BIN ,BOUT,NOP ,SSP ,PSHA,PSHI,PSHF,PSHB,POPB,POPF,POPA, // misc
root/lib/u.h  20:   IVEC,PDIR,SPAG,TIME,LVAD,TRAP,LUSP,SUSP,LCL ,LCA ,PSHC,POPC,MSIZ,
root/lib/u.h  21:   PSHG,POPG,NET1,NET2,NET3,NET4,NET5,NET6,NET7,NET8,NET9,
root/lib/u.h  22:   POW ,ATN2,FABS,ATAN,LOG ,LOGT,EXP ,FLOR,CEIL,HYPO,SIN ,COS ,TAN ,ASIN, // math
root/lib/u.h  23:   ACOS,SINH,COSH,TANH,SQRT,FMOD,
root/lib/u.h  24:   IDLE
root/lib/u.h  25: };
root/lib/u.h  26:
root/lib/u.h  27: // system calls
root/lib/u.h  28: enum {
root/lib/u.h  29:   S_fork=1, S_exit,   S_wait,   S_pipe,   S_write,  S_read,   S_close,  S_kill,
root/lib/u.h  30:   S_exec,   S_open,   S_mknod,  S_unlink, S_fstat,  S_link,   S_mkdir,  S_chdir,
root/lib/u.h  31:   S_dup2,   S_getpid, S_sbrk,   S_sleep,  S_uptime, S_lseek,  S_mount,  S_umount,
root/lib/u.h  32:   S_socket, S_bind,   S_listen, S_poll,   S_accept, S_connect,
root/lib/u.h  33: };
root/lib/u.h  34:
root/lib/u.h  35: typedef unsigned char uchar;
root/lib/u.h  36: typedef unsigned short ushort;
root/lib/u.h  37: typedef unsigned int uint;
root/lib/u.h  38:
root/usr/os/os0.c  4:
root/usr/os/os0.c  5: int current;
root/usr/os/os0.c  6:
root/usr/os/os0.c  7: out(port, val)  { asm(LL,8); asm(LBL,16); asm(BOUT); }
00000000  0000080e  LL    8
00000004  00001026  LBL   16
00000008  0000009a  BOUT
root/usr/os/os0.c  8: ivec(void *isr) { asm(LL,8); asm(IVEC); }
0000000c  00000002  LEV   0
00000010  0000080e  LL    8
00000014  000000a4  IVEC
root/usr/os/os0.c  9: stmr(int val)   { asm(LL,8); asm(TIME); }
00000018  00000002  LEV   0 //  pc= *sp, sp + = operand0+8,
0000001c  0000080e  LL    8  // a=content(local_addr) ; local addr= operand0 + sp
00000020  000000a7  TIME // if operand0 is 0: timeout = a -- set current timeout from a;
           else: printk("timer%d=%u timeout=%u", operand0, timer, timeout)
root/usr/os/os0.c  10: halt(val)       { asm(LL,8); asm(HALT); } 这里设置超时时间1000ms
00000024  00000002  LEV   0
00000028  0000080e  LL    8
0000002c  00000000  HALT
root/usr/os/os0.c  11:
root/usr/os/os0.c  12: alltraps()
00000030  00000002  LEV   0
root/usr/os/os0.c  13: {
root/usr/os/os0.c  14:   asm(PSHA); // sp -= 8, *sp = a
00000034  0000009d  PSHA
root/usr/os/os0.c  15:   asm(PSHB);
00000038  000000a0  PSHB
root/usr/os/os0.c  16:
root/usr/os/os0.c  17:   current++;
0000003c  00000015  LG    0
00000040  ffffff57  SUBI  -1
00000044  00000045  SG    0
root/usr/os/os0.c  18:
root/usr/os/os0.c  19:   asm(POPB);
00000048  000000a1  POPB
root/usr/os/os0.c  20:   asm(POPA);
0000004c  000000a3  POPA
root/usr/os/os0.c  21:   asm(RTI);// return from interrupt, set pc, sp, may switch user/kernel mode;
          if has pending interrupt, process the interrupt
00000050  00000098  RTI
root/usr/os/os0.c  22: }
root/usr/os/os0.c  23:
root/usr/os/os0.c  24: main()
00000054  00000002  LEV   0
root/usr/os/os0.c  25: {
root/usr/os/os0.c  26:   current = 0;
00000058  00000023  LI    0
0000005c  00000045  SG    0
root/usr/os/os0.c  27:
root/usr/os/os0.c  28:   stmr(1000);
00000060  0003e89e  PSHI  1000
00000064  ffffb405  JSR   -76
00000068  00000801  ENT   8
root/usr/os/os0.c  29:   ivec(alltraps);
0000006c  ffffc408  LEAG  -60
00000070  0000009d  PSHA
00000074  ffff9805  JSR   -104
00000078  00000801  ENT   8
root/usr/os/os0.c  30:   
root/usr/os/os0.c  31:   asm(STI);
0000007c  00000097  STI //设置中断使能
root/usr/os/os0.c  32:   
root/usr/os/os0.c  33:   while (current < 10) {
00000080  00000003  JMP   <fwd>
root/usr/os/os0.c  34:     if (current & 1) out(1, '1'); else out(1, '0');
00000084  00000015  LG    0
00000088  00000169  ANDI  1
0000008c  00000084  BZ    <fwd>
00000090  0000319e  PSHI  49
00000094  0000019e  PSHI  1
00000098  ffff6405  JSR   -156
0000009c  00001001  ENT   16
000000a0  00000003  JMP   <fwd>
000000a4  0000309e  PSHI  48
000000a8  0000019e  PSHI  1
000000ac  ffff5005  JSR   -176
000000b0  00001001  ENT   16
root/usr/os/os0.c  35:   }
root/usr/os/os0.c  36:
root/usr/os/os0.c  37:   halt(0);
000000b4  00000015  LG    0
000000b8  00000a3b  LBI   10
000000bc  0000008c  BLT   <fwd>
000000c0  0000009e  PSHI  0
000000c4  ffff6005  JSR   -160
000000c8  00000801  ENT   8
root/usr/os/os0.c  38: }
root/usr/os/os0.c  39:
000000cc  00000002  LEV   0
```

 - 尝试用xem的简单调试功能单步调试代码
 - 回答如下问题：
   - 何处设置的中断使能？   
    - asm(STI)
   - 系统何时处于中断屏蔽状态？
    - 在执行asm(STI)前和处于中断状态时。
   - 如果系统处于中断屏蔽状态，如何让其中断使能？
    - 利用STI
   - 系统产生中断后，CPU会做哪些事情？（在没有软件帮助的情况下）
    - 在用户态时切换到内核态，保存pc,保存中断号，根据中断向量跳转到中断处理处。
   - CPU执行RTI指令的具体完成工作是哪些？
    - 中断返回，回复pc和sp，如果需要恢复到用户态则进行切换，但是如果还有挂起的中断，则继续处理中断。

# [HARD]分析和实验os1/os3.c，需要完成的内容包括：

 - os1中的task1和task2的堆栈的起始和终止地址是什么？
 - os1是如何实现任务切换的？
 - os3中的task1和task2的堆栈的起始和终止地址是什么？
 - os3是如何实现任务切换的？
 - os3的用户态task能够破坏内核态的系统吗？
