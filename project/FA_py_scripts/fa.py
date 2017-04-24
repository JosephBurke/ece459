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

def convert():
    A,B,C_in,Sum_out,C_out = [Signal(bool(0)) for i in range(5)]
    toVHDL(full_adder,A,B,C_in,Sum_out,C_out)
convert()
