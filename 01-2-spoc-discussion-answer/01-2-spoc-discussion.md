## v9-cpu相关题目


### 在v9-cpu中如何实现时钟中断的；
>在内核态，设置timer的timeout为a；timeout非零，timer每次以delta递增，超过timeout则产生时钟中断，若中断使能iena为1，则置中断类型trap为时钟中断FTIMER，中断使能iena置0，跳转至中断处理程序interrupt。

### v9-cpu指令，关键变量描述有误或不全的情况；
>描述不全：
 - ssp: 内核态栈顶
 - usp: 用户态栈顶
 - cycle: 计数周期
 - xcycle: 计数周期对应的pc
 - timer: 时钟计时器
 - timeout: 超时时间阈值
 - detla: 时钟偏移周期（偏移量）

### 在v9-cpu中的跳转相关操作是如何实现的；
>
 - branch指令：判断branch指令条件是否满足，满足则跳转pc为operand0；
 - JMP指令：直接跳转置pc为operand0；
 - JMPI指令：直接跳转置pc为operand0 + (a * sizeof(union insnfmt_t));
 - JSR指令：保存当前pc（将其值压入栈，栈底指针减8），然后跳转置pc为operand0 或 pc+=operand0；
 - JSRA指令：保存当前pc（将其值压入栈，栈底指针减8），然后跳转置pc为一个寄存器值，即 pc+=(a * sizeof(union insnfmt_t)).

### 在v9-cpu中如何设计相应指令，可有效实现函数调用与返回；
>函数调用时，保存当前pc，将其值压入栈顶，栈顶指针减8（tsp-8），然后将函数使用到的参数逐一压入栈底（sp，sp-8...）；调用时，设置新的栈，参数调用则为sp+8，sp+16... 返回值写入a寄存器。返回时回复旧栈sp，返回值即位于a寄存器。

### emhello/os0/os1等程序被加载到内存的哪个位置,其堆栈是如何设置的；
>程序被加载到内存的初始位置（即变量mem头指针所指位置）。栈底sp = memsz - FS_SZ，即为内存大小减去从RAM读入的程序大小的值。

### 在v9-cpu中如何完成一次内存地址的读写的；
>先通过fsp:辅助判断是否要经过tr/tw的分析。将 sp在host内存中的值（xsp） - sp在host内存中所在页的起始地址值（tsp） 所得的差（v，为实际页号）再 >> 12，查看其是否位于 当前读写的页转换表，不存在的话通过rlook()或wlook()函数查看其地址是否位于所有页表目录。均不存在则读写失败；否则，完成读写操作（p为是否存在于页表的标记），修改xsp值（读+8或写-8）。

### 在v9-cpu中如何实现分页机制；
>在TLB中，设置了4个1MB大小页转换表（page translation buffer array）
 - kernel read page translation table
 - kernel write page translation table
 - user read page translation table
 - user write page translation table
>有两个指针tr/tw, tw指向内核态或用户态的read/write　page translation table．
 - tr/tw[page number]=phy page number //页帧号
>还有一个tpage buffer array, 保存了所有tr/tw中的虚页号，这些虚页号是tr/tw数组中的index
 - tpage[tpages++] = v //v是page number

--------------------------------------------------------------------
