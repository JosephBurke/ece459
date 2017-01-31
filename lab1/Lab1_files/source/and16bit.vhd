library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and16bit is
  port (
    A : in  std_logic_vector(15 downto 0);
    B : in  std_logic_vector(15 downto 0);
    Y : out std_logic_vector(15 downto 0) 
  );
end and16bit;

architecture behavioral of and16bit is
begin
  Y <= A and B;
end behavioral;
