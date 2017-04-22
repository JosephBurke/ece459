ENTITY 8_bit IS
  
port(
	clk, reset, ctrl	: IN std_logic;
	din : IN std_logic_vector(7 DOWNTO 0);
	q : OUT std_logic_vector(7 DOWNTO 0)
	);
end 8_bit;

ARCHITECTURE 8_bit_lfsr  OF 8_bit IS

 SIGNAL   q     : std_logic_vector(7 DOWNTO  0);
 SIGNAL   reset : std_logic;
 CONSTANT din  : std_logic_vector(7 DOWNTO  0):= (OTHERS  => '1');

BEGIN

 lfsr : PROCESS(clk,ctrl,reset)

 BEGIN

  IF(reset='0') THEN 
   q <= '00000000';
  ELSIF(ctrl='1') THEN
    q <= din;                          
  ELSIF (clk'EVENT AND  clk='1') THEN 

   q(0) <= q(7);                      
   q(1) <= q(0);                                
   q(2) <= q(1) XOR q(7);             
   q(3) <= q(2) XOR q(7);             
   q(4) <= q(3) XOR q(7);
   q(7 DOWNTO 5)<= q(6 DOWNTO 4);     

  END IF;
  
 END PROCESS lfsr;

END ARCHITECTURE 8_bit_lfsr;
