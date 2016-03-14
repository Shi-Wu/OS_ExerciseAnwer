# lab2 SPOC思考题

## v9-cpu相关

[challenge]在v9-cpu上，设定物理内存为64MB。在os2.c和os4.c的基础上实现页机制管理，内核空间的映射关系： kernel_virt_addr=0xc00000000+phy_addr，内核空间大小为64MB，虚拟空间范围为0xc0000000--x0xc4000000, 物理空间范围为0x00000000--x0x04000000；用户空间的映射关系：user_virt_addr=0x40000000+usr_phy_addr，用户空间可用大小为1MB，虚拟空间范围为0x40000000--0x40100000，物理空间范围为0x02000000--x0x02100000。可参考v9-cpu git repo的testing分支中的os.c和mem.h。修改代码为[os5.c](https://github.com/chyyuu/v9-cpu/blob/master/root/usr/os/os5.c)

- (1)在内核态可正确访问这两个空间
- (2)在用户态可正确访问这两个空间

- [x]  
