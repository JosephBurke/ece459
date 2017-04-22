from myhdl import *

def bin2gray(B, G, width):

    """ Gray encoder.

    B -- input intbv signal, binary encoded
    G -- output intbv signal, gray encoded
    width -- bit width

    """

    @always_comb
    def logic():
        Bext = intbv(0)[width+1:]
        Bext[:] = B
        for i in range(width):
            G.next[i] = Bext[i+1] ^ Bext[i]

    return logic

def convert():
    width = 8
    
    B = Signal(intbv(0)[width:])
    G = Signal(intbv(0)[width:])
    
    toVHDL(bin2gray, B, G, width)

convert()
