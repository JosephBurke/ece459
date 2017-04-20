from myhdl import *
def bin2gray(B, G, width):
    """ Gray encoder.

    B -- input intbv signal, binary encoded
    G -- output intbv signal, gray encoded
    width -- bit width
    """

    @always_comb
    def logic():
        for i in range(width):
            G.next[i] = B[i+1] ^ B[i]

    return logic

def testBench(width):

    B = Signal(intbv(0))
    G = Signal(intbv(0))

    dut = bin2gray(B, G, width)
    
    @instance    
    def stimulus():
        for i in range(2**width):
            B.next = intbv(i)
            yield delay(10)
            print ('B: {} | G: {}'.format(bin(B, width),bin(G, width)))

    return dut, stimulus

sim = Simulation(testBench(width=3))
sim.run()
