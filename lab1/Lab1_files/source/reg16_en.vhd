library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg16_en is
    port ( clk      : in std_logic;
           enb      : in std_logic;
           reset    : in std_logic;
           input_16 : in std_logic_vector(15 downto 0);
           flop16   : out std_logic_vector(15 downto 0)
           );
end reg16_en;

architecture behavioral of reg16_en is
begin
  process(clk)
  begin
    if(clk'event and clk = '1') then
      if (reset = '1') then
        flop16 <= x"0000";
      elsif (enb = '1') then
        flop16 <= input_16;
      end if;
    end if;
  end process;
end behavioral;
