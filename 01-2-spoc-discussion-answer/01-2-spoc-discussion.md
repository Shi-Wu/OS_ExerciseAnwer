## v9-cpu相关题目


### 在v9-cpu中如何实现时钟中断的；
>在内核态，设置timer的timeout为a；timeout非零，timer每次以delta递增，超过timeout则产生时钟中断，若中断使能iena为1，则置中断类型trap为时钟中断FTIMER，中断使能iena置0，跳转至中断处理程序interrupt。

### v9-cpu指令，关键变量描述有误或不全的情况；
>描述有误：
>描述不全：
 - ssp: 内核态栈顶
 - usp: 用户态栈顶
 - cycle: 计数周期
 - xcycle: 计数周期对应的pc
 - timer: 时钟计时器
 - timeout: 超时时间阈值
 -　detla: 时钟偏移周期（偏移量）

### 在v9-cpu中的跳转相关操作是如何实现的；
>branch指令：判断branch指令条件是否满足，满足则跳转pc为operand0；
>JMP指令：直接跳转置pc为operand0；
JMPI指令：直接跳转置pc为operand0 + (a * sizeof(union insnfmt_t));
>JSR指令：保存当前pc（将其值压入栈，栈顶指针减8），然后跳转置pc为operand0 或 pc+=operand0；
JSRA指令：保存当前pc（将其值压入栈，栈顶指针减8），然后跳转置pc为一个寄存器值，即 pc+=(a * sizeof(union insnfmt_t)).

### 在v9-cpu中如何设计相应指令，可有效实现函数调用与返回；


### emhello/os0/os1等程序被加载到内存的哪个位置,其堆栈是如何设置的；


### 在v9-cpu中如何完成一次内存地址的读写的；


### 在v9-cpu中如何实现分页机制；
>在TLB中，设置了4个1MB大小页转换表（page translation buffer array）
>kernel read page translation table
>kernel write page translation table
>user read page translation table
>user write page translation table
>有两个指针tr/tw, tw指向内核态或用户态的read/write　page translation table．
>tr/tw[page number]=phy page number //页帧号
>还有一个tpage buffer array, 保存了所有tr/tw中的虚页号，这些虚页号是tr/tw数组中的index
>tpage[tpages++] = v //v是page number

--------------------------------------------------------------------

## 请编写一个小程序，在v9-cpu下，能够接收你输入的字符并输出你输入的字符






## 请编写一个小程序，在v9-cpu下，能够产生各种异常/中断






## 请编写一个小程序，在v9-cpu下，能够统计并显示内存大小




