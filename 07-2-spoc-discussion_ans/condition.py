import threading  
import time

condition12 = threading.Condition()
prog1 = 0
prog2 = 0
prog3 = 0
prog4 = 0
prog5 = 0
prog6 = 0
prog7 = 0
prog8 = 0
count = 0

class Prog1(threading.Thread):  
    def __init__(self):  
        threading.Thread.__init__(self)  

    def run(self):  
        global prog1  
        print "Program1_finish\n"
        prog1=1

class Prog2(threading.Thread):  
    def __init__(self):  
        threading.Thread.__init__(self)  

    def run(self):  
        global prog2  
        print "Program2_finish\n"
        prog2=1

class Prog3(threading.Thread):  
    def __init__(self):  
        threading.Thread.__init__(self)  

    def run(self):  
        global condition12,prog1,prog2,prog3
        while True:
            if condition12.acquire():
                if prog1&prog2 > 0:
                    print "Program3_finish\n"
                    prog3=1
                    condition12.notify()
                    condition12.release()
                    break
                else:
                    print "Program 3 Waiting for Program1&2\n"
                    condition12.wait();
                    condition12.release()
                time.sleep(1)

class Prog4(threading.Thread):  
    def __init__(self):  
        threading.Thread.__init__(self)  

    def run(self):  
        global condition12,prog1,prog2,prog4  
        while True:
            if condition12.acquire():
                if prog1&prog2 > 0:
                    print "Program4_finish\n"
                    prog4=1
                    condition12.notify()
                    condition12.release()
                    break
                else:
                    print "Program 4 Waiting for Program1&2\n"
                    condition12.wait()
                    condition12.release()
                time.sleep(1)

class Prog5(threading.Thread):  
    def __init__(self):  
        threading.Thread.__init__(self)  

    def run(self):  
        global condition12,prog1,prog2,prog5
        while True:
            if condition12.acquire():
                if prog1&prog2 > 0:
                    print "Program5_finish\n"
                    prog5=1
                    condition12.notify()
                    condition12.release()
                    break
                else:
                    print "Program 5 Waiting for Program1&2\n"
                    condition12.wait()
                    condition12.release()
                time.sleep(1)
               
class Prog6(threading.Thread):  
    def __init__(self):  
        threading.Thread.__init__(self)  

    def run(self):  
        global prog3,prog6 
        while True:
            if  prog3  > 0:
                print "Program6_finish\n"
                prog6=1
                break;
            else:
                print "Program 6 Waiting for Program3\n"
            time.sleep(1)

class Prog7(threading.Thread):  
    def __init__(self):  
        threading.Thread.__init__(self)  

    def run(self):  
        global prog5,prog7 
        while True:
            if  prog5  > 0:
                print "Program7_finish\n"
                prog7=1
                break;
            else:
                print "Program 7 Waiting for Program5\n"
            time.sleep(1)
                

class Prog8(threading.Thread):  
    def __init__(self):  
        threading.Thread.__init__(self)  

    def run(self):  
       global prog4,prog6,prog7,prog8
       while True:
            if  prog4&prog6&prog7  > 0:
                print "Program8_finish\n"
                prog8=1
                break;
            else:
                print "Program 8 Waiting for Program4&6&7\n"
            time.sleep(1)
                    
class Prog9(threading.Thread):  
    def __init__(self):  
        threading.Thread.__init__(self)  

    def run(self):  
        global count,prog1,prog2,prog3,prog4,prog5,prog6,prog7,prog8 
        while True:
            print "count:"+str(count)+" "+str(prog1)+" "+str(prog2)+" "+str(prog3)+" "+str(prog4)+" "+str(prog5)+" "+str(prog6)+" "+str(prog7)+" "+str(prog8)
            count=count+1
            time.sleep(2)

if __name__ == "__main__":  

    pprog4=Prog4()
    pprog4.start()

    pprog6=Prog6()
    pprog6.start()
    
    pprog1=Prog1()
    pprog1.start()

    pprog8=Prog8()
    pprog8.start()
    
    pprog2=Prog2()
    pprog2.start()

    pprog7=Prog7()
    pprog7.start()
    
    pprog3=Prog3()
    pprog3.start()

    pprog5=Prog5()
    pprog5.start()

    #pprog9=Prog9()
    #pprog9.start()