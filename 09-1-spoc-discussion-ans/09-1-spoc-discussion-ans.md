week13 2016-05-16(一)
21讲 文件系统
09-1-spoc-discussion.md

1. (spoc)完成Simple File System的功能，支持应用程序的一般文件操作。具体帮助和要求信息请看sfs-homework(https://github.com/chyyuu/ucore_os_lab/blob/master/related_info/lab8/sfs-homework.md)

	问题1：根据sfs文件系统的状态变化信息，给出具体的文件相关操作内容.

	[sfs_states.txt](https://github.com/HSYLCJ/OS_ExerciseAnwer/blob/master/09-1-spoc-discussion-ans/sfs_states.txt)

	问题2：在sfs-homework.py 参考代码的基础上，实现 writeFile, createFile, createLink, deleteFile，使得你的实现能够达到与问题1的正确结果一致

	[sfs-homework.py](https://github.com/HSYLCJ/OS_ExerciseAnwer/blob/master/09-1-spoc-discussion-ans/sfs-homework.py)

	问题3：实现soft link机制，并设计测试用例说明你实现的正确性。

	[soft.py](https://github.com/HSYLCJ/OS_ExerciseAnwer/blob/master/09-1-spoc-discussion-ans/soft.py)