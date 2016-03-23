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