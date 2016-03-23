
##(1)(spoc) 请参考lab3_result的代码，思考如何在lab3_results中实现clock算法，给出你的概要设计方案。可4人一个小组。要求说明你的方案中clock算法与LRU算法上相比，潜在的性能差异性。进而说明在lab3的LRU算法实现的可能性评价（给出理由）。
###在lab3_results中实现clock算法的设计概要
    相关结构可以参见swap_fifo.c，其中需要重新编写的代码有
    _fifo_map_swappable => _clock_map_swappable
    _fifo_swap_out_victim => _clock_swap_out_victim
    增加另一个global variable: list_entry_t pra_list_clock 表示当前时钟指针指向位置，当然还可以修改mm_struct，使其中包含这个变量，无论如何只需要能够获取到前一次的clock位置就可以了
    考虑这个修改位新增在哪里，可以考虑修改list.h，新增一个属性access，但是更为简单的就是在Page中新增一个属性access，使用le2page来获取page，然后查询这个access属性。
    如果是一般的clock算法，不考虑是读修改还是写修改，那么对于_clock_map_swappable应当如下：
      1.获取到head和entry，和fifo一样
      2.之后添加到链表中，同时注意要修改access位
    _clock_swap_out_victim：
      1.从clock开始往后扫描链表，如果到达链表尾还需要返回链表头
        每次讲修改位为1的改为0，直至找到一个修改位为0的，将其从链表中删除。
      2.ptr_page = le2page(le, pra_page_link)，注意判断NULL

    如果是附带判断读写的修改版clock算法，那么需要新增一个变量表示是读还是写内存，而access则改为两位bit，在扫描时也需要做对应的修改。

    但是这样是有很多问题的，最大的问题就是这样的struct swap_manager接口和clock算法所需要的接口不一致，clock算法和fifo不一样，是在每次缺页时调用的，但是struct swap_manager中没有对应的函数接口，导致了lab3中clock算法的性能很可能下降很多，这是由于没有缺页时调用函数的接口。可以再swap_manager中添加对应的函数指针来完成。
    极端的情况下，由于_clock_map_swappable和_clock_swap_out_victim的调用顺序的改变，可能导致性能的低下，比如如果如同fifo的换入换出顺序，那么如window_size = 4，先加入4 page，之后每次add page & del page，那么这样的性能最差和fifo其实是一样的

    在这里要试下LRU算法，也可以参考上述的实现，讲access改为uint_32 last，然后每次扫描时选择last最小的；而在hit时讲last更新为当前时间，同时时间的维护是通过一个计数器来的，每次缺页或者hit时将计数器+1。
    这里有两个问题：
    1.没有hit调用函数，我并不知道什么时候来更新last，还是要通过修改swap_manager来完成
    2.扫描的开销太大，每次是O(n)的时间，而clock算法最差才是O(n)
    但是LRU利用了最近的全部信息，而clock只利用了部分信息，在缺页率上会下降一点点。

##(2)(spoc) 在x86中内存访问会受到段机制和页机制的两层保护，请基于lab3_results的代码（包括lab1的challenge练习实现），请实践并分析出段机制和页机制各种内存非法访问的后果。，可4人一个小组，，找出尽可能多的各种内存访问异常，并在代码中给出实现和测试用例，在执行了测试用例后，ucore能够显示出是出现了哪种异常和尽量详细的错误信息。请在说明文档中指出：某种内存访问异常的原因，硬件的处理过程，以及OS如何处理，是否可以利用做其他有用的事情（比如提供比物理空间更大的虚拟空间）？哪些段异常是否可取消，并用页异常取代？

###某种内存访问异常的原因
    在vmm.c中详细描述了几种pgfault，其中包括了
    error_code 11: default  (W/R=1, P=1): write, present
    error_code 10: write AND not present，但是vma不可写
    error_code 01: read AND present
    error_code 00: read AND not present，但是vma不可写和运行
    可产生的错误有3中，10,01,00
    其中还有非error_code判断的错误，例如
    1.地址不在内存管理的虚拟存储范围内（越界）
    2.swap_init_ok=0，表示未初始化成功，但是page table isn't existed
    3.pte获取为NULL
    4.如果当物理地址页不存在时，分配一个逻辑页也失败了的时候会产生pgdir_alloc_page in do_pgfault failed
    5.换入页表失败的时候
    以上是page fault
    产生页访问异常后，CPU把引起页访问异常的线性地址装到寄存器CR2中，并给出了出错码errorCode，说明了页访问异常的类型。ucore　OS会把这个值保存在struct trapframe 中tf_err成员变量中。而中断服务例程会调用页访问异常处理函数do_pgfault进行具体处理。这里的页访问异常处理是实现按需分页、页换入换出机制的关键之处。————来自gitbook
    下面是segment fault:
    段式管理前一个实验已经讨论过。在 ucore 中段式管理只起到了一个过渡作用，它将逻辑地址不加转换直接映射成线性地址，所以我们在下面的讨论中可以对这两个地址不加区分（目前的 OS 实现也是不加区分的）。————来自gitbook
###哪些段异常是否可取消，并用页异常取代？
    所以本质上来说是可以没有任何段错误的，因为在这里都转为了也页错误来处理。这样的处理手段是非常好的。
    这里越界这个错误可以再页错误中处理，实际上代码中也是这么做的
###硬件的处理过程
    首先页访问异常也是一种异常，所以针对一般异常的硬件处理操作是必须要做的，即CPU在当前内核栈保存当前被打断的程序现场，即依次压入当前被打断程序使用的EFLAGS，CS，EIP，errorCode；由于页访问异常的中断号是0xE，CPU把异常中断号0xE对应的中断服务例程的地址（vectors.S中的标号vector14处）加载到CS和EIP寄存器中，开始执行中断服务例程。这时ucore开始处理异常中断 ————来自gitbook
###OS如何处理
    OS的处理过程是trap--> trap_dispatch-->pgfault_handler-->do_pgfault，之后如果do_pgfault没有出错，那么会执行swap_in等等过程
    硬件的处理过程如下：
###是否可以利用做其他有用的事情
    当然可以提供比物理空间更大的虚拟空间，通过缺页和换页来实现
    还可以用作权限控制，例如代码中的10,00都可以做到
