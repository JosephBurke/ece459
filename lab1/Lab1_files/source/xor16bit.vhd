library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor16bit is
  port (
    input1 : in  std_logic_vector(15 downto 0);
    input2 : in  std_logic_vector(15 downto 0);
    output : out std_logic_vector(15 downto 0)
  );
end xor16bit;

architecture behavioral of xor16bit is
begin
  output <= input1 xor input2;
end behavioral;
