#lec9 虚存置换算法spoc练习

## 小组思考题目


----

(1)（spoc）请证明为何LRU算法不会出现belady现象

证明：
       等价于证明：小的物理页帧的栈 包含于 大的物理页帧的栈
       设s(t)为t时刻小的栈，s'(t)为t时刻大的栈。下面利用数学归纳法证明s(t) 包含于 s'(t)
            
      设当 k = t-1 时 s(k)包含于s'(k)，证当k = t时，s(t)依然包含于s'(t)。
      设a,b,c是页帧，下面分三种情况讨论：
            (1) b同时属于s(t)和s'(t)：此时s(t)和s'(t)都不发生变化，满足包含关系；
            (2) b不属于s(t),属于s'(t)：s(t) 替换后，由于b∈s(t)，所以s(t)包含于s'(t)
            (3) 对于b同时不属于s(t-1)和s'(t-1)的情况，由于s(t-1)包含于s'(t-1),所以s(t-1)内每一个元素都存在于s'(t-1)中。
                两个栈都是按最后一次访问的时间的顺序来排列的，由于s(t)在进行替换时会替换s(t-1)里面最长时间没被访问的元素(在栈底)，设为a,那么a显然也存在于s'(t-1)里面，并且它不一定是s'(t-1)的栈底。下面有两种情况：
                    i.  当a是s'(t-1)的栈底时，s(t)和s'(t)替换的都是a, 易知替换后s(t)包含于s'(t)。
                    ii. 当a不是s'(t-1)的栈底是，则s'(t-1)的栈底c必然不属于s(t-1)，因为c比a有更长的时间未被访问，替换后s(t)和s'(t)依然满足包含关系。
       由归纳假设可知s(t) 始终包含于 s'(t)


(2)（spoc）根据你的`学号 mod 4`的结果值，确定选择四种页面置换算法（0：LRU置换算法，1:改进的clock 页置换算法，2：工作集页置换算法，3：缺页率置换算法）中的一种来设计一个应用程序（可基于python, ruby, C, C++，LISP等）模拟实现，并给出测试。请参考如python代码或独自实现。
 - [页置换算法实现的参考实例](https://github.com/chyyuu/ucore_lab/blob/master/related_info/lab3/page-replacement-policy.py)

早先实现的LRU算法：

```
#include <iostream>
#include <cstdlib>
#include <cstring>

using namespace std;

int lackNum = 0;
int maxPageNum = 3;

class Stack{
private:
	int seq;
	int page[100];
public:
	Stack(){seq = 0;memset(page,0,100);}
	void access(int pagenum){
		for(int i = 0; i < seq; i++){
			if(page[i] == pagenum){
				for(int j = i; j < seq-1; j++){
					page[j] = page[j+1];
				}
				page[seq-1] = pagenum;
				return;	
			}	
		}
		lackNum ++;
		if(seq < maxPageNum){
			cout << "lack of page " << pagenum << "; "
				<< "no page in memory is replaced.\n";
			page[seq++] = pagenum;
			return;
		}
		cout << "lack of page " << pagenum << "; "
			<< "the page in memory that is replaced is page: " 
			<< page[0] << endl;
		for(int j = 0; j < maxPageNum-1; j++){
			page[j] = page[j+1];
		}
		page[maxPageNum-1] = pagenum;
		return;
	}
	void showpages()
	{
		cout << "stack : " ;
		for(int i = 0; i < seq; i++)
			cout << page[i] << " ";
		cout << endl;
	}
};

int main(){
	int pageNum;
	Stack *stack = new Stack();

	while(1){
		cout << "Input page num:";
		stack->access(pageNum);
		stack->showpages();
	}
	
	cout << lackNum << endl;
	return 0;
}
```

缺页率置换算法（C++）：
```
#include <iostream>
#include <cstdlib>
#include <cstring>

using namespace std;

int lack_of_page = 0;
int mem_pages = 3;

int t_start = 0,t_end = 0,t_now = 0;
int T = 2;

class List{
private:
	int seq;
	int page[100][2];
public:
	List(){
		seq = 0;
		memset(page , 0 , sizeof(page));
	}

	void access(int pagenum){
		t_now++;
		for(int i = 0; i < seq; i++){
			if(page[i][0] == pagenum){
				page[i][1] = 1;
				return;	
			}	
		}

		lack_of_page ++;

		t_end = t_now;
		//cout << t_end - t_start << endl;

		if (t_end - t_start > T){

			for (int i = 0 ; i < seq ; i++){
				if ( page[i][1] == 0 ){
					for (int j = i ; j < seq-1 ; j++){
						page[j][0] = page[j+1][0];
						page[j][1] = page[j+1][1];
					}
					seq--;
					i--;
				}

			}
			for (int i = 0 ; i < seq ; i++){
				page[i][1] = 0;
			}

			page[seq][0] = pagenum;
			page[seq][1] = 1;
			seq++;

		}

		else{
			for (int i = 0 ; i < seq ; i++){
				page[i][1] = 0;
			}
			page[seq][0] = pagenum;
			page[seq][1] = 1;
			seq++;
		}
		t_start = t_end;
		return;
	}

	void showpages()
	{
		cout << "the pages in memory are :\t" ;
		for(int i = 0; i < seq; i++)
			//cout <<"(" <<page[i][0]<<","<<page[i][1]<<")" << " ";
			cout <<page[i][0]<<" ";
		cout << endl;
	}
};

int main(){
	int page;
	List *list = new List();
	
	while(1){
		cout << "Input page num:";
		cin >> page;
		if (page == -1) break;
		list->access(page);
		list->showpages();
	}
	
	cout <<"lack num:"<< lack_of_page << endl;
	return 0;
}
```

工作集页置换算法（Python）:
```
# 每次输入一个访问页号
WIN_SIZE = 4
work_list = []
series = []
while 1:
	a = input("Access: ")
	series.append(a)
	if a in work_list:
		if(work_list[0] == a):
			work_list.append(a)
			del work_list[0]
		else:
			del work_list[0]
		print "Successed."
	else:
		if len(work_list)<WIN_SIZE:
			work_list.append(a)
		else:
			work_list.append(a)
			del work_list[0]
		print "Fault." 
	print work_list
```

## 扩展思考题
（1）了解LIRS页置换算法的设计思路，尝试用高级语言实现其基本思路。此算法是江松博士（导师：张晓东博士）设计完成的，非常不错！

参考信息：

 - [LIRS conf paper](http://www.ece.eng.wayne.edu/~sjiang/pubs/papers/jiang02_LIRS.pdf)
 - [LIRS journal paper](http://www.ece.eng.wayne.edu/~sjiang/pubs/papers/jiang05_LIRS.pdf)
 - [LIRS-replacement ppt1](http://dragonstar.ict.ac.cn/course_09/XD_Zhang/(6)-LIRS-replacement.pdf)
 - [LIRS-replacement ppt2](http://www.ece.eng.wayne.edu/~sjiang/Projects/LIRS/sig02.ppt)
