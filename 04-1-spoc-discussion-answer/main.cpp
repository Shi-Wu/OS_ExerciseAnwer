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
	cout << "    -->pde index:0x"<< hex <<offset ; 
	int val = mem[0x6c][offset];
	cout << " pde content:( valide  "<< (val>>7) <<" , " 
	<< "pfn 0x" << hex << (val&127) << " )" << endl;
	if (val >> 7 == 0){
		return -1;
	}
	return val&127;
}
int getContent2(int num , int offset){
	if (num == -1){
		cout << "        --> Fault (page directory entry not valid)" << endl;
		return -2;
	}
	cout << "            -->pte index:0x"<< hex <<offset ; 
	int val = mem[num][offset];
	cout << " pte content:( valide  "<< (val>>7) <<" , " 
	<< "pfn 0x" << hex << (val&127) << " )" << endl;
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
	if (num == -2) return 0;
	if (num == -1){
		cout <<"        -->fault"<<endl;
		return -1;
	}
	int val;
	if (inD){
		val = disk[num][offset];
		cout <<"            -->the val in Disk is " << "0x" <<hex<<val << endl;
	}
	else{
		val = mem[num][offset];
		cout <<"             -->the val in Mem is " << "0x" <<hex<<val << endl;
	}
	
	return val;
}
int main(){
	loadMem("mem.txt");
	loadDisk("disk.txt");
	int vd , hi, mi, lo; 
	while(true){
		cout << "please input virtual address:";
		cin>>hex>>vd;
		cout << "virtual address "<<hex << vd << endl;
		hi = vd >> 10;
		mi = (vd & 992) >> 5;
		lo = vd & 31;	
		getValue( getContent2( getContent1(hi) , mi), lo);
	}
	return 0;
}