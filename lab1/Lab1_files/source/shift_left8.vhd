library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_left8 is
  port (
    input1 : in  std_logic_vector(15 downto 0);
    output : out std_logic_vector(15 downto 0)
  );
end shift_left8;

architecture behavioral of shift_left8 is
begin
  output <= input1(7 downto 0) & input1(15 downto 8);
end behavioral;