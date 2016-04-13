# lab5 spoc 思考题


### (2)(spoc) 理解用户进程的生命周期。

> 需写练习报告和简单编码，完成后放到git server 对应的git repo中

### 练习用的[lab5 spoc exercise project source code](https://github.com/chyyuu/ucore_lab/tree/master/related_info/lab5/lab5-spoc-discuss)

> 注意，请关注：内核如何创建用户进程的？用户进程是如何在用户态开始执行的？用户态的堆栈是保存在哪里的？

请完成如下练习，完成代码填写，并形成spoc练习报告


内核如何创建用户进程的?
```
内核会新建一个内核进程
然后将用户进程信息导入内核进程
然后将内核进程设置为用户进程。
最后将用户进程放入进程队列中，进行进程调度。
```

用户进程是如何在用户态开始执行的
```
通过进程上下文切换switch_to和特权级转换load_esp0完成信息切换
然后切换到用户态进行执行
```

用户态的堆栈是保存在哪里的？
```
用户态的堆栈是保存在进程的mm结构里。
```