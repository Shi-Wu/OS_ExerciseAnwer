###小组练习与思考题


####(1)(spoc) 跟踪和展现ucore的处理机调度过程
在ucore执行处理机调度时，跟踪并显示上一个让出CPU线程的暂停代码位置和下一个进入执行状态线程的开始执行位置。
>
>



####(2)(spoc) 理解调度算法支撑框架的执行过程
即在ucore运行过程中通过cprintf函数来完整地展现出来多个进程在调度算法和框架的支撑下，在相关调度点如何动态调度和执行的细节。(越全面细致越好)
>
>


####在 ucore 中，目前Stride是采用无符号的32位整数表示。则BigStride应该取多少，才能保证比较的正确性？
>由 STRIDE_MAX – STRIDE_MIN <= PASS_MAX 条件，设进程stride值最小为s，则所有stride值在[s, s+PASS_MAX]内。
>区间右半部分溢出，不会和左半部分重叠，所以可以以s为基准比较大小关系。因为Priority > 1的限制，所以有STRIDE_MAX – STRIDE_MIN <= BIG_STRIDE。通过设置BIG_STRIDE值就可完成判断。（ucore中设置为0x7FFFFFFF）

