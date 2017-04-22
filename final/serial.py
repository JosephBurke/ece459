from myhdl import Signal, delay, instance, always, Simulation, concat, always_comb, intbv, traceSignals


def clk_driver(clk, period=20):
    @always(delay(period/2))
    def drive_clk():
        clk.next = not clk
    return drive_clk


def shift_reg(inp, out, clk, parallel_load, parallel_en):
    @always(clk.posedge)
    def shift_right():
        if parallel_en == False:
            out.next = concat(inp,out[len(out):1])
        else:
            out.next = parallel_load
    return shift_right


def full_adder(a, b, cin, sum, cout, clk):
    @always_comb
    def add():
        sum.next = a ^ b ^ cin
        cout.next = (a and b) or (cin and (a ^ b))
    @always(clk.posedge)
    def carry():
        cin.next = cout
    return add, carry


def serial_adder(R, load_en, clk, add_carry):
    '''
    adds the two numbers given in R and stores the sum in
    the lower significant half of R
    :param R: Two numbers of equal bit vector length
    :param load_en: when equal to 1 it parallel loads the value in R to the two internal shift registers
    :param clk:
    :param add_carry: will contain the final carry bit after adding the msbs
    '''
    out1 = Signal(intbv(0)[len(R)/2:])
    parallelin1 = R[len(R):len(R)/2]
    out2 = Signal(intbv(0)[len(R)/2:])
    parallelin2 = R[len(R)/2:]
    sum, cin, cout, inp1, inp2, a, b = [Signal(intbv(0)) for i in range(7)]
    shift1 = shift_reg(inp1, out1, clk, parallelin1, load_en)    #contains first number
    shift2 = shift_reg(inp2,out2,clk,parallelin2, load_en)       #contains second number initially and final result at the end of simulation
    adder = full_adder(a, b, cin, sum, cout, clk)
    @always_comb
    def connect():
        inp1.next = intbv(out1[0])[1:]
        inp2.next = sum
        a.next = intbv(out1[0])[1:]
        b.next = intbv(out2[0])[1:]
        add_carry.next = cout
    return connect, shift1, shift2, adder


def test():
    clk, add_carry = [Signal(intbv(0)) for i in range(2)]
    load_en = Signal(bool(1))
    R = concat(Signal(intbv(35)[8:]), Signal(intbv(39)[8:]))
    clock = clk_driver(clk)
    @instance
    def tb():
        yield clk.negedge
        yield delay(1)
        load_en.next = not load_en
    ripple = serial_adder(R, load_en, clk, add_carry)
    return clock, tb, ripple

trace = traceSignals(test)
sim = Simulation(trace)
sim.run(180)
