#include <iostream>
#include <cstdlib>
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