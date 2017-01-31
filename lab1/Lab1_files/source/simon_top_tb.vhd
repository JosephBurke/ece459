library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_textio.all;

entity simon_top_tb is
end simon_top_tb;

--------------------------------------------------------------------------------------
------------------------ Simple Testbench .-------------------------------------------
--------------------------------------------------------------------------------------
architecture TB_SIMPLE of simon_top_tb is
  component simon_top is
    port ( 
      clk       : in  STD_LOGIC;
      reset     : in  STD_LOGIC;
      cipher_en : in  STD_LOGIC;
      enc_decN  : in  STD_LOGIC;
      uart_rx   : in  std_logic;
      uart_tx   : out std_logic
    );
  end component simon_top;
	
  -- Stimulus signals - signals mapped to the input and inout ports of tested entity
  signal lclk     : std_logic := '0';
  signal reset_l  : std_logic := '0';
  signal RX       : std_logic := '1';
  signal TX       : std_logic;	
  signal en_deN   : std_logic := '0';

  signal data_in  : std_logic_vector(31 downto 0) := x"34333231";

  -- Add your code here ...
  constant freq : time := 10 ns;
  constant baud : time := 8680 ns; -- 115200 baud => 8680 ns per bit

begin
  -- Unit Under Test port map
  UUT : simon_top
  port map (
    clk       => lclk,
    reset     => reset_l,
    cipher_en => '1',
    enc_decN  => en_deN,
    uart_rx   => RX,
    uart_tx   => TX
  );
	
  sim_proc : process
  begin
    reset_l <= '0';
    RX      <= '1';
    en_deN  <= '0';
    wait for 300 ns;
    reset_l <= '1';
    wait for 300 ns;
    reset_l <= '0';
    wait for 30000 ns;

    for i in 0 to 3 loop
      RX <= '0';  -- start bit
      wait for baud;

      -- send next byte
      for j in 0 to 7 loop
        RX <= data_in(i*8+j);
        wait for baud;
      end loop;

      RX <= '1';  -- stop bit
      wait for baud;
    end loop;

    for i in 0 to 3 loop
      RX <= '0';  -- start bit
      wait for baud;

      -- send next byte
      for j in 0 to 7 loop
        RX <= data_in(i*8+j);
        wait for baud;
      end loop;

      RX <= '1';  -- stop bit
      wait for baud;
    end loop;

    wait for 500000 ns;
  end process;
	
  clk_update : process(lclk)
  begin
    lclk <= not lclk after freq/2;
  end process;
	
end TB_SIMPLE;
