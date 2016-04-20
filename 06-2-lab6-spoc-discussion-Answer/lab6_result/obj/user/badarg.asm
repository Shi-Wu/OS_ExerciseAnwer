
obj/__user_badarg.out：     文件格式 elf32-i386


Disassembly of section .text:

00800020 <__panic>:
#include <stdio.h>
#include <ulib.h>
#include <error.h>

void
__panic(const char *file, int line, const char *fmt, ...) {
  800020:	55                   	push   %ebp
  800021:	89 e5                	mov    %esp,%ebp
  800023:	83 ec 18             	sub    $0x18,%esp
    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  800026:	8d 45 14             	lea    0x14(%ebp),%eax
  800029:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("user panic at %s:%d:\n    ", file, line);
  80002c:	83 ec 04             	sub    $0x4,%esp
  80002f:	ff 75 0c             	pushl  0xc(%ebp)
  800032:	ff 75 08             	pushl  0x8(%ebp)
  800035:	68 60 10 80 00       	push   $0x801060
  80003a:	e8 9a 02 00 00       	call   8002d9 <cprintf>
  80003f:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
  800042:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800045:	83 ec 08             	sub    $0x8,%esp
  800048:	50                   	push   %eax
  800049:	ff 75 10             	pushl  0x10(%ebp)
  80004c:	e8 5f 02 00 00       	call   8002b0 <vcprintf>
  800051:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  800054:	83 ec 0c             	sub    $0xc,%esp
  800057:	68 7a 10 80 00       	push   $0x80107a
  80005c:	e8 78 02 00 00       	call   8002d9 <cprintf>
  800061:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
    exit(-E_PANIC);
  800064:	83 ec 0c             	sub    $0xc,%esp
  800067:	6a f6                	push   $0xfffffff6
  800069:	e8 49 01 00 00       	call   8001b7 <exit>

0080006e <__warn>:
}

void
__warn(const char *file, int line, const char *fmt, ...) {
  80006e:	55                   	push   %ebp
  80006f:	89 e5                	mov    %esp,%ebp
  800071:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    va_start(ap, fmt);
  800074:	8d 45 14             	lea    0x14(%ebp),%eax
  800077:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("user warning at %s:%d:\n    ", file, line);
  80007a:	83 ec 04             	sub    $0x4,%esp
  80007d:	ff 75 0c             	pushl  0xc(%ebp)
  800080:	ff 75 08             	pushl  0x8(%ebp)
  800083:	68 7c 10 80 00       	push   $0x80107c
  800088:	e8 4c 02 00 00       	call   8002d9 <cprintf>
  80008d:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
  800090:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800093:	83 ec 08             	sub    $0x8,%esp
  800096:	50                   	push   %eax
  800097:	ff 75 10             	pushl  0x10(%ebp)
  80009a:	e8 11 02 00 00       	call   8002b0 <vcprintf>
  80009f:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  8000a2:	83 ec 0c             	sub    $0xc,%esp
  8000a5:	68 7a 10 80 00       	push   $0x80107a
  8000aa:	e8 2a 02 00 00       	call   8002d9 <cprintf>
  8000af:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
  8000b2:	90                   	nop
  8000b3:	c9                   	leave  
  8000b4:	c3                   	ret    

008000b5 <syscall>:
#include <syscall.h>

#define MAX_ARGS            5

static inline int
syscall(int num, ...) {
  8000b5:	55                   	push   %ebp
  8000b6:	89 e5                	mov    %esp,%ebp
  8000b8:	57                   	push   %edi
  8000b9:	56                   	push   %esi
  8000ba:	53                   	push   %ebx
  8000bb:	83 ec 20             	sub    $0x20,%esp
    va_list ap;
    va_start(ap, num);
  8000be:	8d 45 0c             	lea    0xc(%ebp),%eax
  8000c1:	89 45 e8             	mov    %eax,-0x18(%ebp)
    uint32_t a[MAX_ARGS];
    int i, ret;
    for (i = 0; i < MAX_ARGS; i ++) {
  8000c4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8000cb:	eb 16                	jmp    8000e3 <syscall+0x2e>
        a[i] = va_arg(ap, uint32_t);
  8000cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000d0:	8d 50 04             	lea    0x4(%eax),%edx
  8000d3:	89 55 e8             	mov    %edx,-0x18(%ebp)
  8000d6:	8b 10                	mov    (%eax),%edx
  8000d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000db:	89 54 85 d4          	mov    %edx,-0x2c(%ebp,%eax,4)
syscall(int num, ...) {
    va_list ap;
    va_start(ap, num);
    uint32_t a[MAX_ARGS];
    int i, ret;
    for (i = 0; i < MAX_ARGS; i ++) {
  8000df:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  8000e3:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
  8000e7:	7e e4                	jle    8000cd <syscall+0x18>
    asm volatile (
        "int %1;"
        : "=a" (ret)
        : "i" (T_SYSCALL),
          "a" (num),
          "d" (a[0]),
  8000e9:	8b 55 d4             	mov    -0x2c(%ebp),%edx
          "c" (a[1]),
  8000ec:	8b 4d d8             	mov    -0x28(%ebp),%ecx
          "b" (a[2]),
  8000ef:	8b 5d dc             	mov    -0x24(%ebp),%ebx
          "D" (a[3]),
  8000f2:	8b 7d e0             	mov    -0x20(%ebp),%edi
          "S" (a[4])
  8000f5:	8b 75 e4             	mov    -0x1c(%ebp),%esi
    for (i = 0; i < MAX_ARGS; i ++) {
        a[i] = va_arg(ap, uint32_t);
    }
    va_end(ap);

    asm volatile (
  8000f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8000fb:	cd 80                	int    $0x80
  8000fd:	89 45 ec             	mov    %eax,-0x14(%ebp)
          "c" (a[1]),
          "b" (a[2]),
          "D" (a[3]),
          "S" (a[4])
        : "cc", "memory");
    return ret;
  800100:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
  800103:	83 c4 20             	add    $0x20,%esp
  800106:	5b                   	pop    %ebx
  800107:	5e                   	pop    %esi
  800108:	5f                   	pop    %edi
  800109:	5d                   	pop    %ebp
  80010a:	c3                   	ret    

0080010b <sys_exit>:

int
sys_exit(int error_code) {
  80010b:	55                   	push   %ebp
  80010c:	89 e5                	mov    %esp,%ebp
    return syscall(SYS_exit, error_code);
  80010e:	ff 75 08             	pushl  0x8(%ebp)
  800111:	6a 01                	push   $0x1
  800113:	e8 9d ff ff ff       	call   8000b5 <syscall>
  800118:	83 c4 08             	add    $0x8,%esp
}
  80011b:	c9                   	leave  
  80011c:	c3                   	ret    

0080011d <sys_fork>:

int
sys_fork(void) {
  80011d:	55                   	push   %ebp
  80011e:	89 e5                	mov    %esp,%ebp
    return syscall(SYS_fork);
  800120:	6a 02                	push   $0x2
  800122:	e8 8e ff ff ff       	call   8000b5 <syscall>
  800127:	83 c4 04             	add    $0x4,%esp
}
  80012a:	c9                   	leave  
  80012b:	c3                   	ret    

0080012c <sys_wait>:

int
sys_wait(int pid, int *store) {
  80012c:	55                   	push   %ebp
  80012d:	89 e5                	mov    %esp,%ebp
    return syscall(SYS_wait, pid, store);
  80012f:	ff 75 0c             	pushl  0xc(%ebp)
  800132:	ff 75 08             	pushl  0x8(%ebp)
  800135:	6a 03                	push   $0x3
  800137:	e8 79 ff ff ff       	call   8000b5 <syscall>
  80013c:	83 c4 0c             	add    $0xc,%esp
}
  80013f:	c9                   	leave  
  800140:	c3                   	ret    

00800141 <sys_yield>:

int
sys_yield(void) {
  800141:	55                   	push   %ebp
  800142:	89 e5                	mov    %esp,%ebp
    return syscall(SYS_yield);
  800144:	6a 0a                	push   $0xa
  800146:	e8 6a ff ff ff       	call   8000b5 <syscall>
  80014b:	83 c4 04             	add    $0x4,%esp
}
  80014e:	c9                   	leave  
  80014f:	c3                   	ret    

00800150 <sys_kill>:

int
sys_kill(int pid) {
  800150:	55                   	push   %ebp
  800151:	89 e5                	mov    %esp,%ebp
    return syscall(SYS_kill, pid);
  800153:	ff 75 08             	pushl  0x8(%ebp)
  800156:	6a 0c                	push   $0xc
  800158:	e8 58 ff ff ff       	call   8000b5 <syscall>
  80015d:	83 c4 08             	add    $0x8,%esp
}
  800160:	c9                   	leave  
  800161:	c3                   	ret    

00800162 <sys_getpid>:

int
sys_getpid(void) {
  800162:	55                   	push   %ebp
  800163:	89 e5                	mov    %esp,%ebp
    return syscall(SYS_getpid);
  800165:	6a 12                	push   $0x12
  800167:	e8 49 ff ff ff       	call   8000b5 <syscall>
  80016c:	83 c4 04             	add    $0x4,%esp
}
  80016f:	c9                   	leave  
  800170:	c3                   	ret    

00800171 <sys_putc>:

int
sys_putc(int c) {
  800171:	55                   	push   %ebp
  800172:	89 e5                	mov    %esp,%ebp
    return syscall(SYS_putc, c);
  800174:	ff 75 08             	pushl  0x8(%ebp)
  800177:	6a 1e                	push   $0x1e
  800179:	e8 37 ff ff ff       	call   8000b5 <syscall>
  80017e:	83 c4 08             	add    $0x8,%esp
}
  800181:	c9                   	leave  
  800182:	c3                   	ret    

00800183 <sys_pgdir>:

int
sys_pgdir(void) {
  800183:	55                   	push   %ebp
  800184:	89 e5                	mov    %esp,%ebp
    return syscall(SYS_pgdir);
  800186:	6a 1f                	push   $0x1f
  800188:	e8 28 ff ff ff       	call   8000b5 <syscall>
  80018d:	83 c4 04             	add    $0x4,%esp
}
  800190:	c9                   	leave  
  800191:	c3                   	ret    

00800192 <sys_gettime>:

size_t
sys_gettime(void) {
  800192:	55                   	push   %ebp
  800193:	89 e5                	mov    %esp,%ebp
    return syscall(SYS_gettime);
  800195:	6a 11                	push   $0x11
  800197:	e8 19 ff ff ff       	call   8000b5 <syscall>
  80019c:	83 c4 04             	add    $0x4,%esp
}
  80019f:	c9                   	leave  
  8001a0:	c3                   	ret    

008001a1 <sys_lab6_set_priority>:

void
sys_lab6_set_priority(uint32_t priority)
{
  8001a1:	55                   	push   %ebp
  8001a2:	89 e5                	mov    %esp,%ebp
    syscall(SYS_lab6_set_priority, priority);
  8001a4:	ff 75 08             	pushl  0x8(%ebp)
  8001a7:	68 ff 00 00 00       	push   $0xff
  8001ac:	e8 04 ff ff ff       	call   8000b5 <syscall>
  8001b1:	83 c4 08             	add    $0x8,%esp
}
  8001b4:	90                   	nop
  8001b5:	c9                   	leave  
  8001b6:	c3                   	ret    

008001b7 <exit>:
#include <syscall.h>
#include <stdio.h>
#include <ulib.h>

void
exit(int error_code) {
  8001b7:	55                   	push   %ebp
  8001b8:	89 e5                	mov    %esp,%ebp
  8001ba:	83 ec 08             	sub    $0x8,%esp
    sys_exit(error_code);
  8001bd:	83 ec 0c             	sub    $0xc,%esp
  8001c0:	ff 75 08             	pushl  0x8(%ebp)
  8001c3:	e8 43 ff ff ff       	call   80010b <sys_exit>
  8001c8:	83 c4 10             	add    $0x10,%esp
    cprintf("BUG: exit failed.\n");
  8001cb:	83 ec 0c             	sub    $0xc,%esp
  8001ce:	68 98 10 80 00       	push   $0x801098
  8001d3:	e8 01 01 00 00       	call   8002d9 <cprintf>
  8001d8:	83 c4 10             	add    $0x10,%esp
    while (1);
  8001db:	eb fe                	jmp    8001db <exit+0x24>

008001dd <fork>:
}

int
fork(void) {
  8001dd:	55                   	push   %ebp
  8001de:	89 e5                	mov    %esp,%ebp
  8001e0:	83 ec 08             	sub    $0x8,%esp
    return sys_fork();
  8001e3:	e8 35 ff ff ff       	call   80011d <sys_fork>
}
  8001e8:	c9                   	leave  
  8001e9:	c3                   	ret    

008001ea <wait>:

int
wait(void) {
  8001ea:	55                   	push   %ebp
  8001eb:	89 e5                	mov    %esp,%ebp
  8001ed:	83 ec 08             	sub    $0x8,%esp
    return sys_wait(0, NULL);
  8001f0:	83 ec 08             	sub    $0x8,%esp
  8001f3:	6a 00                	push   $0x0
  8001f5:	6a 00                	push   $0x0
  8001f7:	e8 30 ff ff ff       	call   80012c <sys_wait>
  8001fc:	83 c4 10             	add    $0x10,%esp
}
  8001ff:	c9                   	leave  
  800200:	c3                   	ret    

00800201 <waitpid>:

int
waitpid(int pid, int *store) {
  800201:	55                   	push   %ebp
  800202:	89 e5                	mov    %esp,%ebp
  800204:	83 ec 08             	sub    $0x8,%esp
    return sys_wait(pid, store);
  800207:	83 ec 08             	sub    $0x8,%esp
  80020a:	ff 75 0c             	pushl  0xc(%ebp)
  80020d:	ff 75 08             	pushl  0x8(%ebp)
  800210:	e8 17 ff ff ff       	call   80012c <sys_wait>
  800215:	83 c4 10             	add    $0x10,%esp
}
  800218:	c9                   	leave  
  800219:	c3                   	ret    

0080021a <yield>:

void
yield(void) {
  80021a:	55                   	push   %ebp
  80021b:	89 e5                	mov    %esp,%ebp
  80021d:	83 ec 08             	sub    $0x8,%esp
    sys_yield();
  800220:	e8 1c ff ff ff       	call   800141 <sys_yield>
}
  800225:	90                   	nop
  800226:	c9                   	leave  
  800227:	c3                   	ret    

00800228 <kill>:

int
kill(int pid) {
  800228:	55                   	push   %ebp
  800229:	89 e5                	mov    %esp,%ebp
  80022b:	83 ec 08             	sub    $0x8,%esp
    return sys_kill(pid);
  80022e:	83 ec 0c             	sub    $0xc,%esp
  800231:	ff 75 08             	pushl  0x8(%ebp)
  800234:	e8 17 ff ff ff       	call   800150 <sys_kill>
  800239:	83 c4 10             	add    $0x10,%esp
}
  80023c:	c9                   	leave  
  80023d:	c3                   	ret    

0080023e <getpid>:

int
getpid(void) {
  80023e:	55                   	push   %ebp
  80023f:	89 e5                	mov    %esp,%ebp
  800241:	83 ec 08             	sub    $0x8,%esp
    return sys_getpid();
  800244:	e8 19 ff ff ff       	call   800162 <sys_getpid>
}
  800249:	c9                   	leave  
  80024a:	c3                   	ret    

0080024b <print_pgdir>:

//print_pgdir - print the PDT&PT
void
print_pgdir(void) {
  80024b:	55                   	push   %ebp
  80024c:	89 e5                	mov    %esp,%ebp
  80024e:	83 ec 08             	sub    $0x8,%esp
    sys_pgdir();
  800251:	e8 2d ff ff ff       	call   800183 <sys_pgdir>
}
  800256:	90                   	nop
  800257:	c9                   	leave  
  800258:	c3                   	ret    

00800259 <gettime_msec>:

unsigned int
gettime_msec(void) {
  800259:	55                   	push   %ebp
  80025a:	89 e5                	mov    %esp,%ebp
  80025c:	83 ec 08             	sub    $0x8,%esp
    return (unsigned int)sys_gettime();
  80025f:	e8 2e ff ff ff       	call   800192 <sys_gettime>
}
  800264:	c9                   	leave  
  800265:	c3                   	ret    

00800266 <lab6_set_priority>:

void
lab6_set_priority(uint32_t priority)
{
  800266:	55                   	push   %ebp
  800267:	89 e5                	mov    %esp,%ebp
  800269:	83 ec 08             	sub    $0x8,%esp
    sys_lab6_set_priority(priority);
  80026c:	83 ec 0c             	sub    $0xc,%esp
  80026f:	ff 75 08             	pushl  0x8(%ebp)
  800272:	e8 2a ff ff ff       	call   8001a1 <sys_lab6_set_priority>
  800277:	83 c4 10             	add    $0x10,%esp
}
  80027a:	90                   	nop
  80027b:	c9                   	leave  
  80027c:	c3                   	ret    

0080027d <_start>:
.text
.globl _start
_start:
    # set ebp for backtrace
    movl $0x0, %ebp
  80027d:	bd 00 00 00 00       	mov    $0x0,%ebp

    # move down the esp register
    # since it may cause page fault in backtrace
    subl $0x20, %esp
  800282:	83 ec 20             	sub    $0x20,%esp

    # call user-program function
    call umain
  800285:	e8 c3 00 00 00       	call   80034d <umain>
1:  jmp 1b
  80028a:	eb fe                	jmp    80028a <_start+0xd>

0080028c <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  80028c:	55                   	push   %ebp
  80028d:	89 e5                	mov    %esp,%ebp
  80028f:	83 ec 08             	sub    $0x8,%esp
    sys_putc(c);
  800292:	83 ec 0c             	sub    $0xc,%esp
  800295:	ff 75 08             	pushl  0x8(%ebp)
  800298:	e8 d4 fe ff ff       	call   800171 <sys_putc>
  80029d:	83 c4 10             	add    $0x10,%esp
    (*cnt) ++;
  8002a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002a3:	8b 00                	mov    (%eax),%eax
  8002a5:	8d 50 01             	lea    0x1(%eax),%edx
  8002a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002ab:	89 10                	mov    %edx,(%eax)
}
  8002ad:	90                   	nop
  8002ae:	c9                   	leave  
  8002af:	c3                   	ret    

008002b0 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  8002b0:	55                   	push   %ebp
  8002b1:	89 e5                	mov    %esp,%ebp
  8002b3:	83 ec 18             	sub    $0x18,%esp
    int cnt = 0;
  8002b6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  8002bd:	ff 75 0c             	pushl  0xc(%ebp)
  8002c0:	ff 75 08             	pushl  0x8(%ebp)
  8002c3:	8d 45 f4             	lea    -0xc(%ebp),%eax
  8002c6:	50                   	push   %eax
  8002c7:	68 8c 02 80 00       	push   $0x80028c
  8002cc:	e8 fc 06 00 00       	call   8009cd <vprintfmt>
  8002d1:	83 c4 10             	add    $0x10,%esp
    return cnt;
  8002d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8002d7:	c9                   	leave  
  8002d8:	c3                   	ret    

008002d9 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  8002d9:	55                   	push   %ebp
  8002da:	89 e5                	mov    %esp,%ebp
  8002dc:	83 ec 18             	sub    $0x18,%esp
    va_list ap;

    va_start(ap, fmt);
  8002df:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    int cnt = vcprintf(fmt, ap);
  8002e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002e8:	83 ec 08             	sub    $0x8,%esp
  8002eb:	50                   	push   %eax
  8002ec:	ff 75 08             	pushl  0x8(%ebp)
  8002ef:	e8 bc ff ff ff       	call   8002b0 <vcprintf>
  8002f4:	83 c4 10             	add    $0x10,%esp
  8002f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);

    return cnt;
  8002fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8002fd:	c9                   	leave  
  8002fe:	c3                   	ret    

008002ff <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  8002ff:	55                   	push   %ebp
  800300:	89 e5                	mov    %esp,%ebp
  800302:	83 ec 18             	sub    $0x18,%esp
    int cnt = 0;
  800305:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  80030c:	eb 14                	jmp    800322 <cputs+0x23>
        cputch(c, &cnt);
  80030e:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800312:	83 ec 08             	sub    $0x8,%esp
  800315:	8d 55 f0             	lea    -0x10(%ebp),%edx
  800318:	52                   	push   %edx
  800319:	50                   	push   %eax
  80031a:	e8 6d ff ff ff       	call   80028c <cputch>
  80031f:	83 c4 10             	add    $0x10,%esp
 * */
int
cputs(const char *str) {
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
  800322:	8b 45 08             	mov    0x8(%ebp),%eax
  800325:	8d 50 01             	lea    0x1(%eax),%edx
  800328:	89 55 08             	mov    %edx,0x8(%ebp)
  80032b:	0f b6 00             	movzbl (%eax),%eax
  80032e:	88 45 f7             	mov    %al,-0x9(%ebp)
  800331:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800335:	75 d7                	jne    80030e <cputs+0xf>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
  800337:	83 ec 08             	sub    $0x8,%esp
  80033a:	8d 45 f0             	lea    -0x10(%ebp),%eax
  80033d:	50                   	push   %eax
  80033e:	6a 0a                	push   $0xa
  800340:	e8 47 ff ff ff       	call   80028c <cputch>
  800345:	83 c4 10             	add    $0x10,%esp
    return cnt;
  800348:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80034b:	c9                   	leave  
  80034c:	c3                   	ret    

0080034d <umain>:
#include <ulib.h>

int main(void);

void
umain(void) {
  80034d:	55                   	push   %ebp
  80034e:	89 e5                	mov    %esp,%ebp
  800350:	83 ec 18             	sub    $0x18,%esp
    int ret = main();
  800353:	e8 d3 0b 00 00       	call   800f2b <main>
  800358:	89 45 f4             	mov    %eax,-0xc(%ebp)
    exit(ret);
  80035b:	83 ec 0c             	sub    $0xc,%esp
  80035e:	ff 75 f4             	pushl  -0xc(%ebp)
  800361:	e8 51 fe ff ff       	call   8001b7 <exit>

00800366 <strlen>:
 * @s:      the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  800366:	55                   	push   %ebp
  800367:	89 e5                	mov    %esp,%ebp
  800369:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  80036c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  800373:	eb 04                	jmp    800379 <strlen+0x13>
        cnt ++;
  800375:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
  800379:	8b 45 08             	mov    0x8(%ebp),%eax
  80037c:	8d 50 01             	lea    0x1(%eax),%edx
  80037f:	89 55 08             	mov    %edx,0x8(%ebp)
  800382:	0f b6 00             	movzbl (%eax),%eax
  800385:	84 c0                	test   %al,%al
  800387:	75 ec                	jne    800375 <strlen+0xf>
        cnt ++;
    }
    return cnt;
  800389:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80038c:	c9                   	leave  
  80038d:	c3                   	ret    

0080038e <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  80038e:	55                   	push   %ebp
  80038f:	89 e5                	mov    %esp,%ebp
  800391:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  800394:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  80039b:	eb 04                	jmp    8003a1 <strnlen+0x13>
        cnt ++;
  80039d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
    while (cnt < len && *s ++ != '\0') {
  8003a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003a4:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003a7:	73 10                	jae    8003b9 <strnlen+0x2b>
  8003a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ac:	8d 50 01             	lea    0x1(%eax),%edx
  8003af:	89 55 08             	mov    %edx,0x8(%ebp)
  8003b2:	0f b6 00             	movzbl (%eax),%eax
  8003b5:	84 c0                	test   %al,%al
  8003b7:	75 e4                	jne    80039d <strnlen+0xf>
        cnt ++;
    }
    return cnt;
  8003b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8003bc:	c9                   	leave  
  8003bd:	c3                   	ret    

008003be <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  8003be:	55                   	push   %ebp
  8003bf:	89 e5                	mov    %esp,%ebp
  8003c1:	57                   	push   %edi
  8003c2:	56                   	push   %esi
  8003c3:	83 ec 20             	sub    $0x20,%esp
  8003c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8003cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  8003d2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8003d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003d8:	89 d1                	mov    %edx,%ecx
  8003da:	89 c2                	mov    %eax,%edx
  8003dc:	89 ce                	mov    %ecx,%esi
  8003de:	89 d7                	mov    %edx,%edi
  8003e0:	ac                   	lods   %ds:(%esi),%al
  8003e1:	aa                   	stos   %al,%es:(%edi)
  8003e2:	84 c0                	test   %al,%al
  8003e4:	75 fa                	jne    8003e0 <strcpy+0x22>
  8003e6:	89 fa                	mov    %edi,%edx
  8003e8:	89 f1                	mov    %esi,%ecx
  8003ea:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  8003ed:	89 55 e8             	mov    %edx,-0x18(%ebp)
  8003f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        "stosb;"
        "testb %%al, %%al;"
        "jne 1b;"
        : "=&S" (d0), "=&D" (d1), "=&a" (d2)
        : "0" (src), "1" (dst) : "memory");
    return dst;
  8003f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
#ifdef __HAVE_ARCH_STRCPY
    return __strcpy(dst, src);
  8003f6:	90                   	nop
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  8003f7:	83 c4 20             	add    $0x20,%esp
  8003fa:	5e                   	pop    %esi
  8003fb:	5f                   	pop    %edi
  8003fc:	5d                   	pop    %ebp
  8003fd:	c3                   	ret    

008003fe <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  8003fe:	55                   	push   %ebp
  8003ff:	89 e5                	mov    %esp,%ebp
  800401:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  800404:	8b 45 08             	mov    0x8(%ebp),%eax
  800407:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  80040a:	eb 21                	jmp    80042d <strncpy+0x2f>
        if ((*p = *src) != '\0') {
  80040c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80040f:	0f b6 10             	movzbl (%eax),%edx
  800412:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800415:	88 10                	mov    %dl,(%eax)
  800417:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80041a:	0f b6 00             	movzbl (%eax),%eax
  80041d:	84 c0                	test   %al,%al
  80041f:	74 04                	je     800425 <strncpy+0x27>
            src ++;
  800421:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
  800425:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  800429:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
    char *p = dst;
    while (len > 0) {
  80042d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800431:	75 d9                	jne    80040c <strncpy+0xe>
        if ((*p = *src) != '\0') {
            src ++;
        }
        p ++, len --;
    }
    return dst;
  800433:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800436:	c9                   	leave  
  800437:	c3                   	ret    

00800438 <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  800438:	55                   	push   %ebp
  800439:	89 e5                	mov    %esp,%ebp
  80043b:	57                   	push   %edi
  80043c:	56                   	push   %esi
  80043d:	83 ec 20             	sub    $0x20,%esp
  800440:	8b 45 08             	mov    0x8(%ebp),%eax
  800443:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800446:	8b 45 0c             	mov    0xc(%ebp),%eax
  800449:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCMP
#define __HAVE_ARCH_STRCMP
static inline int
__strcmp(const char *s1, const char *s2) {
    int d0, d1, ret;
    asm volatile (
  80044c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80044f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800452:	89 d1                	mov    %edx,%ecx
  800454:	89 c2                	mov    %eax,%edx
  800456:	89 ce                	mov    %ecx,%esi
  800458:	89 d7                	mov    %edx,%edi
  80045a:	ac                   	lods   %ds:(%esi),%al
  80045b:	ae                   	scas   %es:(%edi),%al
  80045c:	75 08                	jne    800466 <strcmp+0x2e>
  80045e:	84 c0                	test   %al,%al
  800460:	75 f8                	jne    80045a <strcmp+0x22>
  800462:	31 c0                	xor    %eax,%eax
  800464:	eb 04                	jmp    80046a <strcmp+0x32>
  800466:	19 c0                	sbb    %eax,%eax
  800468:	0c 01                	or     $0x1,%al
  80046a:	89 fa                	mov    %edi,%edx
  80046c:	89 f1                	mov    %esi,%ecx
  80046e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800471:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  800474:	89 55 e4             	mov    %edx,-0x1c(%ebp)
        "orb $1, %%al;"
        "3:"
        : "=a" (ret), "=&S" (d0), "=&D" (d1)
        : "1" (s1), "2" (s2)
        : "memory");
    return ret;
  800477:	8b 45 ec             	mov    -0x14(%ebp),%eax
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
  80047a:	90                   	nop
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  80047b:	83 c4 20             	add    $0x20,%esp
  80047e:	5e                   	pop    %esi
  80047f:	5f                   	pop    %edi
  800480:	5d                   	pop    %ebp
  800481:	c3                   	ret    

00800482 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  800482:	55                   	push   %ebp
  800483:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  800485:	eb 0c                	jmp    800493 <strncmp+0x11>
        n --, s1 ++, s2 ++;
  800487:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  80048b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  80048f:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  800493:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800497:	74 1a                	je     8004b3 <strncmp+0x31>
  800499:	8b 45 08             	mov    0x8(%ebp),%eax
  80049c:	0f b6 00             	movzbl (%eax),%eax
  80049f:	84 c0                	test   %al,%al
  8004a1:	74 10                	je     8004b3 <strncmp+0x31>
  8004a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a6:	0f b6 10             	movzbl (%eax),%edx
  8004a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004ac:	0f b6 00             	movzbl (%eax),%eax
  8004af:	38 c2                	cmp    %al,%dl
  8004b1:	74 d4                	je     800487 <strncmp+0x5>
        n --, s1 ++, s2 ++;
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  8004b3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8004b7:	74 18                	je     8004d1 <strncmp+0x4f>
  8004b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004bc:	0f b6 00             	movzbl (%eax),%eax
  8004bf:	0f b6 d0             	movzbl %al,%edx
  8004c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004c5:	0f b6 00             	movzbl (%eax),%eax
  8004c8:	0f b6 c0             	movzbl %al,%eax
  8004cb:	29 c2                	sub    %eax,%edx
  8004cd:	89 d0                	mov    %edx,%eax
  8004cf:	eb 05                	jmp    8004d6 <strncmp+0x54>
  8004d1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8004d6:	5d                   	pop    %ebp
  8004d7:	c3                   	ret    

008004d8 <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  8004d8:	55                   	push   %ebp
  8004d9:	89 e5                	mov    %esp,%ebp
  8004db:	83 ec 04             	sub    $0x4,%esp
  8004de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004e1:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  8004e4:	eb 14                	jmp    8004fa <strchr+0x22>
        if (*s == c) {
  8004e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e9:	0f b6 00             	movzbl (%eax),%eax
  8004ec:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8004ef:	75 05                	jne    8004f6 <strchr+0x1e>
            return (char *)s;
  8004f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f4:	eb 13                	jmp    800509 <strchr+0x31>
        }
        s ++;
  8004f6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
  8004fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8004fd:	0f b6 00             	movzbl (%eax),%eax
  800500:	84 c0                	test   %al,%al
  800502:	75 e2                	jne    8004e6 <strchr+0xe>
        if (*s == c) {
            return (char *)s;
        }
        s ++;
    }
    return NULL;
  800504:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800509:	c9                   	leave  
  80050a:	c3                   	ret    

0080050b <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  80050b:	55                   	push   %ebp
  80050c:	89 e5                	mov    %esp,%ebp
  80050e:	83 ec 04             	sub    $0x4,%esp
  800511:	8b 45 0c             	mov    0xc(%ebp),%eax
  800514:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  800517:	eb 0f                	jmp    800528 <strfind+0x1d>
        if (*s == c) {
  800519:	8b 45 08             	mov    0x8(%ebp),%eax
  80051c:	0f b6 00             	movzbl (%eax),%eax
  80051f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800522:	74 10                	je     800534 <strfind+0x29>
            break;
        }
        s ++;
  800524:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
    while (*s != '\0') {
  800528:	8b 45 08             	mov    0x8(%ebp),%eax
  80052b:	0f b6 00             	movzbl (%eax),%eax
  80052e:	84 c0                	test   %al,%al
  800530:	75 e7                	jne    800519 <strfind+0xe>
  800532:	eb 01                	jmp    800535 <strfind+0x2a>
        if (*s == c) {
            break;
  800534:	90                   	nop
        }
        s ++;
    }
    return (char *)s;
  800535:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800538:	c9                   	leave  
  800539:	c3                   	ret    

0080053a <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  80053a:	55                   	push   %ebp
  80053b:	89 e5                	mov    %esp,%ebp
  80053d:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  800540:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  800547:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  80054e:	eb 04                	jmp    800554 <strtol+0x1a>
        s ++;
  800550:	83 45 08 01          	addl   $0x1,0x8(%ebp)
strtol(const char *s, char **endptr, int base) {
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  800554:	8b 45 08             	mov    0x8(%ebp),%eax
  800557:	0f b6 00             	movzbl (%eax),%eax
  80055a:	3c 20                	cmp    $0x20,%al
  80055c:	74 f2                	je     800550 <strtol+0x16>
  80055e:	8b 45 08             	mov    0x8(%ebp),%eax
  800561:	0f b6 00             	movzbl (%eax),%eax
  800564:	3c 09                	cmp    $0x9,%al
  800566:	74 e8                	je     800550 <strtol+0x16>
        s ++;
    }

    // plus/minus sign
    if (*s == '+') {
  800568:	8b 45 08             	mov    0x8(%ebp),%eax
  80056b:	0f b6 00             	movzbl (%eax),%eax
  80056e:	3c 2b                	cmp    $0x2b,%al
  800570:	75 06                	jne    800578 <strtol+0x3e>
        s ++;
  800572:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  800576:	eb 15                	jmp    80058d <strtol+0x53>
    }
    else if (*s == '-') {
  800578:	8b 45 08             	mov    0x8(%ebp),%eax
  80057b:	0f b6 00             	movzbl (%eax),%eax
  80057e:	3c 2d                	cmp    $0x2d,%al
  800580:	75 0b                	jne    80058d <strtol+0x53>
        s ++, neg = 1;
  800582:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  800586:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  80058d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800591:	74 06                	je     800599 <strtol+0x5f>
  800593:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800597:	75 24                	jne    8005bd <strtol+0x83>
  800599:	8b 45 08             	mov    0x8(%ebp),%eax
  80059c:	0f b6 00             	movzbl (%eax),%eax
  80059f:	3c 30                	cmp    $0x30,%al
  8005a1:	75 1a                	jne    8005bd <strtol+0x83>
  8005a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a6:	83 c0 01             	add    $0x1,%eax
  8005a9:	0f b6 00             	movzbl (%eax),%eax
  8005ac:	3c 78                	cmp    $0x78,%al
  8005ae:	75 0d                	jne    8005bd <strtol+0x83>
        s += 2, base = 16;
  8005b0:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8005b4:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8005bb:	eb 2a                	jmp    8005e7 <strtol+0xad>
    }
    else if (base == 0 && s[0] == '0') {
  8005bd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8005c1:	75 17                	jne    8005da <strtol+0xa0>
  8005c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c6:	0f b6 00             	movzbl (%eax),%eax
  8005c9:	3c 30                	cmp    $0x30,%al
  8005cb:	75 0d                	jne    8005da <strtol+0xa0>
        s ++, base = 8;
  8005cd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  8005d1:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8005d8:	eb 0d                	jmp    8005e7 <strtol+0xad>
    }
    else if (base == 0) {
  8005da:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8005de:	75 07                	jne    8005e7 <strtol+0xad>
        base = 10;
  8005e0:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  8005e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ea:	0f b6 00             	movzbl (%eax),%eax
  8005ed:	3c 2f                	cmp    $0x2f,%al
  8005ef:	7e 1b                	jle    80060c <strtol+0xd2>
  8005f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f4:	0f b6 00             	movzbl (%eax),%eax
  8005f7:	3c 39                	cmp    $0x39,%al
  8005f9:	7f 11                	jg     80060c <strtol+0xd2>
            dig = *s - '0';
  8005fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8005fe:	0f b6 00             	movzbl (%eax),%eax
  800601:	0f be c0             	movsbl %al,%eax
  800604:	83 e8 30             	sub    $0x30,%eax
  800607:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80060a:	eb 48                	jmp    800654 <strtol+0x11a>
        }
        else if (*s >= 'a' && *s <= 'z') {
  80060c:	8b 45 08             	mov    0x8(%ebp),%eax
  80060f:	0f b6 00             	movzbl (%eax),%eax
  800612:	3c 60                	cmp    $0x60,%al
  800614:	7e 1b                	jle    800631 <strtol+0xf7>
  800616:	8b 45 08             	mov    0x8(%ebp),%eax
  800619:	0f b6 00             	movzbl (%eax),%eax
  80061c:	3c 7a                	cmp    $0x7a,%al
  80061e:	7f 11                	jg     800631 <strtol+0xf7>
            dig = *s - 'a' + 10;
  800620:	8b 45 08             	mov    0x8(%ebp),%eax
  800623:	0f b6 00             	movzbl (%eax),%eax
  800626:	0f be c0             	movsbl %al,%eax
  800629:	83 e8 57             	sub    $0x57,%eax
  80062c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80062f:	eb 23                	jmp    800654 <strtol+0x11a>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  800631:	8b 45 08             	mov    0x8(%ebp),%eax
  800634:	0f b6 00             	movzbl (%eax),%eax
  800637:	3c 40                	cmp    $0x40,%al
  800639:	7e 3c                	jle    800677 <strtol+0x13d>
  80063b:	8b 45 08             	mov    0x8(%ebp),%eax
  80063e:	0f b6 00             	movzbl (%eax),%eax
  800641:	3c 5a                	cmp    $0x5a,%al
  800643:	7f 32                	jg     800677 <strtol+0x13d>
            dig = *s - 'A' + 10;
  800645:	8b 45 08             	mov    0x8(%ebp),%eax
  800648:	0f b6 00             	movzbl (%eax),%eax
  80064b:	0f be c0             	movsbl %al,%eax
  80064e:	83 e8 37             	sub    $0x37,%eax
  800651:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  800654:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800657:	3b 45 10             	cmp    0x10(%ebp),%eax
  80065a:	7d 1a                	jge    800676 <strtol+0x13c>
            break;
        }
        s ++, val = (val * base) + dig;
  80065c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  800660:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800663:	0f af 45 10          	imul   0x10(%ebp),%eax
  800667:	89 c2                	mov    %eax,%edx
  800669:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80066c:	01 d0                	add    %edx,%eax
  80066e:	89 45 f8             	mov    %eax,-0x8(%ebp)
        // we don't properly detect overflow!
    }
  800671:	e9 71 ff ff ff       	jmp    8005e7 <strtol+0xad>
        }
        else {
            break;
        }
        if (dig >= base) {
            break;
  800676:	90                   	nop
        }
        s ++, val = (val * base) + dig;
        // we don't properly detect overflow!
    }

    if (endptr) {
  800677:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80067b:	74 08                	je     800685 <strtol+0x14b>
        *endptr = (char *) s;
  80067d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800680:	8b 55 08             	mov    0x8(%ebp),%edx
  800683:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  800685:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800689:	74 07                	je     800692 <strtol+0x158>
  80068b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80068e:	f7 d8                	neg    %eax
  800690:	eb 03                	jmp    800695 <strtol+0x15b>
  800692:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800695:	c9                   	leave  
  800696:	c3                   	ret    

00800697 <memset>:
 * @n:      number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  800697:	55                   	push   %ebp
  800698:	89 e5                	mov    %esp,%ebp
  80069a:	57                   	push   %edi
  80069b:	83 ec 24             	sub    $0x24,%esp
  80069e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006a1:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  8006a4:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
  8006a8:	8b 55 08             	mov    0x8(%ebp),%edx
  8006ab:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8006ae:	88 45 f7             	mov    %al,-0x9(%ebp)
  8006b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8006b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  8006b7:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8006ba:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  8006be:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8006c1:	89 d7                	mov    %edx,%edi
  8006c3:	f3 aa                	rep stos %al,%es:(%edi)
  8006c5:	89 fa                	mov    %edi,%edx
  8006c7:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  8006ca:	89 55 e8             	mov    %edx,-0x18(%ebp)
        "rep; stosb;"
        : "=&c" (d0), "=&D" (d1)
        : "0" (n), "a" (c), "1" (s)
        : "memory");
    return s;
  8006cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8006d0:	90                   	nop
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  8006d1:	83 c4 24             	add    $0x24,%esp
  8006d4:	5f                   	pop    %edi
  8006d5:	5d                   	pop    %ebp
  8006d6:	c3                   	ret    

008006d7 <memmove>:
 * @n:      number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  8006d7:	55                   	push   %ebp
  8006d8:	89 e5                	mov    %esp,%ebp
  8006da:	57                   	push   %edi
  8006db:	56                   	push   %esi
  8006dc:	53                   	push   %ebx
  8006dd:	83 ec 30             	sub    $0x30,%esp
  8006e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006e9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8006ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8006ef:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  8006f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006f5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  8006f8:	73 42                	jae    80073c <memmove+0x65>
  8006fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006fd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800700:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800703:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800706:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800709:	89 45 dc             	mov    %eax,-0x24(%ebp)
        "andl $3, %%ecx;"
        "jz 1f;"
        "rep; movsb;"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  80070c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80070f:	c1 e8 02             	shr    $0x2,%eax
  800712:	89 c1                	mov    %eax,%ecx
#ifndef __HAVE_ARCH_MEMCPY
#define __HAVE_ARCH_MEMCPY
static inline void *
__memcpy(void *dst, const void *src, size_t n) {
    int d0, d1, d2;
    asm volatile (
  800714:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800717:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80071a:	89 d7                	mov    %edx,%edi
  80071c:	89 c6                	mov    %eax,%esi
  80071e:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  800720:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  800723:	83 e1 03             	and    $0x3,%ecx
  800726:	74 02                	je     80072a <memmove+0x53>
  800728:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80072a:	89 f0                	mov    %esi,%eax
  80072c:	89 fa                	mov    %edi,%edx
  80072e:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  800731:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  800734:	89 45 d0             	mov    %eax,-0x30(%ebp)
        "rep; movsb;"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
        : "memory");
    return dst;
  800737:	8b 45 e4             	mov    -0x1c(%ebp),%eax
#ifdef __HAVE_ARCH_MEMMOVE
    return __memmove(dst, src, n);
  80073a:	eb 36                	jmp    800772 <memmove+0x9b>
    asm volatile (
        "std;"
        "rep; movsb;"
        "cld;"
        : "=&c" (d0), "=&S" (d1), "=&D" (d2)
        : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  80073c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80073f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800742:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800745:	01 c2                	add    %eax,%edx
  800747:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80074a:	8d 48 ff             	lea    -0x1(%eax),%ecx
  80074d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800750:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
        return __memcpy(dst, src, n);
    }
    int d0, d1, d2;
    asm volatile (
  800753:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800756:	89 c1                	mov    %eax,%ecx
  800758:	89 d8                	mov    %ebx,%eax
  80075a:	89 d6                	mov    %edx,%esi
  80075c:	89 c7                	mov    %eax,%edi
  80075e:	fd                   	std    
  80075f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800761:	fc                   	cld    
  800762:	89 f8                	mov    %edi,%eax
  800764:	89 f2                	mov    %esi,%edx
  800766:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  800769:	89 55 c8             	mov    %edx,-0x38(%ebp)
  80076c:	89 45 c4             	mov    %eax,-0x3c(%ebp)
        "rep; movsb;"
        "cld;"
        : "=&c" (d0), "=&S" (d1), "=&D" (d2)
        : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
        : "memory");
    return dst;
  80076f:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  800772:	83 c4 30             	add    $0x30,%esp
  800775:	5b                   	pop    %ebx
  800776:	5e                   	pop    %esi
  800777:	5f                   	pop    %edi
  800778:	5d                   	pop    %ebp
  800779:	c3                   	ret    

0080077a <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  80077a:	55                   	push   %ebp
  80077b:	89 e5                	mov    %esp,%ebp
  80077d:	57                   	push   %edi
  80077e:	56                   	push   %esi
  80077f:	83 ec 20             	sub    $0x20,%esp
  800782:	8b 45 08             	mov    0x8(%ebp),%eax
  800785:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800788:	8b 45 0c             	mov    0xc(%ebp),%eax
  80078b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80078e:	8b 45 10             	mov    0x10(%ebp),%eax
  800791:	89 45 ec             	mov    %eax,-0x14(%ebp)
        "andl $3, %%ecx;"
        "jz 1f;"
        "rep; movsb;"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  800794:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800797:	c1 e8 02             	shr    $0x2,%eax
  80079a:	89 c1                	mov    %eax,%ecx
#ifndef __HAVE_ARCH_MEMCPY
#define __HAVE_ARCH_MEMCPY
static inline void *
__memcpy(void *dst, const void *src, size_t n) {
    int d0, d1, d2;
    asm volatile (
  80079c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80079f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007a2:	89 d7                	mov    %edx,%edi
  8007a4:	89 c6                	mov    %eax,%esi
  8007a6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  8007a8:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  8007ab:	83 e1 03             	and    $0x3,%ecx
  8007ae:	74 02                	je     8007b2 <memcpy+0x38>
  8007b0:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8007b2:	89 f0                	mov    %esi,%eax
  8007b4:	89 fa                	mov    %edi,%edx
  8007b6:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  8007b9:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  8007bc:	89 45 e0             	mov    %eax,-0x20(%ebp)
        "rep; movsb;"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
        : "memory");
    return dst;
  8007bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
  8007c2:	90                   	nop
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  8007c3:	83 c4 20             	add    $0x20,%esp
  8007c6:	5e                   	pop    %esi
  8007c7:	5f                   	pop    %edi
  8007c8:	5d                   	pop    %ebp
  8007c9:	c3                   	ret    

008007ca <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  8007ca:	55                   	push   %ebp
  8007cb:	89 e5                	mov    %esp,%ebp
  8007cd:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  8007d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d3:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  8007d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007d9:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  8007dc:	eb 30                	jmp    80080e <memcmp+0x44>
        if (*s1 != *s2) {
  8007de:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8007e1:	0f b6 10             	movzbl (%eax),%edx
  8007e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8007e7:	0f b6 00             	movzbl (%eax),%eax
  8007ea:	38 c2                	cmp    %al,%dl
  8007ec:	74 18                	je     800806 <memcmp+0x3c>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  8007ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8007f1:	0f b6 00             	movzbl (%eax),%eax
  8007f4:	0f b6 d0             	movzbl %al,%edx
  8007f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8007fa:	0f b6 00             	movzbl (%eax),%eax
  8007fd:	0f b6 c0             	movzbl %al,%eax
  800800:	29 c2                	sub    %eax,%edx
  800802:	89 d0                	mov    %edx,%eax
  800804:	eb 1a                	jmp    800820 <memcmp+0x56>
        }
        s1 ++, s2 ++;
  800806:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  80080a:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
    const char *s1 = (const char *)v1;
    const char *s2 = (const char *)v2;
    while (n -- > 0) {
  80080e:	8b 45 10             	mov    0x10(%ebp),%eax
  800811:	8d 50 ff             	lea    -0x1(%eax),%edx
  800814:	89 55 10             	mov    %edx,0x10(%ebp)
  800817:	85 c0                	test   %eax,%eax
  800819:	75 c3                	jne    8007de <memcmp+0x14>
        if (*s1 != *s2) {
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
        }
        s1 ++, s2 ++;
    }
    return 0;
  80081b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800820:	c9                   	leave  
  800821:	c3                   	ret    

00800822 <printnum>:
 * @width:      maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:       character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  800822:	55                   	push   %ebp
  800823:	89 e5                	mov    %esp,%ebp
  800825:	83 ec 38             	sub    $0x38,%esp
  800828:	8b 45 10             	mov    0x10(%ebp),%eax
  80082b:	89 45 d0             	mov    %eax,-0x30(%ebp)
  80082e:	8b 45 14             	mov    0x14(%ebp),%eax
  800831:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  800834:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800837:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80083a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  80083d:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  800840:	8b 45 18             	mov    0x18(%ebp),%eax
  800843:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800846:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800849:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80084c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  80084f:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800852:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800855:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800858:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80085c:	74 1c                	je     80087a <printnum+0x58>
  80085e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800861:	ba 00 00 00 00       	mov    $0x0,%edx
  800866:	f7 75 e4             	divl   -0x1c(%ebp)
  800869:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80086c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80086f:	ba 00 00 00 00       	mov    $0x0,%edx
  800874:	f7 75 e4             	divl   -0x1c(%ebp)
  800877:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80087a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80087d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800880:	f7 75 e4             	divl   -0x1c(%ebp)
  800883:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800886:	89 55 dc             	mov    %edx,-0x24(%ebp)
  800889:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80088c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80088f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  800892:	89 55 ec             	mov    %edx,-0x14(%ebp)
  800895:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800898:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  80089b:	8b 45 18             	mov    0x18(%ebp),%eax
  80089e:	ba 00 00 00 00       	mov    $0x0,%edx
  8008a3:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  8008a6:	77 41                	ja     8008e9 <printnum+0xc7>
  8008a8:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  8008ab:	72 05                	jb     8008b2 <printnum+0x90>
  8008ad:	3b 45 d0             	cmp    -0x30(%ebp),%eax
  8008b0:	77 37                	ja     8008e9 <printnum+0xc7>
        printnum(putch, putdat, result, base, width - 1, padc);
  8008b2:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8008b5:	83 e8 01             	sub    $0x1,%eax
  8008b8:	83 ec 04             	sub    $0x4,%esp
  8008bb:	ff 75 20             	pushl  0x20(%ebp)
  8008be:	50                   	push   %eax
  8008bf:	ff 75 18             	pushl  0x18(%ebp)
  8008c2:	ff 75 ec             	pushl  -0x14(%ebp)
  8008c5:	ff 75 e8             	pushl  -0x18(%ebp)
  8008c8:	ff 75 0c             	pushl  0xc(%ebp)
  8008cb:	ff 75 08             	pushl  0x8(%ebp)
  8008ce:	e8 4f ff ff ff       	call   800822 <printnum>
  8008d3:	83 c4 20             	add    $0x20,%esp
  8008d6:	eb 1b                	jmp    8008f3 <printnum+0xd1>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  8008d8:	83 ec 08             	sub    $0x8,%esp
  8008db:	ff 75 0c             	pushl  0xc(%ebp)
  8008de:	ff 75 20             	pushl  0x20(%ebp)
  8008e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e4:	ff d0                	call   *%eax
  8008e6:	83 c4 10             	add    $0x10,%esp
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  8008e9:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
  8008ed:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8008f1:	7f e5                	jg     8008d8 <printnum+0xb6>
            putch(padc, putdat);
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  8008f3:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8008f6:	05 c4 11 80 00       	add    $0x8011c4,%eax
  8008fb:	0f b6 00             	movzbl (%eax),%eax
  8008fe:	0f be c0             	movsbl %al,%eax
  800901:	83 ec 08             	sub    $0x8,%esp
  800904:	ff 75 0c             	pushl  0xc(%ebp)
  800907:	50                   	push   %eax
  800908:	8b 45 08             	mov    0x8(%ebp),%eax
  80090b:	ff d0                	call   *%eax
  80090d:	83 c4 10             	add    $0x10,%esp
}
  800910:	90                   	nop
  800911:	c9                   	leave  
  800912:	c3                   	ret    

00800913 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:         a varargs list pointer
 * @lflag:      determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  800913:	55                   	push   %ebp
  800914:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  800916:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80091a:	7e 14                	jle    800930 <getuint+0x1d>
        return va_arg(*ap, unsigned long long);
  80091c:	8b 45 08             	mov    0x8(%ebp),%eax
  80091f:	8b 00                	mov    (%eax),%eax
  800921:	8d 48 08             	lea    0x8(%eax),%ecx
  800924:	8b 55 08             	mov    0x8(%ebp),%edx
  800927:	89 0a                	mov    %ecx,(%edx)
  800929:	8b 50 04             	mov    0x4(%eax),%edx
  80092c:	8b 00                	mov    (%eax),%eax
  80092e:	eb 30                	jmp    800960 <getuint+0x4d>
    }
    else if (lflag) {
  800930:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800934:	74 16                	je     80094c <getuint+0x39>
        return va_arg(*ap, unsigned long);
  800936:	8b 45 08             	mov    0x8(%ebp),%eax
  800939:	8b 00                	mov    (%eax),%eax
  80093b:	8d 48 04             	lea    0x4(%eax),%ecx
  80093e:	8b 55 08             	mov    0x8(%ebp),%edx
  800941:	89 0a                	mov    %ecx,(%edx)
  800943:	8b 00                	mov    (%eax),%eax
  800945:	ba 00 00 00 00       	mov    $0x0,%edx
  80094a:	eb 14                	jmp    800960 <getuint+0x4d>
    }
    else {
        return va_arg(*ap, unsigned int);
  80094c:	8b 45 08             	mov    0x8(%ebp),%eax
  80094f:	8b 00                	mov    (%eax),%eax
  800951:	8d 48 04             	lea    0x4(%eax),%ecx
  800954:	8b 55 08             	mov    0x8(%ebp),%edx
  800957:	89 0a                	mov    %ecx,(%edx)
  800959:	8b 00                	mov    (%eax),%eax
  80095b:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  800960:	5d                   	pop    %ebp
  800961:	c3                   	ret    

00800962 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:         a varargs list pointer
 * @lflag:      determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  800962:	55                   	push   %ebp
  800963:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  800965:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800969:	7e 14                	jle    80097f <getint+0x1d>
        return va_arg(*ap, long long);
  80096b:	8b 45 08             	mov    0x8(%ebp),%eax
  80096e:	8b 00                	mov    (%eax),%eax
  800970:	8d 48 08             	lea    0x8(%eax),%ecx
  800973:	8b 55 08             	mov    0x8(%ebp),%edx
  800976:	89 0a                	mov    %ecx,(%edx)
  800978:	8b 50 04             	mov    0x4(%eax),%edx
  80097b:	8b 00                	mov    (%eax),%eax
  80097d:	eb 28                	jmp    8009a7 <getint+0x45>
    }
    else if (lflag) {
  80097f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800983:	74 12                	je     800997 <getint+0x35>
        return va_arg(*ap, long);
  800985:	8b 45 08             	mov    0x8(%ebp),%eax
  800988:	8b 00                	mov    (%eax),%eax
  80098a:	8d 48 04             	lea    0x4(%eax),%ecx
  80098d:	8b 55 08             	mov    0x8(%ebp),%edx
  800990:	89 0a                	mov    %ecx,(%edx)
  800992:	8b 00                	mov    (%eax),%eax
  800994:	99                   	cltd   
  800995:	eb 10                	jmp    8009a7 <getint+0x45>
    }
    else {
        return va_arg(*ap, int);
  800997:	8b 45 08             	mov    0x8(%ebp),%eax
  80099a:	8b 00                	mov    (%eax),%eax
  80099c:	8d 48 04             	lea    0x4(%eax),%ecx
  80099f:	8b 55 08             	mov    0x8(%ebp),%edx
  8009a2:	89 0a                	mov    %ecx,(%edx)
  8009a4:	8b 00                	mov    (%eax),%eax
  8009a6:	99                   	cltd   
    }
}
  8009a7:	5d                   	pop    %ebp
  8009a8:	c3                   	ret    

008009a9 <printfmt>:
 * @putch:      specified putch function, print a single character
 * @putdat:     used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  8009a9:	55                   	push   %ebp
  8009aa:	89 e5                	mov    %esp,%ebp
  8009ac:	83 ec 18             	sub    $0x18,%esp
    va_list ap;

    va_start(ap, fmt);
  8009af:	8d 45 14             	lea    0x14(%ebp),%eax
  8009b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  8009b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009b8:	50                   	push   %eax
  8009b9:	ff 75 10             	pushl  0x10(%ebp)
  8009bc:	ff 75 0c             	pushl  0xc(%ebp)
  8009bf:	ff 75 08             	pushl  0x8(%ebp)
  8009c2:	e8 06 00 00 00       	call   8009cd <vprintfmt>
  8009c7:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
  8009ca:	90                   	nop
  8009cb:	c9                   	leave  
  8009cc:	c3                   	ret    

008009cd <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  8009cd:	55                   	push   %ebp
  8009ce:	89 e5                	mov    %esp,%ebp
  8009d0:	56                   	push   %esi
  8009d1:	53                   	push   %ebx
  8009d2:	83 ec 20             	sub    $0x20,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8009d5:	eb 17                	jmp    8009ee <vprintfmt+0x21>
            if (ch == '\0') {
  8009d7:	85 db                	test   %ebx,%ebx
  8009d9:	0f 84 8e 03 00 00    	je     800d6d <vprintfmt+0x3a0>
                return;
            }
            putch(ch, putdat);
  8009df:	83 ec 08             	sub    $0x8,%esp
  8009e2:	ff 75 0c             	pushl  0xc(%ebp)
  8009e5:	53                   	push   %ebx
  8009e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e9:	ff d0                	call   *%eax
  8009eb:	83 c4 10             	add    $0x10,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8009ee:	8b 45 10             	mov    0x10(%ebp),%eax
  8009f1:	8d 50 01             	lea    0x1(%eax),%edx
  8009f4:	89 55 10             	mov    %edx,0x10(%ebp)
  8009f7:	0f b6 00             	movzbl (%eax),%eax
  8009fa:	0f b6 d8             	movzbl %al,%ebx
  8009fd:	83 fb 25             	cmp    $0x25,%ebx
  800a00:	75 d5                	jne    8009d7 <vprintfmt+0xa>
            }
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
  800a02:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  800a06:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  800a0d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800a10:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  800a13:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  800a1a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800a1d:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  800a20:	8b 45 10             	mov    0x10(%ebp),%eax
  800a23:	8d 50 01             	lea    0x1(%eax),%edx
  800a26:	89 55 10             	mov    %edx,0x10(%ebp)
  800a29:	0f b6 00             	movzbl (%eax),%eax
  800a2c:	0f b6 d8             	movzbl %al,%ebx
  800a2f:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800a32:	83 f8 55             	cmp    $0x55,%eax
  800a35:	0f 87 05 03 00 00    	ja     800d40 <vprintfmt+0x373>
  800a3b:	8b 04 85 e8 11 80 00 	mov    0x8011e8(,%eax,4),%eax
  800a42:	ff e0                	jmp    *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  800a44:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  800a48:	eb d6                	jmp    800a20 <vprintfmt+0x53>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  800a4a:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  800a4e:	eb d0                	jmp    800a20 <vprintfmt+0x53>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  800a50:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  800a57:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800a5a:	89 d0                	mov    %edx,%eax
  800a5c:	c1 e0 02             	shl    $0x2,%eax
  800a5f:	01 d0                	add    %edx,%eax
  800a61:	01 c0                	add    %eax,%eax
  800a63:	01 d8                	add    %ebx,%eax
  800a65:	83 e8 30             	sub    $0x30,%eax
  800a68:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  800a6b:	8b 45 10             	mov    0x10(%ebp),%eax
  800a6e:	0f b6 00             	movzbl (%eax),%eax
  800a71:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  800a74:	83 fb 2f             	cmp    $0x2f,%ebx
  800a77:	7e 39                	jle    800ab2 <vprintfmt+0xe5>
  800a79:	83 fb 39             	cmp    $0x39,%ebx
  800a7c:	7f 34                	jg     800ab2 <vprintfmt+0xe5>
            padc = '0';
            goto reswitch;

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  800a7e:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                precision = precision * 10 + ch - '0';
                ch = *fmt;
                if (ch < '0' || ch > '9') {
                    break;
                }
            }
  800a82:	eb d3                	jmp    800a57 <vprintfmt+0x8a>
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
  800a84:	8b 45 14             	mov    0x14(%ebp),%eax
  800a87:	8d 50 04             	lea    0x4(%eax),%edx
  800a8a:	89 55 14             	mov    %edx,0x14(%ebp)
  800a8d:	8b 00                	mov    (%eax),%eax
  800a8f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  800a92:	eb 1f                	jmp    800ab3 <vprintfmt+0xe6>

        case '.':
            if (width < 0)
  800a94:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800a98:	79 86                	jns    800a20 <vprintfmt+0x53>
                width = 0;
  800a9a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  800aa1:	e9 7a ff ff ff       	jmp    800a20 <vprintfmt+0x53>

        case '#':
            altflag = 1;
  800aa6:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  800aad:	e9 6e ff ff ff       	jmp    800a20 <vprintfmt+0x53>
                ch = *fmt;
                if (ch < '0' || ch > '9') {
                    break;
                }
            }
            goto process_precision;
  800ab2:	90                   	nop
        case '#':
            altflag = 1;
            goto reswitch;

        process_precision:
            if (width < 0)
  800ab3:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800ab7:	0f 89 63 ff ff ff    	jns    800a20 <vprintfmt+0x53>
                width = precision, precision = -1;
  800abd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800ac0:	89 45 e8             	mov    %eax,-0x18(%ebp)
  800ac3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  800aca:	e9 51 ff ff ff       	jmp    800a20 <vprintfmt+0x53>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  800acf:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
            goto reswitch;
  800ad3:	e9 48 ff ff ff       	jmp    800a20 <vprintfmt+0x53>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  800ad8:	8b 45 14             	mov    0x14(%ebp),%eax
  800adb:	8d 50 04             	lea    0x4(%eax),%edx
  800ade:	89 55 14             	mov    %edx,0x14(%ebp)
  800ae1:	8b 00                	mov    (%eax),%eax
  800ae3:	83 ec 08             	sub    $0x8,%esp
  800ae6:	ff 75 0c             	pushl  0xc(%ebp)
  800ae9:	50                   	push   %eax
  800aea:	8b 45 08             	mov    0x8(%ebp),%eax
  800aed:	ff d0                	call   *%eax
  800aef:	83 c4 10             	add    $0x10,%esp
            break;
  800af2:	e9 71 02 00 00       	jmp    800d68 <vprintfmt+0x39b>

        // error message
        case 'e':
            err = va_arg(ap, int);
  800af7:	8b 45 14             	mov    0x14(%ebp),%eax
  800afa:	8d 50 04             	lea    0x4(%eax),%edx
  800afd:	89 55 14             	mov    %edx,0x14(%ebp)
  800b00:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  800b02:	85 db                	test   %ebx,%ebx
  800b04:	79 02                	jns    800b08 <vprintfmt+0x13b>
                err = -err;
  800b06:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  800b08:	83 fb 18             	cmp    $0x18,%ebx
  800b0b:	7f 0b                	jg     800b18 <vprintfmt+0x14b>
  800b0d:	8b 34 9d 60 11 80 00 	mov    0x801160(,%ebx,4),%esi
  800b14:	85 f6                	test   %esi,%esi
  800b16:	75 19                	jne    800b31 <vprintfmt+0x164>
                printfmt(putch, putdat, "error %d", err);
  800b18:	53                   	push   %ebx
  800b19:	68 d5 11 80 00       	push   $0x8011d5
  800b1e:	ff 75 0c             	pushl  0xc(%ebp)
  800b21:	ff 75 08             	pushl  0x8(%ebp)
  800b24:	e8 80 fe ff ff       	call   8009a9 <printfmt>
  800b29:	83 c4 10             	add    $0x10,%esp
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  800b2c:	e9 37 02 00 00       	jmp    800d68 <vprintfmt+0x39b>
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
                printfmt(putch, putdat, "error %d", err);
            }
            else {
                printfmt(putch, putdat, "%s", p);
  800b31:	56                   	push   %esi
  800b32:	68 de 11 80 00       	push   $0x8011de
  800b37:	ff 75 0c             	pushl  0xc(%ebp)
  800b3a:	ff 75 08             	pushl  0x8(%ebp)
  800b3d:	e8 67 fe ff ff       	call   8009a9 <printfmt>
  800b42:	83 c4 10             	add    $0x10,%esp
            }
            break;
  800b45:	e9 1e 02 00 00       	jmp    800d68 <vprintfmt+0x39b>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  800b4a:	8b 45 14             	mov    0x14(%ebp),%eax
  800b4d:	8d 50 04             	lea    0x4(%eax),%edx
  800b50:	89 55 14             	mov    %edx,0x14(%ebp)
  800b53:	8b 30                	mov    (%eax),%esi
  800b55:	85 f6                	test   %esi,%esi
  800b57:	75 05                	jne    800b5e <vprintfmt+0x191>
                p = "(null)";
  800b59:	be e1 11 80 00       	mov    $0x8011e1,%esi
            }
            if (width > 0 && padc != '-') {
  800b5e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800b62:	7e 76                	jle    800bda <vprintfmt+0x20d>
  800b64:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800b68:	74 70                	je     800bda <vprintfmt+0x20d>
                for (width -= strnlen(p, precision); width > 0; width --) {
  800b6a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800b6d:	83 ec 08             	sub    $0x8,%esp
  800b70:	50                   	push   %eax
  800b71:	56                   	push   %esi
  800b72:	e8 17 f8 ff ff       	call   80038e <strnlen>
  800b77:	83 c4 10             	add    $0x10,%esp
  800b7a:	89 c2                	mov    %eax,%edx
  800b7c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b7f:	29 d0                	sub    %edx,%eax
  800b81:	89 45 e8             	mov    %eax,-0x18(%ebp)
  800b84:	eb 17                	jmp    800b9d <vprintfmt+0x1d0>
                    putch(padc, putdat);
  800b86:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800b8a:	83 ec 08             	sub    $0x8,%esp
  800b8d:	ff 75 0c             	pushl  0xc(%ebp)
  800b90:	50                   	push   %eax
  800b91:	8b 45 08             	mov    0x8(%ebp),%eax
  800b94:	ff d0                	call   *%eax
  800b96:	83 c4 10             	add    $0x10,%esp
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
                p = "(null)";
            }
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
  800b99:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  800b9d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800ba1:	7f e3                	jg     800b86 <vprintfmt+0x1b9>
                    putch(padc, putdat);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800ba3:	eb 35                	jmp    800bda <vprintfmt+0x20d>
                if (altflag && (ch < ' ' || ch > '~')) {
  800ba5:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800ba9:	74 1c                	je     800bc7 <vprintfmt+0x1fa>
  800bab:	83 fb 1f             	cmp    $0x1f,%ebx
  800bae:	7e 05                	jle    800bb5 <vprintfmt+0x1e8>
  800bb0:	83 fb 7e             	cmp    $0x7e,%ebx
  800bb3:	7e 12                	jle    800bc7 <vprintfmt+0x1fa>
                    putch('?', putdat);
  800bb5:	83 ec 08             	sub    $0x8,%esp
  800bb8:	ff 75 0c             	pushl  0xc(%ebp)
  800bbb:	6a 3f                	push   $0x3f
  800bbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc0:	ff d0                	call   *%eax
  800bc2:	83 c4 10             	add    $0x10,%esp
  800bc5:	eb 0f                	jmp    800bd6 <vprintfmt+0x209>
                }
                else {
                    putch(ch, putdat);
  800bc7:	83 ec 08             	sub    $0x8,%esp
  800bca:	ff 75 0c             	pushl  0xc(%ebp)
  800bcd:	53                   	push   %ebx
  800bce:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd1:	ff d0                	call   *%eax
  800bd3:	83 c4 10             	add    $0x10,%esp
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
                    putch(padc, putdat);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800bd6:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  800bda:	89 f0                	mov    %esi,%eax
  800bdc:	8d 70 01             	lea    0x1(%eax),%esi
  800bdf:	0f b6 00             	movzbl (%eax),%eax
  800be2:	0f be d8             	movsbl %al,%ebx
  800be5:	85 db                	test   %ebx,%ebx
  800be7:	74 26                	je     800c0f <vprintfmt+0x242>
  800be9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bed:	78 b6                	js     800ba5 <vprintfmt+0x1d8>
  800bef:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
  800bf3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bf7:	79 ac                	jns    800ba5 <vprintfmt+0x1d8>
                }
                else {
                    putch(ch, putdat);
                }
            }
            for (; width > 0; width --) {
  800bf9:	eb 14                	jmp    800c0f <vprintfmt+0x242>
                putch(' ', putdat);
  800bfb:	83 ec 08             	sub    $0x8,%esp
  800bfe:	ff 75 0c             	pushl  0xc(%ebp)
  800c01:	6a 20                	push   $0x20
  800c03:	8b 45 08             	mov    0x8(%ebp),%eax
  800c06:	ff d0                	call   *%eax
  800c08:	83 c4 10             	add    $0x10,%esp
                }
                else {
                    putch(ch, putdat);
                }
            }
            for (; width > 0; width --) {
  800c0b:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  800c0f:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800c13:	7f e6                	jg     800bfb <vprintfmt+0x22e>
                putch(' ', putdat);
            }
            break;
  800c15:	e9 4e 01 00 00       	jmp    800d68 <vprintfmt+0x39b>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  800c1a:	83 ec 08             	sub    $0x8,%esp
  800c1d:	ff 75 e0             	pushl  -0x20(%ebp)
  800c20:	8d 45 14             	lea    0x14(%ebp),%eax
  800c23:	50                   	push   %eax
  800c24:	e8 39 fd ff ff       	call   800962 <getint>
  800c29:	83 c4 10             	add    $0x10,%esp
  800c2c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c2f:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  800c32:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c35:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c38:	85 d2                	test   %edx,%edx
  800c3a:	79 23                	jns    800c5f <vprintfmt+0x292>
                putch('-', putdat);
  800c3c:	83 ec 08             	sub    $0x8,%esp
  800c3f:	ff 75 0c             	pushl  0xc(%ebp)
  800c42:	6a 2d                	push   $0x2d
  800c44:	8b 45 08             	mov    0x8(%ebp),%eax
  800c47:	ff d0                	call   *%eax
  800c49:	83 c4 10             	add    $0x10,%esp
                num = -(long long)num;
  800c4c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c4f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c52:	f7 d8                	neg    %eax
  800c54:	83 d2 00             	adc    $0x0,%edx
  800c57:	f7 da                	neg    %edx
  800c59:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c5c:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  800c5f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  800c66:	e9 9f 00 00 00       	jmp    800d0a <vprintfmt+0x33d>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  800c6b:	83 ec 08             	sub    $0x8,%esp
  800c6e:	ff 75 e0             	pushl  -0x20(%ebp)
  800c71:	8d 45 14             	lea    0x14(%ebp),%eax
  800c74:	50                   	push   %eax
  800c75:	e8 99 fc ff ff       	call   800913 <getuint>
  800c7a:	83 c4 10             	add    $0x10,%esp
  800c7d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c80:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  800c83:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  800c8a:	eb 7e                	jmp    800d0a <vprintfmt+0x33d>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  800c8c:	83 ec 08             	sub    $0x8,%esp
  800c8f:	ff 75 e0             	pushl  -0x20(%ebp)
  800c92:	8d 45 14             	lea    0x14(%ebp),%eax
  800c95:	50                   	push   %eax
  800c96:	e8 78 fc ff ff       	call   800913 <getuint>
  800c9b:	83 c4 10             	add    $0x10,%esp
  800c9e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ca1:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  800ca4:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  800cab:	eb 5d                	jmp    800d0a <vprintfmt+0x33d>

        // pointer
        case 'p':
            putch('0', putdat);
  800cad:	83 ec 08             	sub    $0x8,%esp
  800cb0:	ff 75 0c             	pushl  0xc(%ebp)
  800cb3:	6a 30                	push   $0x30
  800cb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb8:	ff d0                	call   *%eax
  800cba:	83 c4 10             	add    $0x10,%esp
            putch('x', putdat);
  800cbd:	83 ec 08             	sub    $0x8,%esp
  800cc0:	ff 75 0c             	pushl  0xc(%ebp)
  800cc3:	6a 78                	push   $0x78
  800cc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc8:	ff d0                	call   *%eax
  800cca:	83 c4 10             	add    $0x10,%esp
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  800ccd:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd0:	8d 50 04             	lea    0x4(%eax),%edx
  800cd3:	89 55 14             	mov    %edx,0x14(%ebp)
  800cd6:	8b 00                	mov    (%eax),%eax
  800cd8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cdb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  800ce2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  800ce9:	eb 1f                	jmp    800d0a <vprintfmt+0x33d>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  800ceb:	83 ec 08             	sub    $0x8,%esp
  800cee:	ff 75 e0             	pushl  -0x20(%ebp)
  800cf1:	8d 45 14             	lea    0x14(%ebp),%eax
  800cf4:	50                   	push   %eax
  800cf5:	e8 19 fc ff ff       	call   800913 <getuint>
  800cfa:	83 c4 10             	add    $0x10,%esp
  800cfd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d00:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  800d03:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  800d0a:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800d0e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d11:	83 ec 04             	sub    $0x4,%esp
  800d14:	52                   	push   %edx
  800d15:	ff 75 e8             	pushl  -0x18(%ebp)
  800d18:	50                   	push   %eax
  800d19:	ff 75 f4             	pushl  -0xc(%ebp)
  800d1c:	ff 75 f0             	pushl  -0x10(%ebp)
  800d1f:	ff 75 0c             	pushl  0xc(%ebp)
  800d22:	ff 75 08             	pushl  0x8(%ebp)
  800d25:	e8 f8 fa ff ff       	call   800822 <printnum>
  800d2a:	83 c4 20             	add    $0x20,%esp
            break;
  800d2d:	eb 39                	jmp    800d68 <vprintfmt+0x39b>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  800d2f:	83 ec 08             	sub    $0x8,%esp
  800d32:	ff 75 0c             	pushl  0xc(%ebp)
  800d35:	53                   	push   %ebx
  800d36:	8b 45 08             	mov    0x8(%ebp),%eax
  800d39:	ff d0                	call   *%eax
  800d3b:	83 c4 10             	add    $0x10,%esp
            break;
  800d3e:	eb 28                	jmp    800d68 <vprintfmt+0x39b>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  800d40:	83 ec 08             	sub    $0x8,%esp
  800d43:	ff 75 0c             	pushl  0xc(%ebp)
  800d46:	6a 25                	push   $0x25
  800d48:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4b:	ff d0                	call   *%eax
  800d4d:	83 c4 10             	add    $0x10,%esp
            for (fmt --; fmt[-1] != '%'; fmt --)
  800d50:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  800d54:	eb 04                	jmp    800d5a <vprintfmt+0x38d>
  800d56:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  800d5a:	8b 45 10             	mov    0x10(%ebp),%eax
  800d5d:	83 e8 01             	sub    $0x1,%eax
  800d60:	0f b6 00             	movzbl (%eax),%eax
  800d63:	3c 25                	cmp    $0x25,%al
  800d65:	75 ef                	jne    800d56 <vprintfmt+0x389>
                /* do nothing */;
            break;
  800d67:	90                   	nop
        }
    }
  800d68:	e9 68 fc ff ff       	jmp    8009d5 <vprintfmt+0x8>
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
            if (ch == '\0') {
                return;
  800d6d:	90                   	nop
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  800d6e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800d71:	5b                   	pop    %ebx
  800d72:	5e                   	pop    %esi
  800d73:	5d                   	pop    %ebp
  800d74:	c3                   	ret    

00800d75 <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:         the character will be printed
 * @b:          the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  800d75:	55                   	push   %ebp
  800d76:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  800d78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d7b:	8b 40 08             	mov    0x8(%eax),%eax
  800d7e:	8d 50 01             	lea    0x1(%eax),%edx
  800d81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d84:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  800d87:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d8a:	8b 10                	mov    (%eax),%edx
  800d8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d8f:	8b 40 04             	mov    0x4(%eax),%eax
  800d92:	39 c2                	cmp    %eax,%edx
  800d94:	73 12                	jae    800da8 <sprintputch+0x33>
        *b->buf ++ = ch;
  800d96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d99:	8b 00                	mov    (%eax),%eax
  800d9b:	8d 48 01             	lea    0x1(%eax),%ecx
  800d9e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800da1:	89 0a                	mov    %ecx,(%edx)
  800da3:	8b 55 08             	mov    0x8(%ebp),%edx
  800da6:	88 10                	mov    %dl,(%eax)
    }
}
  800da8:	90                   	nop
  800da9:	5d                   	pop    %ebp
  800daa:	c3                   	ret    

00800dab <snprintf>:
 * @str:        the buffer to place the result into
 * @size:       the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  800dab:	55                   	push   %ebp
  800dac:	89 e5                	mov    %esp,%ebp
  800dae:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  800db1:	8d 45 14             	lea    0x14(%ebp),%eax
  800db4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  800db7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dba:	50                   	push   %eax
  800dbb:	ff 75 10             	pushl  0x10(%ebp)
  800dbe:	ff 75 0c             	pushl  0xc(%ebp)
  800dc1:	ff 75 08             	pushl  0x8(%ebp)
  800dc4:	e8 0b 00 00 00       	call   800dd4 <vsnprintf>
  800dc9:	83 c4 10             	add    $0x10,%esp
  800dcc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  800dcf:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800dd2:	c9                   	leave  
  800dd3:	c3                   	ret    

00800dd4 <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  800dd4:	55                   	push   %ebp
  800dd5:	89 e5                	mov    %esp,%ebp
  800dd7:	83 ec 18             	sub    $0x18,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  800dda:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800de0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800de6:	8b 45 08             	mov    0x8(%ebp),%eax
  800de9:	01 d0                	add    %edx,%eax
  800deb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dee:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  800df5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800df9:	74 0a                	je     800e05 <vsnprintf+0x31>
  800dfb:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800dfe:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e01:	39 c2                	cmp    %eax,%edx
  800e03:	76 07                	jbe    800e0c <vsnprintf+0x38>
        return -E_INVAL;
  800e05:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  800e0a:	eb 20                	jmp    800e2c <vsnprintf+0x58>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  800e0c:	ff 75 14             	pushl  0x14(%ebp)
  800e0f:	ff 75 10             	pushl  0x10(%ebp)
  800e12:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800e15:	50                   	push   %eax
  800e16:	68 75 0d 80 00       	push   $0x800d75
  800e1b:	e8 ad fb ff ff       	call   8009cd <vprintfmt>
  800e20:	83 c4 10             	add    $0x10,%esp
    // null terminate the buffer
    *b.buf = '\0';
  800e23:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e26:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  800e29:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800e2c:	c9                   	leave  
  800e2d:	c3                   	ret    

00800e2e <hash32>:
 * @bits:   the number of bits in a return value
 *
 * High bits are more random, so we use them.
 * */
uint32_t
hash32(uint32_t val, unsigned int bits) {
  800e2e:	55                   	push   %ebp
  800e2f:	89 e5                	mov    %esp,%ebp
  800e31:	83 ec 10             	sub    $0x10,%esp
    uint32_t hash = val * GOLDEN_RATIO_PRIME_32;
  800e34:	8b 45 08             	mov    0x8(%ebp),%eax
  800e37:	69 c0 01 00 37 9e    	imul   $0x9e370001,%eax,%eax
  800e3d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return (hash >> (32 - bits));
  800e40:	b8 20 00 00 00       	mov    $0x20,%eax
  800e45:	2b 45 0c             	sub    0xc(%ebp),%eax
  800e48:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e4b:	89 c1                	mov    %eax,%ecx
  800e4d:	d3 ea                	shr    %cl,%edx
  800e4f:	89 d0                	mov    %edx,%eax
}
  800e51:	c9                   	leave  
  800e52:	c3                   	ret    

00800e53 <rand>:
 * rand - returns a pseudo-random integer
 *
 * The rand() function return a value in the range [0, RAND_MAX].
 * */
int
rand(void) {
  800e53:	55                   	push   %ebp
  800e54:	89 e5                	mov    %esp,%ebp
  800e56:	57                   	push   %edi
  800e57:	56                   	push   %esi
  800e58:	53                   	push   %ebx
  800e59:	83 ec 24             	sub    $0x24,%esp
    next = (next * 0x5DEECE66DLL + 0xBLL) & ((1LL << 48) - 1);
  800e5c:	a1 00 20 80 00       	mov    0x802000,%eax
  800e61:	8b 15 04 20 80 00    	mov    0x802004,%edx
  800e67:	69 fa 6d e6 ec de    	imul   $0xdeece66d,%edx,%edi
  800e6d:	6b f0 05             	imul   $0x5,%eax,%esi
  800e70:	01 fe                	add    %edi,%esi
  800e72:	bf 6d e6 ec de       	mov    $0xdeece66d,%edi
  800e77:	f7 e7                	mul    %edi
  800e79:	01 d6                	add    %edx,%esi
  800e7b:	89 f2                	mov    %esi,%edx
  800e7d:	83 c0 0b             	add    $0xb,%eax
  800e80:	83 d2 00             	adc    $0x0,%edx
  800e83:	89 c7                	mov    %eax,%edi
  800e85:	83 e7 ff             	and    $0xffffffff,%edi
  800e88:	89 f9                	mov    %edi,%ecx
  800e8a:	0f b7 da             	movzwl %dx,%ebx
  800e8d:	89 0d 00 20 80 00    	mov    %ecx,0x802000
  800e93:	89 1d 04 20 80 00    	mov    %ebx,0x802004
    unsigned long long result = (next >> 12);
  800e99:	a1 00 20 80 00       	mov    0x802000,%eax
  800e9e:	8b 15 04 20 80 00    	mov    0x802004,%edx
  800ea4:	0f ac d0 0c          	shrd   $0xc,%edx,%eax
  800ea8:	c1 ea 0c             	shr    $0xc,%edx
  800eab:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800eae:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return (int)do_div(result, RAND_MAX + 1);
  800eb1:	c7 45 dc 00 00 00 80 	movl   $0x80000000,-0x24(%ebp)
  800eb8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ebb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800ebe:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800ec1:	89 55 e8             	mov    %edx,-0x18(%ebp)
  800ec4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800ec7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800eca:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800ece:	74 1c                	je     800eec <rand+0x99>
  800ed0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800ed3:	ba 00 00 00 00       	mov    $0x0,%edx
  800ed8:	f7 75 dc             	divl   -0x24(%ebp)
  800edb:	89 55 ec             	mov    %edx,-0x14(%ebp)
  800ede:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800ee1:	ba 00 00 00 00       	mov    $0x0,%edx
  800ee6:	f7 75 dc             	divl   -0x24(%ebp)
  800ee9:	89 45 e8             	mov    %eax,-0x18(%ebp)
  800eec:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800eef:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800ef2:	f7 75 dc             	divl   -0x24(%ebp)
  800ef5:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800ef8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  800efb:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800efe:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800f01:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800f04:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  800f07:	8b 45 d4             	mov    -0x2c(%ebp),%eax
}
  800f0a:	83 c4 24             	add    $0x24,%esp
  800f0d:	5b                   	pop    %ebx
  800f0e:	5e                   	pop    %esi
  800f0f:	5f                   	pop    %edi
  800f10:	5d                   	pop    %ebp
  800f11:	c3                   	ret    

00800f12 <srand>:
/* *
 * srand - seed the random number generator with the given number
 * @seed:   the required seed number
 * */
void
srand(unsigned int seed) {
  800f12:	55                   	push   %ebp
  800f13:	89 e5                	mov    %esp,%ebp
    next = seed;
  800f15:	8b 45 08             	mov    0x8(%ebp),%eax
  800f18:	ba 00 00 00 00       	mov    $0x0,%edx
  800f1d:	a3 00 20 80 00       	mov    %eax,0x802000
  800f22:	89 15 04 20 80 00    	mov    %edx,0x802004
}
  800f28:	90                   	nop
  800f29:	5d                   	pop    %ebp
  800f2a:	c3                   	ret    

00800f2b <main>:
#include <stdio.h>
#include <ulib.h>

int
main(void) {
  800f2b:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  800f2f:	83 e4 f0             	and    $0xfffffff0,%esp
  800f32:	ff 71 fc             	pushl  -0x4(%ecx)
  800f35:	55                   	push   %ebp
  800f36:	89 e5                	mov    %esp,%ebp
  800f38:	51                   	push   %ecx
  800f39:	83 ec 14             	sub    $0x14,%esp
    int pid, exit_code;
    if ((pid = fork()) == 0) {
  800f3c:	e8 9c f2 ff ff       	call   8001dd <fork>
  800f41:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f44:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800f48:	75 35                	jne    800f7f <main+0x54>
        cprintf("fork ok.\n");
  800f4a:	83 ec 0c             	sub    $0xc,%esp
  800f4d:	68 40 13 80 00       	push   $0x801340
  800f52:	e8 82 f3 ff ff       	call   8002d9 <cprintf>
  800f57:	83 c4 10             	add    $0x10,%esp
        int i;
        for (i = 0; i < 10; i ++) {
  800f5a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800f61:	eb 09                	jmp    800f6c <main+0x41>
            yield();
  800f63:	e8 b2 f2 ff ff       	call   80021a <yield>
main(void) {
    int pid, exit_code;
    if ((pid = fork()) == 0) {
        cprintf("fork ok.\n");
        int i;
        for (i = 0; i < 10; i ++) {
  800f68:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  800f6c:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
  800f70:	7e f1                	jle    800f63 <main+0x38>
            yield();
        }
        exit(0xbeaf);
  800f72:	83 ec 0c             	sub    $0xc,%esp
  800f75:	68 af be 00 00       	push   $0xbeaf
  800f7a:	e8 38 f2 ff ff       	call   8001b7 <exit>
    }
    assert(pid > 0);
  800f7f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800f83:	7f 16                	jg     800f9b <main+0x70>
  800f85:	68 4a 13 80 00       	push   $0x80134a
  800f8a:	68 52 13 80 00       	push   $0x801352
  800f8f:	6a 0f                	push   $0xf
  800f91:	68 67 13 80 00       	push   $0x801367
  800f96:	e8 85 f0 ff ff       	call   800020 <__panic>
    assert(waitpid(-1, NULL) != 0);
  800f9b:	83 ec 08             	sub    $0x8,%esp
  800f9e:	6a 00                	push   $0x0
  800fa0:	6a ff                	push   $0xffffffff
  800fa2:	e8 5a f2 ff ff       	call   800201 <waitpid>
  800fa7:	83 c4 10             	add    $0x10,%esp
  800faa:	85 c0                	test   %eax,%eax
  800fac:	75 16                	jne    800fc4 <main+0x99>
  800fae:	68 75 13 80 00       	push   $0x801375
  800fb3:	68 52 13 80 00       	push   $0x801352
  800fb8:	6a 10                	push   $0x10
  800fba:	68 67 13 80 00       	push   $0x801367
  800fbf:	e8 5c f0 ff ff       	call   800020 <__panic>
    assert(waitpid(pid, (void *)0xC0000000) != 0);
  800fc4:	83 ec 08             	sub    $0x8,%esp
  800fc7:	68 00 00 00 c0       	push   $0xc0000000
  800fcc:	ff 75 f0             	pushl  -0x10(%ebp)
  800fcf:	e8 2d f2 ff ff       	call   800201 <waitpid>
  800fd4:	83 c4 10             	add    $0x10,%esp
  800fd7:	85 c0                	test   %eax,%eax
  800fd9:	75 16                	jne    800ff1 <main+0xc6>
  800fdb:	68 8c 13 80 00       	push   $0x80138c
  800fe0:	68 52 13 80 00       	push   $0x801352
  800fe5:	6a 11                	push   $0x11
  800fe7:	68 67 13 80 00       	push   $0x801367
  800fec:	e8 2f f0 ff ff       	call   800020 <__panic>
    assert(waitpid(pid, &exit_code) == 0 && exit_code == 0xbeaf);
  800ff1:	83 ec 08             	sub    $0x8,%esp
  800ff4:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ff7:	50                   	push   %eax
  800ff8:	ff 75 f0             	pushl  -0x10(%ebp)
  800ffb:	e8 01 f2 ff ff       	call   800201 <waitpid>
  801000:	83 c4 10             	add    $0x10,%esp
  801003:	85 c0                	test   %eax,%eax
  801005:	75 0a                	jne    801011 <main+0xe6>
  801007:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80100a:	3d af be 00 00       	cmp    $0xbeaf,%eax
  80100f:	74 16                	je     801027 <main+0xfc>
  801011:	68 b4 13 80 00       	push   $0x8013b4
  801016:	68 52 13 80 00       	push   $0x801352
  80101b:	6a 12                	push   $0x12
  80101d:	68 67 13 80 00       	push   $0x801367
  801022:	e8 f9 ef ff ff       	call   800020 <__panic>
    cprintf("badarg pass.\n");
  801027:	83 ec 0c             	sub    $0xc,%esp
  80102a:	68 e9 13 80 00       	push   $0x8013e9
  80102f:	e8 a5 f2 ff ff       	call   8002d9 <cprintf>
  801034:	83 c4 10             	add    $0x10,%esp
    return 0;
  801037:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80103c:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80103f:	c9                   	leave  
  801040:	8d 61 fc             	lea    -0x4(%ecx),%esp
  801043:	c3                   	ret    
