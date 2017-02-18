----------------------------------------------------------------------------------
-- Students: Joe Burke, Idan Kanter, Seth Rausch
-- Create Date: 2/15/2017
-- Design Name: 8-bit LFSR
-- Project Name: Lab 2 - Linear Feedback Shift Registers (LFSR)
-- Target Devices: Nexys4
-- Description: Task 2 - Implement an 8-bit LFSR
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity eight_bit is
  
    port (
	   clk, reset, ctrl    :	IN std_logic;
	   din				   :	IN std_logic_vector(7 DOWNTO 0);
	   q				   :	INOUT std_logic_vector(7 DOWNTO 0)
	);
end eight_bit;

ARCHITECTURE Behavioral  OF eight_bit IS

 --SIGNAL		q_signal   : std_logic_vector(7 DOWNTO 0);
 --SIGNAL		reset	   : std_logic;
 --CONSTANT	din  	: std_logic_vector(7 DOWNTO 0):= (OTHERS  => '1');
 variable SEL :   std_logic := 0;

BEGIN

 lfsr	:	PROCESS(clk,ctrl,reset)

 BEGIN

    IF(reset = '0') THEN 
        q <= "00000000";
    ELSIF(ctrl = '1') THEN
        q <= din;                          
    ELSIF (clk'EVENT AND clk = '1') THEN 
        IF (SEL = '0')
            q(0) <= '1';
            SEL := '1';
        ELSE
            q(0) <= q(7);                      
            q(1) <= q(0);                                
            q(2) <= q(1) XOR q(7);             
            q(3) <= q(2) XOR q(7);             
            q(4) <= q(3) XOR q(7);
            q(7 DOWNTO 5) <= q(6 DOWNTO 4);
        END IF;
    
    END IF;
    
    END PROCESS lfsr;
    
    END Behavioral;
