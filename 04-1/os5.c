// os5.c -- 

#include <u.h>

enum {
  PAGE    = 4096,       // page size
  NOFILE  = 16,         // open files per process
  USRSTART= 0x40000000, // start of user virt address space  
  USREND  = 0x40100000, // end of user virt address space   
  USRPHY  = 32*1024*1024, //  start of user phy address space 
  KERSTART= 0xc0000000, // start of kerne address space
  KEREND  = 0xc4000000, // end of kernel address space  
  P2V     = +KERSTART,   // turn a physical address into a virtual address
  V2P     = -KERSTART,   // turn a virtual address into a physical address
  STACKSZ = 0x100000,   // user stack size (1MB)
};

enum { // page table entry flags
  PTE_P   = 0x001,       // Present
  PTE_W   = 0x002,       // Writeable
  PTE_U   = 0x004,       // User
//PTE_PWT = 0x008,       // Write-Through
//PTE_PCD = 0x010,       // Cache-Disable
  PTE_A   = 0x020,       // Accessed
  PTE_D   = 0x040,       // Dirty
//PTE_PS  = 0x080,       // Page Size
//PTE_MBZ = 0x180,       // Bits must be zero
};

enum { // processor fault codes
  FMEM,   // bad physical address
  FTIMER, // timer interrupt
  FKEYBD, // keyboard interrupt
  FPRIV,  // privileged instruction
  FINST,  // illegal instruction
  FSYS,   // software trap
  FARITH, // arithmetic trap
  FIPAGE, // page fault on opcode fetch
  FWPAGE, // page fault on write
  FRPAGE, // page fault on read
  USER=16 // user mode exception 
};


char pg_mem[19 * 4096]; // page dir + 16 kernel entries + 1 user entry + alignment

int *pg_dir, *pg_tbl[16];

//char user_mem[4*4096*4096+4096]; //user space
//int user_begin=32*1024*1024; //user start addr
int current;

int in(port)    { asm(LL,8); asm(BIN); }
out(port, val)  { asm(LL,8); asm(LBL,16); asm(BOUT); }
ivec(void *isr) { asm(LL,8); asm(IVEC); }
lvadr()         { asm(LVAD); }
stmr(int val)   { asm(LL,8); asm(TIME); }
pdir(value)     { asm(LL,8); asm(PDIR); }
spage(value)    { asm(LL,8); asm(SPAG); }
halt(value)     { asm(LL,8); asm(HALT); }

void *memcpy() { asm(LL,8); asm(LBL, 16); asm(LCL,24); asm(MCPY); asm(LL,8); }
void *memset() { asm(LL,8); asm(LBLB,16); asm(LCL,24); asm(MSET); asm(LL,8); }
void *memchr() { asm(LL,8); asm(LBLB,16); asm(LCL,24); asm(MCHR); }

write(fd, char *p, n) { while (n--) out(fd, *p++); }

int strlen(char *s) { return memchr(s, 0, -1) - (void *)s; }

enum { BUFSIZ = 32 };
int vsprintf(char *s, char *f, va_list v)
{
  char *e = s, *p, c, fill, b[BUFSIZ];
  int i, left, fmax, fmin, sign;

  while (c = *f++) {
    if (c != '%') { *e++ = c; continue; }
    if (*f == '%') { *e++ = *f++; continue; }
    if (left = (*f == '-')) f++;
    fill = (*f == '0') ? *f++ : ' ';
    fmin = sign = 0; fmax = BUFSIZ;
    if (*f == '*') { fmin = va_arg(v,int); f++; } else while ('0' <= *f && *f <= '9') fmin = fmin * 10 + *f++ - '0';
    if (*f == '.') { if (*++f == '*') { fmax = va_arg(v,int); f++; } else for (fmax = 0; '0' <= *f && *f <= '9'; fmax = fmax * 10 + *f++ - '0'); }
    if (*f == 'l') f++;
    switch (c = *f++) {
    case 0: *e++ = '%'; *e = 0; return e - s;
    case 'c': fill = ' '; i = (*(p = b) = va_arg(v,int)) ? 1 : 0; break;
    case 's': fill = ' '; if (!(p = va_arg(v,char *))) p = "(null)"; if ((i = strlen(p)) > fmax) i = fmax; break;
    case 'u': i = va_arg(v,int); goto c1;
    case 'd': if ((i = va_arg(v,int)) < 0) { sign = 1; i = -i; } c1: p = b + BUFSIZ-1; do { *--p = ((uint)i % 10) + '0'; } while (i = (uint)i / 10); i = (b + BUFSIZ-1) - p; break;
    case 'o': i = va_arg(v,int); p = b + BUFSIZ-1; do { *--p = (i & 7) + '0'; } while (i = (uint)i >> 3); i = (b + BUFSIZ-1) - p; break;
    case 'p': fill = '0'; fmin = 8; c = 'x';
    case 'x': case 'X': c -= 33; i = va_arg(v,int); p = b + BUFSIZ-1; do { *--p = (i & 15) + ((i & 15) > 9 ? c : '0'); } while (i = (uint)i >> 4); i = (b + BUFSIZ-1) - p; break;
    default: *e++ = c; continue;
    }
    fmin -= i + sign;
    if (sign && fill == '0') *e++ = '-';
    if (!left && fmin > 0) { memset(e, fill, fmin); e += fmin; }
    if (sign && fill == ' ') *e++ = '-';
    memcpy(e, p, i); e += i;
    if (left && fmin > 0) { memset(e, fill, fmin); e += fmin; }
  }
  *e = 0;
  return e - s;
}

int printf(char *f) { static char buf[4096]; return write(1, buf, vsprintf(buf, f, &f)); } // XXX remove static from buf

trap(int c, int b, int a, int fc, int pc)
{
  printf("TRAP: ");
  switch (fc) {
  case FINST:  printf("FINST"); break;
  case FRPAGE: printf("FRPAGE [0x%08x]",lvadr()); break;
  case FWPAGE: printf("FWPAGE [0x%08x]",lvadr()); break;
  case FIPAGE: printf("FIPAGE [0x%08x]",lvadr()); break;
  case FSYS:   printf("FSYS"); break;
  case FARITH: printf("FARITH"); break;
  case FMEM:   printf("FMEM [0x%08x]",lvadr()); break;
  case FTIMER: printf("FTIMER"); current = 1; stmr(0); break;
  case FKEYBD: printf("FKEYBD [%c]", in(0)); break;
  default:     printf("other [%d]",fc); break;
  }
}

alltraps()
{
  asm(PSHA);
  asm(PSHB);
  asm(PSHC);
  trap();
  asm(POPC);
  asm(POPB);
  asm(POPA);
  asm(RTI);
}

setup_user_paging()
{
  //YOUR CODE: lec7-spoc challenge-part2
    // int j;
    // int *pg = (int *)((((int)&pg_mem) + 4095) & -4096) + 17 * 1024;
    // pg_dir[256] = (int)pg | PTE_P | PTE_W | PTE_U;
    // for (j = 0; j < 1024; j++) {
    //   pg[j] = USRPHY + (j << 12) | PTE_P | PTE_W | PTE_U;
    // }
  // user_virt_addr=0x40000000+usr_phy_addr，
  // 用户空间可用大小为1MB，虚拟空间范围为0x40000000--0x40 100 000，
  // 物理空间范围为0x02000000--x0x02100000。
  pg_dir[256] = pg_dir[(3<<8) + 8];
}
  
setup_kernel_paging()
{
  //YOUR CODE: lec7-spoc challenge-part1
  int i, j;
  pg_dir = (int *)((((int)&pg_mem) + 4095) & -4096);
  pg_tbl[0] = pg_dir + 1024;
  for (i=1; i< 16; i++)
    pg_tbl[i] = pg_tbl[i-1] + 1024;  

  for (i=0;i<1024;i++) pg_dir[i] = 0;//dui qi

  for (i=0; i< 16; i++)
    pg_dir[ i + (3<<8) ] = (int)pg_tbl[i] | PTE_P | PTE_W | PTE_U;
    //0011 0000 0000 -> (10wei) 11 0000 0000 -> C____
  pg_dir[0] = pg_dir[3<<8];// Set fot the 
  //Like: kpdir[0] = kpdir[(uint)USERTOP >> 22]; // need a 1:1 map of low physical memory for awhile

  for (i=0; i < 16; i++) //10
      for (j=0; j < 1024; j++) //10
          pg_tbl[i][j] = (( (i<<10) + j ) << 12) | PTE_P | PTE_W | PTE_U;

  pdir(pg_dir);
  spage(1);
}

main()
{
  int *ksp;// temp kernel stack pointer
  static char kstack[256]; // temp kernel stack
  static int endbss;     // last variable in bss segment
  int t, d; 
  
  current = 0;
  ivec(alltraps);
  
  asm(STI);
  
  printf("test timer...");
  t = 0;
  stmr(10000);
  while (!current) t++;
  printf("(t=%d)...ok\n",t);
  
  printf("test bad physical address...");
  t = *(int *)0x20000000;
  printf("...ok\n");

  printf("test paging...\n");
  printf("phy addr 0x%x...\n", USRPHY);
   *(int *)(USRPHY)=10;
   *(int *)(4)=11;
  // reposition stack within first 16M
  asm(LI, 4*1024*1024); // a = 4M
  asm(SSP); // sp = a
  printf("set page table....\n"); 
  setup_kernel_paging();
  setup_user_paging();
  printf("set page table over\n"); 
  
  // turn on paging
  // set pg dir based_addr
  pdir(pg_dir);
  // enable page
  spage(1);
  
  printf("kernel and user map...ok\n");
  
  printf("test kernel page fault read 1...\n");
  *(int *)(KERSTART+4) = *(int *)(KERSTART);
  printf("...kernel ok 1 \n");

  printf("test user page fault read 1...\n");
  *(int *)(4) = *(int *)(USRSTART);
  printf("..%d, .user ok 1 \n",  *(int *)(4));  

  halt(0);
}
