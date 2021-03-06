## 小组思考题

1. (扩展练习) 每人用ucore中的信号量和条件变量两种手段分别实现40个同步问题中的一题。向勇老师的班级从前往后，陈渝老师的班级从后往前。请先理解与采用python threading 机制实现的异同点。

2. （扩展练习）请在lab7-answer中分析
  -  cvp->count含义是什么？cvp->count是否可能<0, 是否可能>1？请举例或说明原因。
  -  cvp->owner->next_count含义是什么？cvp->owner->next_count是否可能<0, 是否可能>1？请举例或说明原因。
  -  目前的lab7-answer中管程的实现是Hansen管程类型还是Hoare管程类型？请在lab7-answer中实现另外一种类型的管程。

```
cvp->count表示等在这个条件变量上的睡眠进程的个数。减操作前都有加操作，不可能<0。因为可能会有多个等待进程，所以可能>1。

cvp->owner->next_count表示了由于发出singal_cv而睡眠的进程个数。不可能<0，不可能>1。

Hoare管程。
```


####请举一个比较具体的例子，说明银行家算法判断出不安全的状态下不会出现死锁
考虑如下情况：

最大需求矩阵 C

|    | R1 | R2 | R3 |
|----|----|----|----|
| T1 |  3 |  2 |  2 |
| T2 |  6 |  1 |  3 |
| T3 |  3 |  1 |  4 |
| T4 |  4 |  2 |  2 |

已分配资源矩阵 A

|    | R1 | R2 | R3 |
|----|----|----|----|
| T1 |  2 |  0 |  1 |
| T2 |  5 |  1 |  1 |
| T3 |  2 |  1 |  1 |
| T4 |  0 |  0 |  2 |


当前资源请求矩阵C-A

|    | R1 | R2 | R3 |
|----|----|----|----|
| T1 |  1 |  2 |  1 |
| T2 |  1 |  0 |  2 |
| T3 |  1 |  0 |  3 |
| T4 |  4 |  2 |  0 |

系统资源向量R

| R1 | R2 | R3 |
|----|----|----|
|  9 |  3 |  6 |

当前可用资源向量V

| R1 | R2 | R3 |
|----|----|----|
|  0 |  1 |  1 |

依据银行家算法，到该阶段时，线程T1请求R1和R3资源各1个实例，但当前可用资源不足，故为不安全状态。
但在实际的运行过程中，可能出现这种情况：T2进程未获取到其目标最大资源量，就已经被结束，这时T2进程占用的资源就会被释放，就能够满足T1使用，之后T3，T4也能使用之前进程结束后释放的资源，故此时银行家算法判断出不安全的状态下，但不会出现死锁。
