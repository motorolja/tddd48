#!/usr/bin/python
import multiprocessing
import subprocess
import time
import copy
import os
import signal
import sys

resultFile = "time.result"
plannersFile = "planners.info"
testCasesFile = "testCases.info"
multithreaded = False
build = False
run = False
i = 1;
def loadName(i):
    if(sys.argv[i][0] == '-'):
        print("an argument cannot begin with '-'")
        exit(0)
    return sys.argv[i]
while i < len(sys.argv):
    if(sys.argv[i] == "--out"):
        resultFile = loadName(i+1)
        i = i+2
    elif(sys.argv[i] == "--planners"):
        plannersFile = loadName(i+1)
        i = i+2
    elif(sys.argv[i] == "--testcases"):
        testCasesFile = loadName(i+1)
        i = i+2
    elif(sys.argv[i] == "--build"):
        build = True
        i = i+1
    elif(sys.argv[i] == "--run"):
        run = True
        i = i+1
    elif(sys.argv[i] == "--multithreaded"):
        multithreaded = True
        i = i+1
    else:
        print("invalid argument: " + sys.argv[i])
        exit(0)


def generateTestCase(command):
    os.system(command + " >/dev/null")

def getPlanners(fileName):
    f = open(fileName, 'r')
    planners = []
    for line in f:
        line = line.split()
        if (len(line) > 0 and not (line[0][0] == "#")):
            planners.append(line)
    f.close()
    return planners

def generateTestCases(fileName):
    testCases = []
    f = open(fileName, 'r')
    for line in f:
        line = line.split()
        if (len(line) > 0 and not (line[0][0] == "#")):
            if(len(line) == 6):
                name = copy.deepcopy(line)
                name[0] = "u"+name[0]
                name[1] = "r"+name[1]
                name[2] = "l"+name[2]
                name[3] = "p"+name[3]
                name[4] = "c"+name[4]
                name[5] = "g"+name[5]
                resultFile = "uav_problem_" + "_".join(name) + "_con2"
                line[0] = "-u " + line[0]
                line[1] = "-r " + line[1]
                line[2] = "-l " + line[2]
                line[3] = "-p " + line[3]
                line[4] = "-c " + line[4]
                line[5] = "-g " + line[5]
                tries = 0
                success = False
                while(not (tries == 1 or success)):
                    p = multiprocessing.Process(target=generateTestCase, name="testCase", args=("python generate.py " + " ".join(line),))
                    tries = tries + 1
                    p.start()
                    p.join(0.4)
                    success = os.path.isfile(resultFile + ".pddl")
                    if p.is_alive():
                        p.terminate()
                        p.join()
                if success:
                    testCases.append(resultFile)
                else:
                    print("testcase " + resultFile + " failed")
    return testCases



def runTest(planner, test):
    start = time.time()
    print(planner[1] + " emergency.pddl " + test + ".pddl " + test + "." + planner[0] + ".result")
    proc = subprocess.Popen([planner[1],"emergency.pddl",test + ".pddl", test + "."+planner[0]+".result"],preexec_fn=os.setsid)
    while(proc.poll() == None and time.time()-start < 65.0):
        time.sleep(0.01)

    if(proc.poll() == None):
        os.killpg(os.getpgid(proc.pid), signal.SIGTERM)
        return "65+"
    return str("{0:.2f}".format(time.time()-start))




def runPlannerTests(planner, tests, filename):
    filename = filename+"_"+planner[0]
    f = open(filename, 'w')

    for test in tests:
        tt = runTest(planner,test)
        f.write(test + "     " + tt + " seconds\n")
        f.close()
        f = open(filename,'a')
    f.close()


def runProgram():
    planners = getPlanners(plannersFile)
    testCases = generateTestCases(testCasesFile)

    if(multithreaded):
        processes = []
        for planner in planners:
            p = multiprocessing.Process(target=runPlannerTests, name=planner[0], args=(planner,testCases, resultFile,))
            p.start()
            processes.append(p)

        for process in processes:
            process.join()
    else:
        for planner in planners:
            runPlannerTests(planner, testCases, resultFile)





if("--multithreaded" in sys.argv):
    multithreaded = True
if(build):
    generateTestCases("testCases.info")
elif(run):
    runProgram()
else:
    print("need to specify argument:")
    print("   --build - only build the testcases")
    print("   --run   - build tests and run program")
    print("Optional parameters:")
    print("   --planners <file> - specify which file to read the planners from")
    print("   --testcases <file> - specify which file to read the testcases from")
    print("   --multithreaded - run one thread for each different planner")
