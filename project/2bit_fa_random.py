from myhdl import Signal, always_comb, Simulation,delay,instance,intbv,bin,traceSignals,toVerilog
from heapq import nsmallest
from myhdl import *
import sys

stuck = []

def full_adder(A,B,C_in,K1,K2,K3,Sum_out,C_out):
    """full adder circuit
    {A,B,C} --- inputs
    {Sum_out,C_out} -- outputs
    """
    @always_comb
    def logic():
        Sig1=  (A ^ B ^ K1)
        Sig2 = ((Sig1 & C_in) ^ K2)
        Sig3 = (A & B) ^ K3 
        Sum_out.next = Sig1 ^ C_in
        C_out.next = Sig2 | Sig3
    return logic

from random import randrange

def testBench_FA(flag=0):
    A,B,C_in,K1,K2,K3,Sum_out,C_out = [Signal(bool(0)) for i in range(8)]
    FA_inst = full_adder(A,B,C_in,K1,K2,K3,Sum_out,C_out)
    
    @instance
    def simulate():
        ham = {}
        hamSum = 0
        bitC = 0
        bitW = 0
        iteration = int(sys.argv[1])
        for t in range(iteration):
            p = randrange(8)
            keyset = format(p,"03b")
            #print('Key1: {} Key2: {} Key3: {}'.format(keyset[0],keyset[1],keyset[2]))
            #print('{}{}{}'.format(keyset[0],keyset[1],keyset[2]))
            beforeS = []
            beforeC = []
            before = []
            
            #print("A B C | S C | S' C' ")
            #print('-------------------------------------------')

            for i in range(8):
                K1.next = 0
                K2.next = 0
                K3.next = 0
                set = format(i,"03b")
                A.next = int(set[0])
                B.next = int(set[1])
                C_in.next = int(set[2])
                yield delay(10)
                beforeS.append(int(bin(Sum_out)))
                beforeC.append(int(bin(C_out)))

            before = beforeS + beforeC

            K1.next = int(keyset[0])
            K2.next = int(keyset[1])
            K3.next = int(keyset[2])
            afterS = []
            afterC = []
            after = []

            for i in range(8):
                set = format(i,"03b")
                A.next = int(set[0])
                B.next = int(set[1])
                C_in.next = int(set[2])
                yield delay(10)
                afterS.append(int(bin(Sum_out)))
                afterC.append(int(bin(C_out)))

            for i in range(8):
                temp = format(i,"03b")
                #print('{} {} {} | {} {} | {} {}'.format(int(temp[0]),int(temp[1]),int(temp[2]),beforeS[i],beforeC[i],afterS[i],afterC[i]))
            
            after = afterS + afterC

            t = []

            for i in range(len(before)):
                bitC += 1
                if before[i] != after[i]:
                    bitW += 1
                    t.append(before[i])

            hamming = len(t)/len(before)
            print('Key1: {} Key2: {} Key3: {}'.format(keyset[0],keyset[1],keyset[2]))
            print('Hamming = {}'.format(hamming))
            #print('{}'.format(hamming))
            ham[hamming] = p
            hamSum += hamming

            print()

        print('Hamming List:')
        print(ham)

        smallest = nsmallest(1, ham, key=lambda x: abs(x-0.5))
        key = format(ham[smallest[0]],"03b")
        print('Best Key Combination: {}'.format(key))
        print('Hamming Distance: {}'.format(smallest))
        print('Hamming Average = {}'.format(hamSum/iteration))

    return FA_inst,simulate

def stimulate_VCD():
    tb = traceSignals(testBench_FA)
    sim = Simulation(tb)
    sim.run()

def stimulate():
    inst = testBench_FA(flag=1)
    sim = Simulation(inst)
    sim.run()

def convert():
     A,B,C_in,K1,K2,K3,Sum_out,C_out = [Signal(bool(0)) for i in range(8)]
     toVHDL(full_adder,A,B,C_in,K1,K2,K3,Sum_out,C_out)
stimulate()
convert()
