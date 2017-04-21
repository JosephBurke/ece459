--------------------------------------------------------------------------------------------------
-- Students: Joe Burke, Idan Kanter, Seth Rausch
-- Create Date: 4/20/2017
-- Design Name: Test Bench for Encrypt Full Adder
-- Project Name: ECE 459 Final Project - Logic Obfuscation
-- Target Devices: Nexys4
-- Description: First circuit is a Full Adder.
--             * Implementing a fault analysis technique to understand where to insert key gates.
--------------------------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_FA1 is
--  Port ( );
end tb_FA1;

architecture Behavioral of tb_FA1 is

    component FA
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
    end component;

    signal clk, A, B, Cin, SW15, SW14, S, Cout  : std_logic;

begin
    test: FA port map (clk, A, B, Cin, SW15, SW14, S, Cout);

    process
    begin
        SW15 <= '0';
        A <= '0';
        B <= '0';
        Cin <= '0';
        SW14 <= '0';
        wait for 50 ns;
        
        SW15 <= '0';
        A <= '0';
        B <= '0';
        Cin <= '0';
        SW14 <= '1';
        wait for 50 ns;
        
        SW15 <= '0';
        A <= '0';
        B <= '0';
        Cin <= '1';
        SW14 <= '0';
        wait for 50 ns;
        
        SW15 <= '0';
        A <= '0';
        B <= '0';
        Cin <= '1';
        SW14 <= '1';
        wait for 50 ns;
        
        SW15 <= '0';
        A <= '0';
        B <= '1';
        Cin <= '0';
        SW14 <= '0';
        wait for 50 ns;
        
        SW15 <= '0';
        A <= '0';
        B <= '1';
        Cin <= '0';
        SW14 <= '1';
        wait for 50 ns;
        
        SW15 <= '0';
        A <= '0';
        B <= '1';
        Cin <= '1';
        SW14 <= '0';
        wait for 50 ns;
        
        SW15 <= '0';
        A <= '0';
        B <= '1';
        Cin <= '1';
        SW14 <= '1';
        wait for 50 ns;
        
        SW15 <= '0';
        A <= '1';
        B <= '0';
        Cin <= '0';
        SW14 <= '0';
        wait for 50 ns;
        
        SW15 <= '0';
        A <= '1';
        B <= '0';
        Cin <= '0';
        SW14 <= '1';
        wait for 50 ns;
        
        SW15 <= '0';
        A <= '1';
        B <= '0';
        Cin <= '1';
        SW14 <= '0';
        wait for 50 ns;
        
        SW15 <= '0';
        A <= '1';
        B <= '0';
        Cin <= '1';
        SW14 <= '1';
        wait for 50 ns;
        
        SW15 <= '0';
        A <= '1';
        B <= '1';
        Cin <= '0';
        SW14 <= '0';
        wait for 50 ns;
        
        SW15 <= '0';
        A <= '1';
        B <= '1';
        Cin <= '0';
        SW14 <= '1';
        wait for 50 ns;
        
        SW15 <= '0';
        A <= '1';
        B <= '1';
        Cin <= '1';
        SW14 <= '0';
        wait for 50 ns;
        
        SW15 <= '0';
        A <= '1';
        B <= '1';
        Cin <= '1';
        SW14 <= '1';
        wait for 50 ns;
        
        SW15 <= '1';
        A <= '0';
        B <= '0';
        Cin <= '0';
        SW14 <= '0';
        wait for 50 ns;
        
        SW15 <= '1';
        A <= '0';
        B <= '0';
        Cin <= '0';
        SW14 <= '1';
        wait for 50 ns;
        
        SW15 <= '1';
        A <= '0';
        B <= '0';
        Cin <= '1';
        SW14 <= '0';
        wait for 50 ns;
        
        SW15 <= '1';
        A <= '0';
        B <= '0';
        Cin <= '1';
        SW14 <= '1';
        wait for 50 ns;
        
        SW15 <= '1';
        A <= '0';
        B <= '1';
        Cin <= '0';
        SW14 <= '0';
        wait for 50 ns;
        
        SW15 <= '1';
        A <= '0';
        B <= '1';
        Cin <= '0';
        SW14 <= '1';
        wait for 50 ns;
        
        SW15 <= '1';
        A <= '0';
        B <= '1';
        Cin <= '1';
        SW14 <= '0';
        wait for 50 ns;
        
        SW15 <= '1';
        A <= '0';
        B <= '1';
        Cin <= '1';
        SW14 <= '1';
        wait for 50 ns;
        
        SW15 <= '1';
        A <= '1';
        B <= '0';
        Cin <= '0';
        SW14 <= '0';
        wait for 50 ns;
        
        SW15 <= '1';
        A <= '1';
        B <= '0';
        Cin <= '0';
        SW14 <= '1';
        wait for 50 ns;
        
        SW15 <= '1';
        A <= '1';
        B <= '0';
        Cin <= '1';
        SW14 <= '0';
        wait for 50 ns;
        
        SW15 <= '1';
        A <= '1';
        B <= '0';
        Cin <= '1';
        SW14 <= '1';
        wait for 50 ns;
        
        SW15 <= '1';
        A <= '1';
        B <= '1';
        Cin <= '0';
        SW14 <= '0';
        wait for 50 ns;
        
        SW15 <= '1';
        A <= '1';
        B <= '1';
        Cin <= '0';
        SW14 <= '1';
        wait for 50 ns;
        
        SW15 <= '1';
        A <= '1';
        B <= '1';
        Cin <= '1';
        SW14 <= '0';
        wait for 50 ns;
        
        SW15 <= '1';
        A <= '1';
        B <= '1';
        Cin <= '1';
        SW14 <= '1';
        wait for 50 ns;
    
    
    end process;

end Behavioral;
