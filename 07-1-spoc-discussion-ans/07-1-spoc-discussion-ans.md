
week 9 Mon.

####N Processes: Bakery Algorithm
####缺少choosing语句会出现的问题：（以两进程为例）两个进程同时进入临界区。
说明：
有进程0，1，初始 number[0] = number[1] = 0;
赋值，取max，二者都为1，但赋值时间有差。
number[0] = max+1 = 1；
在两个for中，
    1的for因为number[1]==0，所以1进入临界区；
    0的for因为number[1]=1了（缺少choosing），pid小所以进入临界区；

choosing的存在就是为了让两个进程都赋值了，再判断。


###1.（spoc）阅读简化x86计算机模拟器的使用说明，理解基于简化x86计算机的汇编代码。

###2.（spoc)了解race condition. 进入race-condition代码目录。

执行 ./x86.py -p loop.s -t 1 -i 100 -R dx， 请问dx的值是什么？
执行 ./x86.py -p loop.s -t 2 -i 100 -a dx=3,dx=3 -R dx ， 请问dx的值是什么？
执行 ./x86.py -p loop.s -t 2 -i 3 -r -a dx=3,dx=3 -R dx， 请问dx的值是什么？
变量x的内存地址为2000, ./x86.py -p looping-race-nolock.s -t 1 -M 2000, 请问变量x的值是什么？
变量x的内存地址为2000, ./x86.py -p looping-race-nolock.s -t 2 -a bx=3 -M 2000, 请问变量x的值是什么？为何每个线程要循环3次？
变量x的内存地址为2000, ./x86.py -p looping-race-nolock.s -t 2 -M 2000 -i 4 -r -s 0， 请问变量x的值是什么？
变量x的内存地址为2000, ./x86.py -p looping-race-nolock.s -t 2 -M 2000 -i 4 -r -s 1， 请问变量x的值是什么？
变量x的内存地址为2000, ./x86.py -p looping-race-nolock.s -t 2 -M 2000 -i 4 -r -s 2， 请问变量x的值是什么？
变量x的内存地址为2000, ./x86.py -p looping-race-nolock.s -a bx=1 -t 2 -M 2000 -i 1， 请问变量x的值是什么？

###3.（spoc） 了解software-based lock, hardware-based lock, software-hardware-lock代码目录

理解flag.s,peterson.s,test-and-set.s,ticket.s,test-and-test-and-set.s 请通过x86.py分析这些代码是否实现了锁机制？请给出你的实验过程和结论说明。能否设计新的硬件原子操作指令Compare-And-Swap,Fetch-And-Add？
Compare-And-Swap
```
int CompareAndSwap(int *ptr, int expected, int new) {
  int actual = *ptr;
  if (actual == expected)
    *ptr = new;
  return actual;
}
Fetch-And-Add

int FetchAndAdd(int *ptr) {
  int old = *ptr;
  *ptr = old + 1;
  return old;
}
```
