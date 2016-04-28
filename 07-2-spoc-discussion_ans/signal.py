import threading  
import time

tS13=threading.Semaphore(1)
tS14=threading.Semaphore(1)
tS15=threading.Semaphore(1)
tS23=threading.Semaphore(1)
tS24=threading.Semaphore(1)
tS25=threading.Semaphore(1)
tS36=threading.Semaphore(1)
tS57=threading.Semaphore(1)
tS68=threading.Semaphore(1)
tS48=threading.Semaphore(1)
tS78=threading.Semaphore(1)

class Prog1Thread(threading.Thread):  
    
    def __init__(self):  
        threading.Thread.__init__(self)

    def run(self): 
        global tS13,tS14,tS15
        print "Program1_finish\n"
        tS13.release()
        tS14.release()
        tS15.release()

class Prog2Thread(threading.Thread):  
    
    def __init__(self):  
        threading.Thread.__init__(self) 
       
    def run(self):
        global tS23,tS24,tS25
        print "Program2_finish\n"
        tS23.release()
        tS24.release()
        tS25.release()

class Prog3Thread(threading.Thread):  
    
    def __init__(self):  
        threading.Thread.__init__(self) 
       
    def run(self):
        global tS13,tS23,tS36
        tS13.acquire()
        tS23.acquire()
        print "Program3_finish\n"
        tS13.release()
        tS23.release()
        tS36.release()

class Prog4Thread(threading.Thread):  
    
    def __init__(self):  
        threading.Thread.__init__(self) 
       
    def run(self):
        global tS14,tS24,tS48
        tS14.acquire()
        tS24.acquire()
        print "Program4_finish\n"
        tS14.release()
        tS24.release()
        tS48.release()

class Prog5Thread(threading.Thread):  
    
    def __init__(self):  
        threading.Thread.__init__(self) 
       
    def run(self):
        global tS15,tS25,tS57
        tS15.acquire()
        tS25.acquire()
        print "Program5_finish\n"
        tS15.release()
        tS25.release()
        tS57.release()

class Prog6Thread(threading.Thread):  
    
    def __init__(self):  
        threading.Thread.__init__(self) 
       
    def run(self):
        global tS36,tS68
        tS36.acquire()
        print "Program6_finish\n"
        tS36.release()
        tS68.release()

class Prog7Thread(threading.Thread):  
    
    def __init__(self):  
        threading.Thread.__init__(self) 
       
    def run(self):
        global tS57,tS78
        tS57.acquire()
        print "Program7_finish\n"
        tS57.release()
        tS78.release()

class Prog8Thread(threading.Thread):  
    
    def __init__(self):  
        threading.Thread.__init__(self) 
       
    def run(self):
        global tS48,tS68,tS78
        tS48.acquire()
        tS68.acquire()
        tS78.acquire()
        print "Program8_finish\n"
        tS48.release()
        tS68.release()
        tS78.release()

tS13.acquire()
tS14.acquire()
tS15.acquire()
tS23.acquire()
tS24.acquire()
tS25.acquire()
tS36.acquire()
tS57.acquire()
tS48.acquire()
tS68.acquire()
tS78.acquire()

pt3=Prog3Thread()
pt3.start()

pt1=Prog1Thread()
pt1.start()

pt2=Prog2Thread()
pt2.start()

pt4=Prog4Thread()
pt4.start()

pt8=Prog8Thread()
pt8.start()

pt5=Prog5Thread()
pt5.start()

pt7=Prog7Thread()
pt7.start()

pt6=Prog6Thread()
pt6.start()