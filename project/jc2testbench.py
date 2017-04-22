from myhdl import *

ACTIVE, INACTIVE = bool(0), bool(1)

from jc2 import jc2

def test(jc2):

    goLeft, goRight, stop, clk = [Signal(INACTIVE) for i in range(4)]
    q = Signal(intbv(0)[4:])

    @always(delay(10))
    def clkgen():
        clk.next = not clk

    jc2_inst = jc2(goLeft, goRight, stop, clk, q)

    @instance
    def stimulus():
        for i in range(3):
            yield clk.negedge
        for sig, nrcycles in ((goLeft, 10), (stop, 3), (goRight, 10)):
            sig.next = ACTIVE
            yield clk.negedge
            sig.next = INACTIVE
            for i in range(nrcycles-1):
                yield clk.negedge
        raise StopSimulation

    @instance
    def monitor():
        print ("goLeft goRight stop clk q")
        print ("-------------------------")
        while True:
            yield clk.negedge
            yield delay(1)
            print ('{} {} {}'.format(goLeft, goRight, stop)),
            yield clk.posedge
            print ('C'),
            yield delay(1)
            print (bin(q, 4))

    return clkgen, jc2_inst, stimulus, monitor

sim = Simulation(test(jc2))
sim.run()
