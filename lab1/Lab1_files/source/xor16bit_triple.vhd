
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor16bit_triple is
  Port ( input1 : in std_logic_vector(15 downto 0);
         input2 : in std_logic_vector(15 downto 0);
         input3 : in std_logic_vector(15 downto 0);
         input4 : in std_logic_vector(15 downto 0);
         output : out std_logic_vector(15 downto 0)
        );
end xor16bit_triple;

architecture Behavioral of xor16bit_triple is
begin
    output <= input1 xor input2 xor input3 xor input4;
end Behavioral;
