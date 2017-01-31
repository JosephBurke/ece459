library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_textio.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity encrypt_tb is
end encrypt_tb;

architecture tbench of encrypt_tb is
  component encrypt is
    Port ( clk        : in std_logic;
           reset      : in std_logic;
           key_word   : in std_logic_vector(63 downto 0);
           plain_text : in std_logic_vector(31 downto 0);
           ENC_EN       : in std_logic;
           cipher_text  : out std_logic_vector(31 downto 0);
           done_flag    : out std_logic;
           running_flag : out std_logic
           
     );
  end component encrypt;

  signal clk      : std_logic;  
  constant clk_period : time := 10 ns;
  signal ptext : std_logic_vector(31 downto 0) := "11111111111111111111111111111111";
  signal keyw : std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
  signal ctext : std_logic_vector(31 downto 0);
  signal rst, enable  : std_logic := '0';
  signal done_flg, run_flg : std_logic;
  
begin
  process
  begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
  end process;
  
  process
  begin
    rst <= '0';
    wait for 10 ns;
    rst <= '1';
    wait for 10 ns;
    rst <= '0';
    wait;
  end process;
  
  process
  begin
    enable <= '0';
    wait for 20 ns;
    enable <= '1';
    wait for 10 ns;
    enable <= '0';
    wait;
  end process; 

  test: encrypt port map (clk, rst, keyw, ptext, enable, ctext, done_flg, run_flg);
  
end tbench;