library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg16 is
  port (
    clk          : in  std_logic;
    reset        : in  std_logic;
    input_16bits : in  std_logic_vector(15 downto 0);
    flop16       : out std_logic_vector(15 downto 0)
  );
end reg16;

architecture behavioral of reg16 is
begin
  process(clk)
  begin
    if(clk'event and clk = '1') then
      if (reset = '1') then
        flop16 <= x"0000";
      else
        flop16 <= input_16bits;
      end if;
    end if;
  end process;
end behavioral;
