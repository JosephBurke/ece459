----------------------------------------------------------------------------------
-- Create Date: 02/18/2017 10:24:50 AM
-- Students: Joe Burke, Idan Kanter, Seth Rausch
-- Module Name: task2_tb - Behavioral
-- Project Name: Lab 2 - 8-bit LFSR 
-- Target Devices: Nexys4 
-- Description: A test bench for an 8-bit LFSR
-----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_textio.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity task2_tb is
end task2_tb;

architecture test_bench of task2_tb is
    
    component eight_bit is 
        port (
            clk, reset, ctrl    :    IN std_logic;
            din                 :    IN std_logic_vector(7 DOWNTO 0);
            q                   :    INOUT std_logic_vector(7 DOWNTO 0)
        );

    end component eight_bit;
    
    signal clock    :   std_logic;
    signal rst      :   std_logic;
    signal control  :   std_logic;
    signal d_in     :   std_logic_vector(7 DOWNTO 0);
    signal output   :   std_logic_vector(7 DOWNTO 0);
    
begin
    
    process
    begin
        clock <= '0';
        wait for 50 ns;
        clock <= '1';
        wait for 50 ns;
    end process;
    
--    process
--    begin
--      rst <= '0';
--      wait for 50 ns;
--      rst <= '1';
--      wait for 50 ns;
--      rst <= '0';
--      wait;
--    end process;
    
    process
    begin
        control <= '1';
        wait for 50 ns;
        d_in <= "00000000";
        wait for 50 ns;
        rst <= '1';
        wait for 50 ns;
        rst <= '0';
        wait for 50 ns;
        d_in <= "10000000";
        wait for 50 ns;
        d_in <= "01000000";
        wait for 50 ns;
        d_in <= "00100000";
        wait for 50 ns;
        d_in <= "00010000";
        wait for 50 ns;
        d_in <= "00001000";
        wait for 50 ns;
        d_in <= "00000100";
        wait for 50 ns;
        d_in <= "00000010";
        wait for 50 ns;
        d_in <= "00000001";
        wait for 50 ns;

        control <= '0';
        wait for 50 ns;
        rst <= '1';
        wait for 50 ns;
        rst <= '0';
        wait for 5000 ns;

      end process;

    
    
    test: eight_bit port map (clock, rst, control, d_in, output);
    
end test_bench;
