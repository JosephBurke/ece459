from myhdl import Signal, always_comb, Simulation,delay,instance,intbv,bin,traceSignals,toVerilog

stuck = []

def full_adder(A,B,C_in,K,Sum_out,C_out):
    """full adder circuit
    {A,B,C} --- inputs
    {Sum_out,C_out} -- outputs
    """
    @always_comb
    def logic():
        Sig1= A ^ B ^ K
        Sig2 = Sig1 & C_in
        Sig3 = A & B
        Sum_out.next = Sig1 ^ C_in
        C_out.next = Sig2 or Sig3
    return logic

from random import randrange

def testBench_FA(flag=0):
    """The test bench mark to test the full adder hardware module"""
    A,B,C_in,K,Sum_out,C_out = [Signal(bool(0)) for i in range(6)]
    FA_inst = full_adder(A,B,C_in,K,Sum_out,C_out)
    
    @instance
    def simulate():
        beforeS = []
        beforeC = []
        before = []
        
        #print('A  B  Cin  SumOut  Cout')
        for i in range(8):
            set = format(i,"03b")
            A.next = int(set[0])
            B.next = int(set[1])
            C_in.next = int(set[2])
            K.next = 0
            yield delay(10)
            #print ('{}  {}  {}    {}        {} BEFORE'.format(bin(A,1),bin(B,1),bin(C_in,1),bin(Sum_out,1),bin(C_out,1)))
            beforeS.append(int(bin(Sum_out)))
            beforeC.append(int(bin(C_out)))

        before = beforeS + beforeC
        print('Before:')
        print(beforeS)
        print(beforeC)
        print(before)

        K.next = 1
        afterS = []
        afterC = []
        after = []

        for i in range(8):
            set = format(i,"03b")
            A.next = int(set[0])
            B.next = int(set[1])
            C_in.next = int(set[2])
            yield delay(10)
            #print ('{}  {}  {}    {}        {} BEFORE'.format(bin(A,1),bin(B,1),bin(C_in,1),bin(Sum_out,1),bin(C_out,1)))
            afterS.append(int(bin(Sum_out)))
            afterC.append(int(bin(C_out)))
        
        after = afterS + afterC
        print('After:')
        print(afterS)
        print(afterC)
        print(after)

        t = []

        for i in range(len(before)):
            if before[i] != after[i]:
                t.append(before[i])

        hamming = len(t)/len(before)
        print('Hamming = {}'.format(hamming))


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
