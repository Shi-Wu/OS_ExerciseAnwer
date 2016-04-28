# 同步互斥(lec 18) spoc 思考题



## 小组思考题

1. （spoc） 每人使用C++或python语言用信号量和条件变量两种手段分别实现[40个同步互斥问题](07-2-spoc-pv-problems.md)中的一题。请先理解[python threading 机制的介绍和实例](https://github.com/chyyuu/ucore_lab/tree/master/related_info/lab7/semaphore_condition)

 > 参考：[2015年操作系统课的信号量问题回答](https://piazza.com/class/i5j09fnsl7k5x0?cid=391)
 
 > 建议参考梁锡豪同学的输出信息显示方式，这种方式的可读性很好。
 
 > 建议重视测试用例的设计，以检查自己的实现是否有错。

设有8个程序prog1，prog2，...，prog8。它们在并发系统中执行时有如下所示的制约关系， 使用P、V操作实现这些程序间的同步。

	```
	-----------     ----------> ----------
	   Prog1   \   /   Prog3      Prog6   \
	            \ /                        \
	             +--------------------------> ---------->
	            / \          Prog4         /     Prog8
	           /   \                      /
	-----------     ----------> ----------
	   Prog2           Prog5      Prog7
	```

	```
	本题目是用来检查考生对使用P、V操作实现进程间同步的掌握情况。一般地，若要求进程 B在进程A之后方可执行时，只需在进程P操作，而在进程A执行完成时对同一信号量进行V 操作即可。本题要求列出8个进程（程序）的控制关系，使题目显得较为复杂。但当对进 程间的同步理解透彻后，应不难写出对应的程序。解这一类问题还应注意的一点是，要看 清图示的制约关系，不要漏掉或多处制约条件。
	 BEGIN
	 var s13, s14, s15, s23, s24, s25,s36, s48, s57, s68, s78: semaphore;
	 s13 :=0; s14 :=0; s15 :=0; s23 :=0; s24 :=0; s25 :=0; s36 :=0;
	 s48 :=0; s57 :=0; s68 :=0; s78 :=0;
	 COBEGIN
	   prog1:         prog2:        prog3:        prog4:
	     BEGIN          BEGIN         BEGIN         BEGIN
	       do work;       do work;      V(S13);       P(S14);
	       V(s13);        V(s23);       V(S23);       P(S24);
	       V(s14);        V(s24);       do work;      do work;
	       V(s15);        V(s25);       V(s36);       V(s48);
	     END            END           END           END
	   prog5:         prog6         prog7         prog8
	     BEGIN          BEGIN         BEGIN         BEGIN
	       P(s15);        P(s36);       P(s57);       P(s48);
	       P(s25);        do work;      do work;      P(s68);
	       do work;       V(s68);       V(S78);       P(s78);
	       V(57);       END           END             do work;
	     END                                        END
	 COEND
	 END
	```
