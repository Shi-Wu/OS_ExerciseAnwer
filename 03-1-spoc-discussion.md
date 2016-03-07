## 小组思考题

请参考ucore lab2代码，采用`struct pmm_manager` 根据你的`学号 mod 4`的结果值，选择四种（0:最优匹配，1:最差匹配，2:最先匹配，3:buddy systemm）分配算法中的一种或多种，在应用程序层面(可以 用python,ruby,C++，C，LISP等高语言)来实现，给出你的设思路，并给出测试用例。 (spoc)

```
如何表示空闲块？ 如何表示空闲块列表？ 
[(start0, size0),(start1,size1)...]
在一次malloc后，如果根据某种顺序查找符合malloc要求的空闲块？如何把一个空闲块改变成另外一个空闲块，或消除这个空闲块？如何更新空闲块列表？
在一次free后，如何把已使用块转变成空闲块，并按照某种顺序（起始地址，块大小）插入到空闲块列表中？考虑需要合并相邻空闲块，形成更大的空闲块？
如果考虑地址对齐（比如按照4字节对齐），应该如何设计？
如果考虑空闲/使用块列表组织中有部分元数据，比如表示链接信息，如何给malloc返回有效可用的空闲块地址而不破坏
元数据信息？
伙伴分配器的一个极简实现
http://coolshell.cn/tag/buddy
```


## v9-cpu相关

[challenge]在v9-cpu上完成基于method-0/1/2/buddy system（选一个方法）with first/best/worst-fit(选一个fit)用户态动态内存分配函数malloc/free，要求在内核态实现sbrk系统调用以支持用户态动态内存分配方法。基于os4.c实现，可参考v9-cpu git repo的testing分支中的os.c和mem.h

- [x]  

> 

[challenge]在v9-cpu上完成基GC算法，要求在内核态实现sbrk系统调用以支持用户态动态内存分配方法。基于os4.c实现，可参考v9-cpu git repo的testing分支中的os.c和mem.h

- [x]  

>