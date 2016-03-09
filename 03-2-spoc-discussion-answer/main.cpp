#include <iostream>
#include <cstring>
#include <fstream>
using namespace std;
int mem[128][32];
void load(string inTxt){
	ifstream in(inTxt.c_str());
	int temp;
	for(int i = 0 ; i < 128 ; i++){
		for(int j = 0 ; j < 32 ; j++){
			in >> hex >> temp;
			mem[i][j] = temp;
		}
	}
}
int getContent1(int offset){
	int val = mem[0x11][offset];
	if (val >> 7 == 0){
		return -1;
	}
	return val&127;
}
int getContent2(int num , int offset){
	if (num == -1){
		return -1;
	}
	int val = mem[num][offset];
	if (val >> 7 == 0){
		return -1;
	}
	return val&127;
}
int getValue(int num,  int offset){
	if (num == -1){
		cout <<"fault"<<endl;
		return -1;
	}
	int val = mem[num][offset];
	cout <<"the val is " << "0x" <<hex<<val << endl;
	return val;
}
int main(){
	load("in.txt");
	int vd , hi, mi, lo; 
	while(true){
		cout << "please input:";
		cin>>hex>>vd;
		hi = vd >> 10;
		mi = (vd & 992) >> 5;
		lo = vd & 31;	
		getValue( getContent2( getContent1(hi) , mi), lo);
	}
	return 0;
}