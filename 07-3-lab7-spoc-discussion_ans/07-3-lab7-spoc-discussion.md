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

