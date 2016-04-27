import multiprocessing
import subprocess
import time
import copy
import os


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
                while(not (tries == 100 or success)):
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
    #proc = subprocess.Popen(['/home/TDDD48/planners/ipp/plan emergency.pddl uav_problem_u1_r0_l4_p7_c14_g7_con2.pddl test.out'])
    #proc = subprocess.check_call([planner[1], "emergency.pddl", test+".pddl", test+"."+planner[0]+".result"])
    proc = subprocess.Popen([planner[1],"emergency.pddl",test + ".pddl", test + "."+planner[0]+".result"])
    #try:
    #    outs, errs = proc.wait(timeout=65)
    #except:
    #    proc.kill()
    #    return "65>"
    return str("{0:.2f}".format(time.time()-start))






planners = getPlanners("planners.info")
testCases = generateTestCases("testCases.info")


f = open("timeTaken.result",'w')
for planner in planners:
    for test in testCases:
        tt = runTest(planner,test)
        f.write(planner[0] + ", " + test + "    " + tt + " seconds\n")



