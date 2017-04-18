from myhdl import Signal, always_comb, Simulation,delay,instance,intbv,bin,traceSignals,toVerilog

def full_adder(A,B,C_in,K,O,TEST,Sum_out,C_out):
    """full adder circuit
    {A,B,C} --- inputs
    {Sum_out,C_out} -- outputs
    """
    @always_comb
    def logic():
        Sig1= A ^ B
        #print('Sig1 = {}'.format(Sig1))
        #Sig1 = Sig1 & K
        #print('Sig1 = {}'.format(Sig1))
        #Sig1 = Sig1 or O
        Sig1 = Sig1 ^ TEST
        Sig2 = Sig1 & C_in
        Sig2 = Sig2 & K
        Sig2 = Sig2 or O
        Sig3 = A & B
        Sum_out.next = Sig1 ^ C_in
        C_out.next = Sig2 or Sig3
    return logic

from random import randrange

def testBench_FA(flag=0):
    """The test bench mark to test the full adder hardware module"""
    A,B,C_in,K,O,Sum_out,C_out,TEST = [Signal(bool(0)) for i in range(8)]
    FA_inst = full_adder(A,B,C_in,K,O,TEST,Sum_out,C_out)
    
    @instance
    def simulate():
        after = []
        beforeSum = []
        beforeCarry = []
        afterStuckZeroSum = []
        afterStuckZeroCarry = []
        afterStuckOneSum = []
        afterStuckOneCarry = []

        keygateSum = []
        keygateCarry = []
        print('A  B  Cin  SumOut  Cout')
        K.next=1
        for i in range(8):
            set = format(i,"03b")
            A.next = int(set[0])
            B.next = int(set[1])
            C_in.next = int(set[2])
            yield delay(10)
            #print ('{}  {}  {}    {}        {} BEFORE'.format(bin(A,1),bin(B,1),bin(C_in,1),bin(Sum_out,1),bin(C_out,1)))
            beforeSum.append(int(bin(Sum_out)))
            beforeCarry.append(int(bin(C_out)))
        TEST.next = 1
        for i in range(8):
            set = format(i,"03b")
            A.next = int(set[0])
            B.next = int(set[1])
            C_in.next = int(set[2])
            yield delay(10)
            #print ('{}  {}  {}    {}        {} BEFORE'.format(bin(A,1),bin(B,1),bin(C_in,1),bin(Sum_out,1),bin(C_out,1)))
            keygateSum.append(int(bin(Sum_out)))
            keygateCarry.append(int(bin(C_out)))

        print('A  B  Cin  SumOut  Cout')
        K.next=0
        for i in range(8):
            set = format(i,"03b")
            A.next = int(set[0])
            B.next = int(set[1])
            C_in.next = int(set[2])
            yield delay(10)
            #print ('{}  {}  {}    {}        {} AFTER'.format(bin(A,1),bin(B,1),bin(C_in,1),bin(Sum_out,1),bin(C_out,1)))
            afterStuckZeroSum.append(int(bin(Sum_out)))
            afterStuckZeroCarry.append(int(bin(C_out)))

        O.next = 1
        for i in range(8):
            set = format(i,"03b")
            A.next = int(set[0])
            B.next = int(set[1])
            C_in.next = int(set[2])
            yield delay(10)
            #print ('{}  {}  {}    {}        {} AFTER'.format(bin(A,1),bin(B,1),bin(C_in,1),bin(Sum_out,1),bin(C_out,1)))
            afterStuckOneSum.append(int(bin(Sum_out)))
            afterStuckOneCarry.append(int(bin(C_out)))

        print('Before SUM/Carry')
        print(beforeSum)
        print(beforeCarry)

        #print('After Stuck at 0')
        #print(afterStuckZeroSum)
        #print(afterStuckZeroCarry)

        #print('After Stuck at 1')
        #print(afterStuckOneSum)
        #print(afterStuckOneCarry)


        result=[]
        result2=[]
        for i in range(len(beforeSum)):
            if beforeSum[i] != afterStuckOneSum[i]:
                result.append(beforeSum[i])
            if beforeCarry[i] != afterStuckOneCarry[i]:
                result.append(beforeCarry[i])
            if beforeSum[i] != afterStuckZeroSum[i]:
                result2.append(beforeSum[i])
            if beforeCarry[i] != afterStuckZeroCarry[i]:
                result2.append(beforeCarry[i])
        #print('Result1')
        #print(result)
        #print('Result2')
        #print(result2)

        #Hamming = (len(result)/len(beforeSum) + len(result2)/len(beforeSum))/2
        #print('Testability = {}'.format(Hamming))

        print('After key insertion')
        print(keygateSum)
        print(keygateCarry)
        t = []
        for i in range(len(beforeSum)):
            if beforeSum[i] != keygateSum[i]:
                t.append(beforeSum[i])
            if beforeCarry[i] != keygateCarry[i]:
                t.append(beforeCarry[i])

        print('t:')
        print(t)

        
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
