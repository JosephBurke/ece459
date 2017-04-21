--------------------------------------------------------------------------------------------------
-- Students: Joe Burke, Idan Kanter, Seth Rausch
-- Create Date: 4/02/2017
-- Design Name: Full Adder
-- Project Name: ECE 459 Final Project - Logic Obfuscation
-- Target Devices: Nexys4
-- Description: First circuit is a Full Adder.
--             * Implementing a fault analysis technique to understand where to insert key gates.
--------------------------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FA is
    Port (
        clk     : IN std_logic;
        A       : IN std_logic;
        B       : IN std_logic;
        Cin     : IN std_logic;
        
        SW15    : IN std_logic; -- key input 1 (correct = 0)
        SW14    : IN std_logic; -- key input 2 (correct = 1)
        
        
        S       : OUT std_logic;
        Cout    : OUT std_logic
    );
end FA;

architecture Behavioral of FA is

    signal XOR1, XOR2, AND1, AND2, OR1  : std_logic;
    
    signal key_1    : std_logic;    -- xor gate for key 1
    signal key_2    : std_logic;    -- xnor gate for key 2
 
    signal zero     : std_logic := '0';

begin

    XOR1 <= A XOR B;    
    AND1 <= A AND B;      
    XOR2 <= key_1 XOR Cin;    
    AND2 <= Cin AND key_1;      
    OR1  <= AND1 OR key_2;      
    
    ----- Encryption --------
    key_1 <= XOR1 XOR SW15;         -- key gate 1
    key_2 <= AND1 XNOR SW14;        -- key gate 2
    
    
    
    
    ------- Output ---------
    S    <= XOR2;
    Cout <= OR1; 


end Behavioral;
