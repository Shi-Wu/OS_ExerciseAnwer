#include <iostream>
#include <cstring>
#include <fstream>
using namespace std;
int mem[128][32];
int disk[128][32];

int inD = 0;

void loadMem(string inTxt){
	ifstream in(inTxt.c_str());
	int temp;
	for(int i = 0 ; i < 128 ; i++){
		for(int j = 0 ; j < 32 ; j++){
			in >> hex >> temp;
			mem[i][j] = temp;
		}
	}
	in.close();
}

void loadDisk(string inTxt){
	ifstream in(inTxt.c_str());
	int temp;
	for(int i = 0 ; i < 128 ; i++){
		for(int j = 0 ; j < 32 ; j++){
			in >> hex >> temp;
			disk[i][j] = temp;
		}
	}
	in.close();
}
int getContent1(int offset){
	int val = mem[0x6c][offset];
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
		if (val == 0x7f){
			return -1;
		}
		else{
			inD = 1;
			return val&127;
		}
	}
	inD = 0;
	return val&127;
}
int getValue(int num,  int offset){
	if (num == -1){
		cout <<"fault"<<endl;
		return -1;
	}
	int val;
	if (inD){
		val = disk[num][offset];
	}
	else{
		val = mem[num][offset];
	}
	cout <<"the val is " << "0x" <<hex<<val << endl;
	return val;
}
int main(){
	loadMem("mem.txt");
	loadDisk("disk.txt");
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