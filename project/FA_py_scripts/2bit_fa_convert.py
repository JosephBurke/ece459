from myhdl import Signal, always_comb, Simulation,delay,instance,intbv,bin,traceSignals,toVerilog
from heapq import nsmallest
from myhdl import *

stuck = []

def full_adder(A,B,C_in,KeyOne,KeyTwo,KeyThree,Sum_out,C_out):
    """full adder circuit
    {A,B,C} --- inputs
    {Sum_out,C_out} -- outputs
    """
    @always_comb
    def logic():
        Sum_out.next = (A ^ B ^ KeyOne) ^ C_in
        C_out.next = (((A ^ B ^ C_in) & C_in) ^ KeyTwo) | ((A & B) ^ KeyThree)
    return logic

def convert():
     A,B,C_in,KeyOne,KeyTwo,KeyThree,Sum_out,C_out = [Signal(bool(0)) for i in range(8)]
     toVHDL(full_adder,A,B,C_in,KeyOne,KeyTwo,KeyThree,Sum_out,C_out)
convert()
