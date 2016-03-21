#lec9 虚存置换算法spoc练习

## 小组思考题目


----

(1)（spoc）请证明为何LRU算法不会出现belady现象

证明：
        原理:因为小的物理页帧的栈包含于大数目的物理页帧的栈
        证明根据课堂老师给出的基础：
            来证明s(t) 始终包含于 s'(t)
            利用归纳法，假设 1<=i<=t-1 时 s(i)包含于s'(i)，现在要证s(t)依然包含于s'(t)
            (1) b(t)同时属于s(t)和s'(t)：此时s(t)和s'(t)都不发生变化，满足包含关系；
            (2) b(t)不属于s(t),属于s'(t)：s(t) 替换后，由于b(t)∈s(t)，所以s(t)包含于s'(t)
            (3)  (1)和(2)很容易证明，
                对于b(t)同时不属于s(t-1)和s'(t-1)的情况，我们依然按照视频里栈的方式对s(t-1)和s'(t-1)排序
                由于s(t-1)包含于s'(t-1),所以s(t-1)内每一个元素都存在于s'(t-1)中。
                现在两个栈都是按最后一次访问的时间的顺序来排列的，由于s(t)在进行替换时会替换s(t-1)里面最长时间没被访问的元素(栈底)，设为a,那么a显然也存在于s'(t-1)里面，并且它不一定是s'(t-1)的栈底。
                    A. 当a是s'(t-1)的栈底时，s(t)和s'(t)替换的都是a, s(t) = s(t-1) - {a} + {b(t)} , s'(t) = s'(t-1) - {a} + {b(t)}
                    B. 当a不是s'(t-1)的栈底是，则s'(t-1)的栈底c必然不属于s(t-1)，否则就会与a是s(t-1)的栈底矛盾（即c比a有更长的时间未被访问），此种情况下s(t)和s'(t)依然满足包含关系
            (4) 由归纳假设可以得知此种情况不存在


(2)（spoc）根据你的`学号 mod 4`的结果值，确定选择四种页面置换算法（0：LRU置换算法，1:改进的clock 页置换算法，2：工作集页置换算法，3：缺页率置换算法）中的一种来设计一个应用程序（可基于python, ruby, C, C++，LISP等）模拟实现，并给出测试。请参考如python代码或独自实现。
 - [页置换算法实现的参考实例](https://github.com/chyyuu/ucore_lab/blob/master/related_info/lab3/page-replacement-policy.py)
 
学号：2013011304
算法：（2013011304 mod 4 = 0）LRU算法
代码：（C++）
```
#include <cstdlib>
#include <iostream>
#include <cstring>

using namespace std;

int lack_of_page = 0;
int mem_pages = 3;
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
		lack_of_page ++;
		if(seq < mem_pages){
			cout << "lack of page " << pagenum << "; "
				<< "no page in memory is replaced.\n";
			page[seq++] = pagenum;
			return;
		}
		cout << "lack of page " << pagenum << "; "
			<< "the page in memory that is replaced is page: " 
			<< page[0] << endl;
		for(int j = 0; j < mem_pages-1; j++){
			page[j] = page[j+1];
		}
		page[mem_pages-1] = pagenum;
		return;
	}
	void showpages()
	{
		cout << "the pages in memory are :\t" ;
		for(int i = 0; i < seq; i++)
			cout << page[i] << " ";
		cout << endl;
	}
};

int main(){

	int page;
	Stack *stack = new Stack();
	while(cin >> page){
		stack->access(page);
		stack->showpages();
	}
	
	cout << lack_of_page << endl;
	return 0;
}
```

## 扩展思考题
（1）了解LIRS页置换算法的设计思路，尝试用高级语言实现其基本思路。此算法是江松博士（导师：张晓东博士）设计完成的，非常不错！

参考信息：

 - [LIRS conf paper](http://www.ece.eng.wayne.edu/~sjiang/pubs/papers/jiang02_LIRS.pdf)
 - [LIRS journal paper](http://www.ece.eng.wayne.edu/~sjiang/pubs/papers/jiang05_LIRS.pdf)
 - [LIRS-replacement ppt1](http://dragonstar.ict.ac.cn/course_09/XD_Zhang/(6)-LIRS-replacement.pdf)
 - [LIRS-replacement ppt2](http://www.ece.eng.wayne.edu/~sjiang/Projects/LIRS/sig02.ppt)
