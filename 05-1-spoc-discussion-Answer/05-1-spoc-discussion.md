#lec10 进程／线程概念spoc练习

NOTICE
- 有"w5l1"标记的题是助教要提交到学堂在线上的。
- 有"w5l1"和"spoc"标记的题是要求拿清华学分的同学要在实体课上完成，并按时提交到学生对应的git repo上。
- 有"hard"标记的题有一定难度，鼓励实现。
- 有"easy"标记的题很容易实现，鼓励实现。
- 有"midd"标记的题是一般水平，鼓励实现。

## 个人思考题

### 11.1 进程的概念

1. 什么是程序？什么是进程？
2. 进程有哪些组成部分？
3. 程序和进程联系和区别是什么？

### 11.2 进程控制块

1. 进程控制块的功能是什么？
2. 进程控制块中包括什么信息？
3. ucore的进展控制块数据结构定义中哪些字段？有什么作用？

  > [参见](http://crl.ptopenlab.com:8811/courses/Tsinghua/CS101/2015_T1/courseware/65a2e6de0e7f4ec8a261df82683a2fc3/400f7c812c254b799e66194d24b297ae/)： lab4/kern/process/proc.h
  
### 11.3 进程状态

1. 进程生命周期中的相关事件有些什么？它们对应的进程状态变化是什么？

  > 进程状态模型中状态定义和状态转换事件的含义

2. 进程切换过程中的几个关键代码分析

  > 保存现场和恢复现场
  > C语言的函数proc_run(struct proc_struct *proc)中调用汇编函数switch_to的参数传递过程

3. 时钟中断触发调度函数启动的代码分析

  > 时钟中断-调度函数-进展切换

4. 当前进程的现场保存代码

  > 保存现场和恢复现场：  lab4/kern/process/switch.S

5. 进程切换代码

　＞　下一个运行进程的现场恢复

### 11.4 三状态进程模型

1. 运行、就绪和等待三种状态的含义？7个状态转换事件的触发条件是什么？
2. 分析进程状态转换和状态修改代码

### 11.5 挂起进程模型

1. 引入挂起状态的目的是什么？
2. 引入挂起状态后，状态转换事件和触发条件有什么变化？
3. 内存中的什么内容放到外存中，就算是挂起状态？

### 11.6 线程的概念

1. 引入线程的目的是什么？
2. 什么是线程？
3. 进程与线程的联系和区别是什么？

### 11.7 用户线程

1. 什么是用户线程？
2. 用户线程的线程控制块保存在用户地址空间还是在内核地址空间？
3. 请尝试描述用户线程堆栈的可能维护方法。


### 11.8 内核线程

1. 用户线程与内核线程的区别是什么？
2. 同一进程内的不同线程可以共用一个相同的内核栈吗？
3. 同一进程内的不同线程可以共用一个相同的用户栈吗？

## SPOC小组思考题

(1) (spoc)设计一个简化的进程管理子系统，可以管理并调度如下简化进程.给出了[参考代码](https://github.com/chyyuu/ucore_lab/blob/master/related_info/lab4/process-concept-homework.py)，请理解代码，并完成＂YOUR CODE"部分的内容．　可２个人一组

### 进程的状态 

 - RUNNING - 进程正在使用CPU
 - READY   - 进程可使用CPU
 - DONE    - 进程结束

### 进程的行为
 - 使用CPU, 
 - 发出YIELD请求,放弃使用CPU


### 进程调度
 - 使用FIFO/FCFS：先来先服务,
   - 先查找位于proc_info队列的curr_proc元素(当前进程)之后的进程(curr_proc+1..end)是否处于READY态，
   - 再查找位于proc_info队列的curr_proc元素(当前进程)之前的进程(begin..curr_proc-1)是否处于READY态
   - 如都没有，继续执行curr_proc直到结束

### 关键模拟变量
 - 进程控制块
```
PROC_CODE = 'code_'
PROC_PC = 'pc_'
PROC_ID = 'pid_'
PROC_STATE = 'proc_state_'
```
 - 当前进程 curr_proc 
 - 进程列表：proc_info是就绪进程的队列（list），
 - 在命令行（如下所示）需要说明每进程的行为特征：（１）使用CPU ;(2)等待I/O
```
   -l PROCESS_LIST, --processlist= X1:Y1,X2:Y2,...
   X 是进程的执行指令数; 
   Ｙ是执行CPU的比例(0..100) ，如果是100，表示不会发出yield操作
```
 - 进程切换行为：系统决定何时(when)切换进程:进程结束或进程发出yield请求

### 进程执行
```
instruction_to_execute = self.proc_info[self.curr_proc][PROC_CODE].pop(0)
```

### 关键函数
 - 系统执行过程：run
 - 执行状态切换函数:　move_to_ready/running/done　
 - 调度函数：next_proc

### 执行实例

#### 例１
```
$./process-simulation.py -l 5:50
Process 0
  yld
  yld
  cpu
  cpu
  yld

Important behaviors:
  System will switch when the current process is FINISHED or ISSUES AN YIELD
Time     PID: 0 
  1     RUN:yld 
  2     RUN:yld 
  3     RUN:cpu 
  4     RUN:cpu 
  5     RUN:yld 

```

   
#### 例２
```
$./process-simulation.py  -l 5:50,5:50
Produce a trace of what would happen when you run these processes:
Process 0
  yld
  yld
  cpu
  cpu
  yld

Process 1
  cpu
  yld
  cpu
  cpu
  yld

Important behaviors:
  System will switch when the current process is FINISHED or ISSUES AN YIELD
Time     PID: 0     PID: 1 
  1     RUN:yld      READY 
  2       READY    RUN:cpu 
  3       READY    RUN:yld 
  4     RUN:yld      READY 
  5       READY    RUN:cpu 
  6       READY    RUN:cpu 
  7       READY    RUN:yld 
  8     RUN:cpu      READY 
  9     RUN:cpu      READY 
 10     RUN:yld      READY 
 11     RUNNING       DONE 
```
