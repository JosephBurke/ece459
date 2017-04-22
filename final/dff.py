from myhdl import *

def dff(q, d, clk):

    @always(clk.posedge)
    def logic():
        q.next = d

    return logic

def convert ():

    q, d, clk = [Signal(bool(0)) for i in range(3)]
    toVHDL(dff, q, d, clk)

convert()
