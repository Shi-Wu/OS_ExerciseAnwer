# IO设备(lec 23) spoc 思考题

## 个人思考题
### 23.1 IO特点 
 1. 字符设备的特点是什么？
 1. 块设备的特点是什么？
 1. 网络设备的特点是什么？
 1. 阻塞I/O、非阻塞I/O和异步I/O这三种I/O方式有什么区别？

### 23.2 I/O结构
 1. 请描述I/O请求到完成的整个执行过程。
 1. CPU与设备通信的手段有哪些？

> 显式的IO指令，如x86的in, out； 或者是memory读写方式，即把device的寄存器，内存等映射到物理内存中 

### 23.3 IO数据传输
 1. IO数据传输有哪几种？
 1. 轮询方式的特点是什么？
 1. 中断方式的特点是什么？
 1. DMA方式的特点是什么？

### 23.4 磁盘调度
 1. 请简要阐述磁盘的工作过程。
 1. 请用一表达式（包括寻道时间，旋转延迟，传输时间）描述磁盘I/O传输时间。
 1. 请说明磁盘调度算法的评价指标。

 > 总的I/O时间开销、公平性

 1. 请描述下列磁盘调度算法的工作原理，并分析其优缺点。
  1. 先进先出(FIFO)磁盘调度算法
  2. 最短寻道时间优先(SSTF)磁盘调度算法
  3. 扫描(SCAN)磁盘调度算法
  4. 循环扫描(C-SCAN)磁盘调度算法
  5. C-LOOK磁盘调度算法
  6. N步扫描(N-step-SCAN)磁盘调度算法
  7. 双队列扫描(FSCAN)磁盘调度算法

### 23.5 磁盘缓存
 1. 磁盘缓存的作用是什么？
 1. 请描述单缓存(Single Buffer Cache)的工作原理
 1. 请描述双缓存(Double Buffer Cache)的工作原理
 1. 请描述访问频率置换算法(Frequency-based Replacement)的基本原理

## 小组思考题
 1. (spoc)请以键盘输入、到标准输出设备stdout的printf输出、串口输出、磁盘文件复制为例，描述ucore操作系统I/O从请求到完成的整个执行过程，并分析I/O过程的时间开销。
 2. (spoc)完成磁盘访问与磁盘寻道算法的作业，具体帮助和要求信息请看[disksim指导信息](https://github.com/chyyuu/ucore_lab/blob/master/related_info/lab8/disksim-homework.md)和[disksim参考代码](https://github.com/chyyuu/ucore_lab/blob/master/related_info/lab8/disksim-homework.py)


