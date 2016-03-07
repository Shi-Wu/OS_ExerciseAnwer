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
