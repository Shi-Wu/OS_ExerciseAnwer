#05-3-lab4-spoc-discussion

####13.1 总体介绍
######(1) ucore的线程控制块数据结构是什么？
>答：ucore的线程控制块数据结构是 proc_struct 
>
``
	struct proc_struct {
	    enum proc_state state;                      // Process state
	    int pid;                                    // Process ID
	    int runs;                                   // the running times of Proces
	    uintptr_t kstack;                           // Process kernel stack
	    volatile bool need_resched;                 // bool value: need to be rescheduled to release CPU?
	    struct proc_struct *parent;                 // the parent process
	    struct mm_struct *mm;                       // Process's memory management field
	    struct context context;                     // Switch here to run process
	    struct trapframe *tf;                       // Trap frame for current interrupt
	    uintptr_t cr3;                              // CR3 register: the base addr of Page Directroy Table(PDT)
	    uint32_t flags;                             // Process flag
	    char name[PROC_NAME_LEN + 1];               // Process name
	    list_entry_t list_link;                     // Process link list 
	    list_entry_t hash_link;                     // Process hash list
	};
``

####13.2 关键数据结构
######(2) 如何知道ucore的两个线程同在一个进程？
>答：可以看两个线程中的 struct proc_struct *parent 是否相同。

######(3) context和trapframe分别在什么时候用到？
>答：context在进程（线程）切换时会用到；trapframe在发生中断/异常/系统调用时会用到。

######(4) 用户态或内核态下的中断处理有什么区别？在trapframe中有什么体现？
>答：
	在trapframe中的不同就是

####13.3 执行流程
######(5) do_fork中的内核线程执行的第一条指令是什么？它是如何过渡到内核线程对应的函数的？
>答：
>
>		tf.tf_eip = (uint32_t) kernel_thread_entry;
		/kern-ucore/arch/i386/init/entry.S
		/kern/process/entry.S

######(6)内核线程的堆栈初始化在哪？
>答：
>
>		tf和context中的esp

######(7)fork()父子进程的返回值是不同的。这在源代码中的体现中哪？
>答：


######(8)内核线程initproc的第一次执行流程是什么样的？能跟踪出来吗？
>答：
