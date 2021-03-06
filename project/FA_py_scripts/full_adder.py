from myhdl import *

def full_adder(A,B,C_in,Sum_out,C_out):
    """full adder circuit
    {A,B,C} --- inputs
    {Sum_out,C_out} -- outputs
    """
    @always_comb
    def logic():
        Sum_out.next = A ^ B ^ C_in
        C_out.next = (A & B) ^ (C_in & (A ^ B))
    return logic

from random import randrange

def testBench_FA(flag=0):
    """The test bench mark to test the full adder hardware module"""
    A,B,C_in,Sum_out,C_out = [Signal(bool(0)) for i in range(5)]
    FA_inst = full_adder(A,B,C_in,Sum_out,C_out)
    @instance
    
    def simulate():
        for i in range(10):
            A.next,B.next,C_in.next = [randrange(2) for i in range(3)]
            yield delay(10)
            if flag == 1:
                print("A: {} B: {} C_in: {} Sum_out: {} C_out{}".format(bin(A,1),bin(B,1),bin(C_in,1),bin(Sum_out,1),bin(C_out,1))) 
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
    toVHDL(full_adder,A,B,C_in,Sum_out,C_out)
stimulate_VCD()
convert()
