from myhdl import Signal, always_comb, Simulation,delay,instance,intbv,bin,traceSignals,toVerilog
from heapq import nsmallest

stuck = []

def full_adder(A,B,A1,B1,C_in,K1,K2,K3,K4,K5,K6,Sum_out,Sum1_out,C_out):
    """full adder circuit
    {A,B,C} --- inputs
    {Sum_out,C_out} -- outputs
    """
    @always_comb
    def logic():
        Sig1= A ^ B ^ K1
      #  Sig1 = not Sig1
        Sig2 = (Sig1 & C_in) ^ K2
        Sig2 = not Sig2
        Sig3 = (A & B) ^ K3
        Sig3 = not Sig3 
        Sum_out.next = Sig1 ^ C_in
        C = (Sig2 or Sig3)
        Sig4 = A1 ^ B1 ^ K4
       # Sig4 = not Sig4
        Sig5 = (Sig4 & C) ^ K5
        Sig5 = not Sig5
        Sig6 = (A1 & B1) ^ K6
       # Sig6 = not Sig6
        Sum1_out.next = Sig4 ^ C
        C_out.next = (Sig5 or Sig6)
    return logic

from random import randrange

def testBench_FA(flag=0):
    """The test bench mark to test the full adder hardware module"""
    A,B,A1,B1,C_in,K1,K2,K3,K4,K5,K6,Sum_out,Sum1_out,C_out = [Signal(bool(0)) for i in range(14)]
    FA_inst = full_adder(A,B,A1,B1,C_in,K1,K2,K3,K4,K5,K6,Sum_out,Sum1_out,C_out)
    
    @instance
    def simulate():
        ham = {}
        hamSum = 0
        bitC = 0
        bitW = 0
        for p in range(64):
            keyset = format(p,"06b")
            
            beforeS = []
            beforeS1 = []
            beforeC = []
            before = []
        #print('A  B  Cin  SumOut  Cout')
            for i in range(32):
                K1.next = 0
                K2.next = 0
                K3.next = 0
                K4.next = 0
                K5.next = 0
                K6.next = 0
                set = format(i,"05b")
                A.next = int(set[0])
                B.next = int(set[1])
                C_in.next = int(set[2])
                A1.next = int(set[3])
                B1.next = int(set[4]) 

                yield delay(10)
                #print ('{}  {}  {}    {}        {} BEFORE'.format(bin(A,1),bin(B,1),bin(C_in,1),bin(Sum_out,1),bin(C_out,1)))
                beforeS.append(int(bin(Sum_out)))
                beforeS1.append(int(bin(Sum1_out)))
                beforeC.append(int(bin(C_out)))

            before = beforeS + beforeS1 + beforeC
            print('Sum0:')
            print(beforeS)
            print('Sum1:')
            print(beforeS1)
            print('Carry:')
            print(beforeC)
            
            print(before)

            K1.next = int(keyset[0])
            K2.next = int(keyset[1])
            K3.next = int(keyset[2])
            K4.next = int(keyset[3])
            K5.next = int(keyset[4])
            K6.next = int(keyset[5])
            afterS = []
            afterS1 = []
            afterC = []
            after = []

            for i in range(32):
                set = format(i,"05b")
                A.next = int(set[0])
                B.next = int(set[1])
                C_in.next = int(set[2])
                A1.next = int(set[3])
                B1.next = int(set[4]) 
                yield delay(10)
                afterS.append(int(bin(Sum_out)))
                afterS1.append(int(bin(Sum1_out)))
                afterC.append(int(bin(C_out)))
            
            after = afterS + afterS1 + afterC
            print('After:')
            print(afterS)
            print(afterC)
            print(after)

            t = []

            for i in range(len(before)):
                bitC += 1
                if before[i] != after[i]:
                    bitW += 1
                    t.append(before[i])

            hamming = len(t)/len(before)
            for index, key in enumerate(keyset):
                print('Key{}: {}'.format(index,key))
            print('Hamming = {}'.format(hamming))
            ham[hamming] = p
            hamSum += hamming

        print('Hamming List:')
        print(ham)

        smallest = nsmallest(1, ham, key=lambda x: abs(x-0.5))
        key = format(ham[smallest[0]],"06b")
        print('Best Key Combination: {}'.format(key))
        print('Hamming Distance: {}'.format(smallest))
        print('Ave Hamming = {}'.format(hamSum/63))
        print('Correct {} / {}'.format(bitC,bitW))

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
    A,B,C_in,Sum_out,C_out = [Signal(bool(0)) for i in range(5)]
    toVerilog(full_adder,A,B,C_in,Sum_out,C_out)
stimulate()
