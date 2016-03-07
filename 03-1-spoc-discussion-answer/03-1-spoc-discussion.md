## 小组思考题

#####请参考ucore lab2代码，采用`struct pmm_manager` 根据你的`学号 mod 4`的结果值，选择四种（0:最优匹配，1:最差匹配，2:最先匹配，3:buddy systemm）分配算法中的一种或多种，在应用程序层面(可以 用python,ruby,C++，C，LISP等高语言)来实现，给出你的设思路，并给出测试用例。 (spoc)
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

#####Worst Fit实现：
```
#include <unistd.h>
#include <stdio.h>

typedef long Align;
typedef unsigned int uint;

union header {
	struct {
		union header *ptr;
		uint size;
	} s;
	Align x;
};

typedef union header Header;

static Header base;
static Header *freep;

void
ufree(void *ap)
{
	Header *bp, *p;
	bp = (Header*)ap - 1;

	for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
		if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
			break;
		if(bp + bp->s.size == p->s.ptr){
			bp->s.size += p->s.ptr->s.size;
			bp->s.ptr = p->s.ptr->s.ptr;
		} else
			bp->s.ptr = p->s.ptr;
	if(p + p->s.size == bp){
		p->s.size += bp->s.size;
		p->s.ptr = bp->s.ptr;
	} else
	p->s.ptr = bp;
	freep = p;
}

static Header*
morecore(uint nu)
{
	// printf("in FUNC static Header* morecore(uint nu);\n");
	char *p;
	Header *hp;

	if(nu < 4096)
		nu = 4096;
	p = sbrk(nu * sizeof(Header));
	if(p == (char*)-1)
		return 0;
	hp = (Header*)p;
	hp->s.size = nu;
	ufree((void*)(hp + 1));
	// printf("added......%p\n", freep);
	return freep;
}
// int count = 0;
void*
umalloc(uint nbytes)
{
	// count ++;
	// printf("in");
	Header *p, *prevp, *pTmp,*prevpTmp;
	uint maxSize = 0;
	uint nunits;
	
	nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
	if((prevp = freep) == 0){
		base.s.ptr = freep = prevp = &base;
		base.s.size = 0;
	}
	// printf("--1--\n");
	int nn = 0;
	for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
		// nn++;
		// printf("=round: %d\n", nn);
		if(nn>100) break;

		if(p->s.size >= nunits && p->s.size > maxSize){
			// printf(">>Max Size: %u\n", maxSize);
			maxSize = p->s.size;
			pTmp = p;
			prevpTmp = prevp;
		}
		if(p == freep){
			// p = morecore(nunits);
			if(maxSize==0){
				// printf("added......%p\n", p);
				p = morecore(nunits);
				return umalloc(nunits);	
			}
			if(p==0) {
				return 0;
			}
			break;
		}
	}
	// printf("--2--\n");
	if (maxSize == nunits){
		prevpTmp->s.ptr = pTmp->s.ptr;
		freep = prevpTmp;
		// printf("...==..%d\n", count);
		return (void*)(pTmp + 1);
	}
	else if(maxSize > nunits){
		pTmp->s.size -= nunits;
		pTmp += pTmp->s.size;
		pTmp->s.size = nunits;
		freep = prevp;
		// printf("...>..%d\n", count);
		return (void*)(pTmp + 1);
	}
	else{
		// printf("maxSize:%u\n", maxSize);
		// printf("..<...%d\n", count);
		return 0;
	}
}

int main() {
  uint a = 10, b = 10, c= 10, d = 12, e = 20;
  // test case
  char* ap = umalloc(a);
  printf("++ ap: @ %p ; size: %d\n", ap, a);

  char* bp = umalloc(b);
  printf("++ bp: @ %p ; size: %d\n", bp, b);

  char* cp = umalloc(c);
  printf("++ cp: @ %p ; size: %d\n", cp, c);

  ufree(bp);
  printf("-- bp\n");

  char* dp = umalloc(d);
  printf("++ dp: @ %p ; size: %d\n", dp, d);

  ufree(dp);
  printf("-- dp\n");

  char* ep = umalloc(e);
  printf("++ ep: @ %p ; size: %d\n", ep, e);

  return 0;
}
```
测试结果：
```
++ ap: @ 0x1a2dff0 ; size: 10
++ bp: @ 0x1a2dfd0 ; size: 10
++ cp: @ 0x1a2dfb0 ; size: 10
-- bp
++ dp: @ 0x1a2df90 ; size: 12
-- dp
++ ep: @ 0x1a2df80 ; size: 20
```

#####First Fit实现：
```
#include <unistd.h>
#include <stdio.h>

typedef long Align;
typedef unsigned int uint;

union header {
  struct {
    union header *ptr;
    uint size;
  } s;
  Align x;
};

typedef union header Header;

static Header base;
static Header *freep;

void
ufree(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}

static Header*
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
  if(p == (char*)-1)
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
  ufree((void*)(hp + 1));
  return freep;
}

void*
umalloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  int nn = 0;
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    nn++;
    printf("=round: %d\n", nn);

    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }

    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}

int main() {
  uint a = 10, b = 10, c= 10, d = 12, e = 20;
  // test case
  char* ap = umalloc(a);
  printf("++ ap: @ %p ; size: %d\n", ap, a);

  char* bp = umalloc(b);
  printf("++ bp: @ %p ; size: %d\n", bp, b);

  char* cp = umalloc(c);
  printf("++ cp: @ %p ; size: %d\n", cp, c);

  ufree(bp);
  printf("-- bp\n");

  char* dp = umalloc(d);
  printf("++ dp: @ %p ; size: %d\n", dp, d);

  ufree(dp);
  printf("-- dp\n");

  char* ep = umalloc(e);
  printf("++ ep: @ %p ; size: %d\n", ep, e);

  return 0;
}
```
测试结果：
```
++ ap: @ 0x259fff0 ; size: 10
++ bp: @ 0x259ffd0 ; size: 10
++ cp: @ 0x259ffb0 ; size: 10
-- bp
++ dp: @ 0x259ffd0 ; size: 12
-- dp
++ ep: @ 0x259ff80 ; size: 20
```



## v9-cpu相关

[challenge]在v9-cpu上完成基于method-0/1/2/buddy system（选一个方法）with first/best/worst-fit(选一个fit)用户态动态内存分配函数malloc/free，要求在内核态实现sbrk系统调用以支持用户态动态内存分配方法。基于os4.c实现，可参考v9-cpu git repo的testing分支中的os.c和mem.h

- [x]  

> 

[challenge]在v9-cpu上完成基GC算法，要求在内核态实现sbrk系统调用以支持用户态动态内存分配方法。基于os4.c实现，可参考v9-cpu git repo的testing分支中的os.c和mem.h

- [x]  

>