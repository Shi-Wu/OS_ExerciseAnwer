# 磁盘访问 练习

## 磁盘抽象模型

一个磁盘反指针旋转，有3个磁道和一个磁头，每个磁道有12个扇区。
完成一个磁盘访问请求的时间包括:寻道时间(seek time)+旋转时间（rotational time）+传输时间（transfer time）

执行如下

```
$ ./disksim.py -a 10 -G
```

`-a 10`表示访问扇区10， `-G`表示显示图形动画。
可以看到磁头在外侧磁道的扇区6的中间位置， 扇区10与扇区6在一个磁道上。在图形界面上按`s`键，将启动模拟执行过程。并在执行结束后，按`q`键，则退出图形，并显示统计结果如下：

```
REQUESTS ['10']

Block:  10  Seek:  0  Rotate:105  Transfer: 30  Total: 135

TOTALS      Seek:  0  Rotate:105  Transfer: 30  Total: 135
```

表示寻道时间是0个时间单位，旋转时间是105个时间单位，传输时间是30个时间单位，总共的磁盘访问请求的时间是135.注意从扇区6到扇区9，旋转了90度，而为了进行传输，需要从扇区9～10的中间位置开始，从扇区10～11的中间位置结束。所以需要再旋转15度，即旋转了105度，而每旋转1度花费1个时间单位，所以旋转花费了105个时间单位。

如果执行

```
$ ./disksim.py -a 10，11 -G
```
表明发出了2个磁盘访问请求，可得到如下的结果
```
REQUESTS ['10', '11']

Block:  10  Seek:  0  Rotate:105  Transfer: 30  Total: 135
Block:  11  Seek:  0  Rotate:  0  Transfer: 30  Total:  30

TOTALS      Seek:  0  Rotate:105  Transfer: 60  Total: 165

```
由于访问完扇区10后，紧接着立刻访问扇区11，所以寻道和旋转时间都是0,总的访问时间是165.

如果需要寻道，比如执行

```
$ ./disksim.py -a 10，18 -G
```

执结果如下
```
REQUESTS ['10', '18’]
Sector:  10  Seek:  0  Rotate:105  Transfer: 30  Total: 135
Sector:  18  Seek: 40  Rotate:170  Transfer: 30  Total: 240
TOTALS      Seek: 40  Rotate:275  Transfer: 60  Total: 375
```
这里一个寻道的时间是40个时间单位。且假设采用FIFO（FCFS）磁盘调度算法。当访问完扇区10后，磁头需要寻道到中间磁道处（包括扇区18），扇区10对应的中间磁道的扇区是22号扇区，从扇区22扇区18需要旋转7个扇区的距离（23,12,13,14,15,16,17），花费210个时间单位，注意这里面包含了40个寻道的时间单位，所以，旋转所化时间为210-40=170个时间单位。这样，总体的访问时间为375


请回答如下问题：

## 问题 1：请执行 FIFO磁盘调度策略

```
./disksim.py  采用FIFO -a 0
./disksim.py   -a 6
./disksim.py   -a 30
./disksim.py   -a 7,30,8
./disksim.py   -a 10,11,12,13，24,1
```
请回答每个磁盘请求序列的IO访问时间

## 问题 2：请执行 SSTF磁盘调度策略

```
./disksim.py   -a 10,11,12,13，24,1
```
请回答每个磁盘请求序列的IO访问时间

## 问题 3：请执行 SCAN, C-SCAN磁盘调度策略

```
./disksim.py   -a 10,11,12,13，24,1
```
请回答每个磁盘请求序列的IO访问时间


```
1.

./disksim.py   -a 0
Block:   0  Seek:  0  Rotate:165  Transfer: 30  Total: 195

TOTALS      Seek:  0  Rotate:165  Transfer: 30  Total: 195  

./disksim.py   -a 6
Block:   6  Seek:  0  Rotate:345  Transfer: 30  Total: 375

TOTALS      Seek:  0  Rotate:345  Transfer: 30  Total:375       

./disksim.py   -a 30
Block:  30  Seek: 80  Rotate:265  Transfer: 30  Total: 375

TOTALS      Seek: 80  Rotate:265  Transfer: 30  Total: 375  

./disksim.py   -a 7,30,8
Block:   7  Seek:  0  Rotate: 15  Transfer: 30  Total:  45
Block:  30  Seek: 80  Rotate:220  Transfer: 30  Total: 330
Block:   8  Seek: 80  Rotate:310  Transfer: 30  Total: 420

TOTALS      Seek:160  Rotate:545  Transfer: 90  Total: 795

./disksim.py   -a 10,11,12,13，24,1
Block:  10  Seek:  0  Rotate:105  Transfer: 30  Total: 135
Block:  11  Seek:  0  Rotate:  0  Transfer: 30  Total:  30
Block:  12  Seek: 40  Rotate:320  Transfer: 30  Total: 390
Block:  13  Seek:  0  Rotate:  0  Transfer: 30  Total:  30
Block:  24  Seek: 40  Rotate:260  Transfer: 30  Total: 330
Block:   1  Seek: 80  Rotate:280  Transfer: 30  Total: 390

TOTALS      Seek:160  Rotate:965  Transfer:180  Total:1305  

2.请执行 SSTF磁盘调度策略
python disksim-homework.py -p SSTF -a 10,11,12,13,24,1 -c

Block:  10  Seek:  0  Rotate:105  Transfer: 30  Total: 135
Block:  11  Seek:  0  Rotate:  0  Transfer: 30  Total:  30
Block:   1  Seek:  0  Rotate: 30  Transfer: 30  Total:  60
Block:  12  Seek: 40  Rotate:260  Transfer: 30  Total: 330
Block:  13  Seek:  0  Rotate:  0  Transfer: 30  Total:  30
Block:  24  Seek: 40  Rotate:260  Transfer: 30  Total: 330

TOTALS      Seek: 80  Rotate:655  Transfer:180  Total: 915
3：请执行 SCAN, C-SCAN磁盘调度策略

```