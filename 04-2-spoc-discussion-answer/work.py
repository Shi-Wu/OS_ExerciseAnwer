
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
	