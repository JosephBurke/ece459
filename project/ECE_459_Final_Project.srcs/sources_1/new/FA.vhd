----------------------------------------------------------------------------------
-- Students: Joe Burke, Idan Kanter, Seth Rausch
-- Create Date: 4/02/2017
-- Design Name: Full Adder
-- Project Name: ECE 459 Final Project - Logic Obfuscation
-- Target Devices: Nexys4
-- Description: First circuit is a Full Adder.
--             * Implementing a fault analysis technique to understand where to insert key gates.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FA is
    Port (
        clk     : IN std_logic;
        A       : IN std_logic;
        B       : IN std_logic;
        Cin     : IN std_logic;
        
        S       : OUT std_logic;
        Cout    : OUT std_logic
    );
end FA;

architecture Behavioral of FA is

    signal XOR1, XOR2, AND1, AND2, OR1  : std_logic;

begin

    XOR1 <= A XOR B;
    AND1 <= A AND B;
    XOR2 <= XOR1 XOR Cin;
    AND2 <= Cin AND XOR1;
    OR1  <= AND1 OR AND2;
    
    S    <= XOR2;
    Cout <= OR1; 


end Behavioral;
