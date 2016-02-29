#lec 3 SPOC Discussion

## 第三讲 启动、中断、异常和系统调用-思考题

## 3.4 linux系统调用分析
#### 1. 通过分析[lab1_ex0](https://github.com/chyyuu/ucore_lab/blob/master/related_info/lab1/lab1-ex0.md)了解Linux应用的系统调用编写和含义。(w2l1)

 - objdump:用于显示二进制文件信息，-S选项表明其尽可能反汇编出源代码。

 - nm:显示关于对象文件、可执行文件以及对象文件库里的符号信息。
>对于lab1_ex0，输出的符号信息为：
```
	00000002 a AF_INET
	0804a040 B __bss_start
	0804a040 b completed.7181
	0804a014 D __data_start
	0804a014 W data_start
	08048330 t deregister_tm_clones
	080483a0 t __do_global_dtors_aux
	08049f0c t __do_global_dtors_aux_fini_array_entry
	0804a018 D __dso_handle
	08049f14 d _DYNAMIC
	0804a040 D _edata
	0804a044 B _end
	08048454 T _fini
	08048468 R _fp_hw
	080483c0 t frame_dummy
	08049f08 t __frame_dummy_init_array_entry
	08048530 r __FRAME_END__
	0804a000 d _GLOBAL_OFFSET_TABLE_
	         w __gmon_start__
	0804a01c d hello
	08048294 T _init
	08049f0c t __init_array_end
	08049f08 t __init_array_start
	0804846c R _IO_stdin_used
	00000006 a IPPROTO_TCP
	         w _ITM_deregisterTMCloneTable
	         w _ITM_registerTMCloneTable
	08049f10 d __JCR_END__
	08049f10 d __JCR_LIST__
	         w _Jv_RegisterClasses
	08048450 T __libc_csu_fini
	080483f0 T __libc_csu_init
	         U __libc_start_main@@GLIBC_2.0
	0804a029 D main
	00000001 a MAP_SHARED
	00000001 a PROT_READ
	08048360 t register_tm_clones
	00000002 a SEEK_END
	00000001 a SOCK_STREAM
	080482f0 T _start
	00000001 a STDOUT
	00000006 a SYS_close
	0000003f a SYS_dup2
	0000000b a SYS_execve
	00000001 a SYS_exit
	00000002 a SYS_fork
	00000013 a SYS_lseek
	0000005a a SYS_mmap
	0000005b a SYS_munmap
	00000005 a SYS_open
	00000066 a SYS_socketcall
	00000005 a SYS_socketcall_accept
	00000002 a SYS_socketcall_bind
	00000004 a SYS_socketcall_listen
	00000001 a SYS_socketcall_socket
	00000004 a SYS_write
	0804a040 D __TMC_END__
	08048320 T __x86.get_pc_thunk.bx
```
 - file:用来识别文件类型，也可用来辨别一些文件的编码格式。它是通过查看文件的头部信息来获取文件类型，而不是像Windows通过扩展名来确定文件类型的。
>对于lab1_ex0，输出的文件类型信息为：
```
lab1-ex0.exe: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux.so.2, for GNU/Linux 2.6.32, BuildID[sha1]=09c35131b234ffb4252c8eff36bfd321e9c18544, not stripped
```
 - 系统调用就是用户态的进程调用内核态的函数，会涉及运行态切换和堆栈切换。目的是为了让用户程序访问硬件资源同时又不能破坏操作系统的安全性。

 - 通过寄存进行参数传递：
```
	movl	$SYS_write,%eax
	movl	$STDOUT,%ebx
	movl	$hello,%ecx
	movl	$12,%edx
	int	$0x80
```
- 把中断号传入eax寄存器
- 把系统调用号出入ebx寄存器
- 把字符串的起始地址传入ecx寄存器
- 把字符串的长度传入edx寄存器
- 最后使用int进行中断

#### 2. 通过调试[lab1_ex1](https://github.com/chyyuu/ucore_lab/blob/master/related_info/lab1/lab1-ex1.md)了解Linux应用的系统调用执行过程。(w2l1)
 - strace用途：strace常用来跟踪进程执行时的系统调用和所接收的信号。 在Linux世界，进程不能直接访问硬件设备，当进程需要访问硬件设备(比如读取磁盘文件，接收网络数据等等)时，必须由用户态模式切换至内核态模式，通 过系统调用访问硬件设备。strace可以跟踪到一个进程产生的系统调用,包括参数，返回值，执行消耗的时间。
 - 系统调用过程：系统调用时，首先会产生中断，由用户态切换到内核态，操作系统会根据中断号访问中断向量表，然后会进入中断处理，再根据系统调用表进行系统函数调用，系统函数对硬件进行访问完成相应功能，最后返回调用结果。
 
 - 系统函数意义：
	- mmap将一个文件或者其它对象映射进内存。文件被映射到多个页上，如果文件的大小不是所有页的大小之和，最后一个页不被使用的空间将会清零。mmap在用户空间映射调用系统中作用很大。
	- mprotect设置内存访问权限
	- fstat由文件描述词取得文件状态
	- execve在父进程中fork一个子进程，在子进程中调用exec函数启动新的程序
	- arch_prctl设置架构特定的线程状态
	- 所以进行printf时，会对用户态的内存进行一个内存映射，然后会打开一个子进程，打开标准输入输出进行读入和输出

## 3.5 ucore系统调用分析
####1. ucore的系统调用中参数传递代码分析。
由user/libs/syscall.c可以看到用户态系统调用的代码：
```
static inline int
syscall(int num, ...) {
    va_list ap;
    va_start(ap, num);
    uint32_t a[MAX_ARGS];
    int i, ret;
    for (i = 0; i < MAX_ARGS; i ++) {
        a[i] = va_arg(ap, uint32_t);
    }
    va_end(ap);

    asm volatile (
        "int %1;"
        : "=a" (ret)
        : "i" (T_SYSCALL),
          "a" (num),
          "d" (a[0]),
          "c" (a[1]),
          "b" (a[2]),
          "D" (a[3]),
          "S" (a[4])
        : "cc", "memory");
    return ret;
}
```
可以看到系统调用的参数在用户态是通过内联汇编的方式传递到内核态处理的。
由kern/syscall/syscall.c可以看到内核态系统调用的代码：
```
void
syscall(void) {
    struct trapframe *tf = current->tf;
    uint32_t arg[5];
    int num = tf->tf_regs.reg_eax;
    if (num >= 0 && num < NUM_SYSCALLS) {
        if (syscalls[num] != NULL) {
            arg[0] = tf->tf_regs.reg_edx;
            arg[1] = tf->tf_regs.reg_ecx;
            arg[2] = tf->tf_regs.reg_ebx;
            arg[3] = tf->tf_regs.reg_edi;
            arg[4] = tf->tf_regs.reg_esi;
            tf->tf_regs.reg_eax = syscalls[num](arg);
            return ;
        }
    }
    print_trapframe(tf);
    panic("undefined syscall %d, pid = %d, name = %s.\n",
            num, current->pid, current->name);
}
```
系统调用的类型（中断号）由tf_regs.reg_eax确定，其他参数的传递通过剩下的通用寄存器来赋值得到。

#### 2. 以getpid为例，分析ucore的系统调用中返回结果的传递代码。
用户态下通过syscall(int num, ...)将中断类型及相关参数通过内联汇编的方式存入，调用sys_getpid(void)函数.
内核态下，由
```
tf->tf_regs.reg_eax = syscalls[num](arg);
```
可以看出，实质上是调用内核态下SYS_getpid关键字对应的sys_getpid()函数
```
sys_getpid(uint32_t arg[]) {
    return current->pid;
}
```
来得到当前的pid值，并将其保存至%eax返回。

#### 3. 以ucore lab8的answer为例，分析ucore 应用的系统调用编写和含义。


#### 4. 以ucore lab8的answer为例，尝试修改并运行ucore OS kernel代码，使其具有类似Linux应用工具`strace`的功能，即能够显示出应用程序发出的系统调用，从而可以分析ucore应用的系统调用执行过程。
 大体的思路是在内核态syscall(void)函数内，num值即为系统调用号，将其输出到控制台即可。
```
void
syscall(void) {
    struct trapframe *tf = current->tf;
    uint32_t arg[5];
    int num = tf->tf_regs.reg_eax;
    cprintf("Sys No: %d", num);			// Added line.
    if (num >= 0 && num < NUM_SYSCALLS) {
        if (syscalls[num] != NULL) {
            arg[0] = tf->tf_regs.reg_edx;
            arg[1] = tf->tf_regs.reg_ecx;
            arg[2] = tf->tf_regs.reg_ebx;
            arg[3] = tf->tf_regs.reg_edi;
            arg[4] = tf->tf_regs.reg_esi;
            tf->tf_regs.reg_eax = syscalls[num](arg);
            return ;
        }
    }
    print_trapframe(tf);
    panic("undefined syscall %d, pid = %d, name = %s.\n",
            num, current->pid, current->name);
}
```
但在实际编译lab8_answer时报错，
```
make: *** No rule to make target 'disk0', needed by 'bin/sfs.img'. Stop.
```
暂未解决（使用的是virtualbox安装的老师所给的已配置好的vdi硬盘镜像）
 
