#lec 3 SPOC Discussion

## 第三讲 启动、中断、异常和系统调用-思考题

## 3.1 BIOS
 1. 比较UEFI和BIOS的区别。
>UEFI启动需要一个独立的分区，它将系统启动文件和操作系统本身隔离，可以更好的保护系统的启动。并且在启动的时候可以调用EFIShell，可以加载指定硬件驱动，选择启动文件。
BIOS启动受MBR限制，默认无法引导超过2.1TB以上的硬盘。
 1. 描述PXE的大致启动流程。
>

## 3.2 系统启动流程
 1. 了解NTLDR的启动流程。
 1. 了解GRUB的启动流程。
 1. 比较NTLDR和GRUB的功能有差异。
 1. 了解u-boot的功能。
>支持尽可能多的嵌入式处理器和嵌入式操作系统.
 + 系统引导支持NFS挂载、RAMDISK(压缩或非压缩)形式的根文件系统；支持NFS挂载、从FLASH中引导压缩或非压缩系统内核；
 +  基本辅助功能强大的操作系统接口功能；可灵活设置、传递多个关键参数给操作系统，适合系统在不同开发阶段的调试要求与产品发布，尤以Linux支持最为强劲；支持目标板环境参数多种存储方式，如FLASH、NVRAM、EEPROM；
 + CRC32校验可校验FLASH中内核、RAMDISK镜像文件是否完好；
 + 设备驱动串口、SDRAM、FLASH、以太网、LCD、NVRAM、EEPROM、键盘、USB、PCMCIA、PCI、RTC等驱动支持；
 + 上电自检功能SDRAM、FLASH大小自动检测；SDRAM故障检测；CPU型号；
 + 特殊功能XIP内核引导；

## 3.3 中断、异常和系统调用比较
 1. 举例说明Linux中有哪些中断，哪些异常？
>中断
>异常
 1. Linux的系统调用有哪些？大致的功能分类有哪些？  (w2l1)

```
  + 采分点：说明了Linux的大致数量（上百个），说明了Linux系统调用的主要分类（文件操作，进程管理，内存管理等）
  - 答案没有涉及上述两个要点；（0分）
  - 答案对上述两个要点中的某一个要点进行了正确阐述（1分）
  - 答案对上述两个要点进行了正确阐述（2分）
  - 答案除了对上述两个要点都进行了正确阐述外，还进行了扩展和更丰富的说明（3分）
 ```
 
 1. 以ucore lab8的answer为例，uCore的系统调用有哪些？大致的功能分类有哪些？(w2l1)
 
 ```
  + 采分点：说明了ucore的大致数量（二十几个），说明了ucore系统调用的主要分类（文件操作，进程管理，内存管理等）
  - 答案没有涉及上述两个要点；（0分）
  - 答案对上述两个要点中的某一个要点进行了正确阐述（1分）
  - 答案对上述两个要点进行了正确阐述（2分）
  - 答案除了对上述两个要点都进行了正确阐述外，还进行了扩展和更丰富的说明（3分）
 ```
 
## 3.4 linux系统调用分析
 1. 通过分析[lab1_ex0](https://github.com/chyyuu/ucore_lab/blob/master/related_info/lab1/lab1-ex0.md)了解Linux应用的系统调用编写和含义。(w2l1)

 - objdump:用于显示二进制文件信息，-S选项表明其尽可能反汇编出源代码。

 - nm:显示关于对象文件、可执行文件以及对象文件库里的符号信息。
>对于lab1_ex0，输出的符号信息为：
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

 - file:用来识别文件类型，也可用来辨别一些文件的编码格式。它是通过查看文件的头部信息来获取文件类型，而不是像Windows通过扩展名来确定文件类型的。
>对于lab1_ex0，输出的文件类型信息为：
lab1-ex0.exe: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux.so.2, for GNU/Linux 2.6.32, BuildID[sha1]=09c35131b234ffb4252c8eff36bfd321e9c18544, not stripped
...
 - 系统调用就是用户态的进程调用内核态的函数，会涉及运行态切换和堆栈切换。目的是为了让用户程序访问硬件资源同时又不能破坏操作系统的安全性。


 1. 通过调试[lab1_ex1](https://github.com/chyyuu/ucore_lab/blob/master/related_info/lab1/lab1-ex1.md)了解Linux应用的系统调用执行过程。(w2l1)
 
-strace用途：strace常用来跟踪进程执行时的系统调用和所接收的信号。 在Linux世界，进程不能直接访问硬件设备，当进程需要访问硬件设备(比如读取磁盘文件，接收网络数据等等)时，必须由用户态模式切换至内核态模式，通 过系统调用访问硬件设备。strace可以跟踪到一个进程产生的系统调用,包括参数，返回值，执行消耗的时间。

-系统调用过程：系统调用时，首先会产生中断，由用户态切换到内核态，操作系统会根据中断号访问中断向量表，然后会进入中断处理，再根据系统调用表进行系统函数调用，系统函数对硬件进行访问完成相应功能，最后返回调用结果。
 
## 3.5 ucore系统调用分析
 1. ucore的系统调用中参数传递代码分析。
 1. ucore的系统调用中返回结果的传递代码分析。
 1. 以ucore lab8的answer为例，分析ucore 应用的系统调用编写和含义。
 1. 以ucore lab8的answer为例，尝试修改并运行ucore OS kernel代码，使其具有类似Linux应用工具`strace`的功能，即能够显示出应用程序发出的系统调用，从而可以分析ucore应用的系统调用执行过程。
 
## 3.6 请分析函数调用和系统调用的区别
 1. 请从代码编写和执行过程来说明。
   1. 说明`int`、`iret`、`call`和`ret`的指令准确功能
 
