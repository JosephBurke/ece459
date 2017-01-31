library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2to1 is
  port (
    SEL : in  std_logic;
    A   : in  std_logic_vector(15 downto 0);
    B   : in  std_logic_vector(15 downto 0);
    X   : out std_logic_vector(15 downto 0)
  );
end mux2to1;

architecture behavioral of mux2to1 is
begin
          X <= A when (SEL = '1') else B;
end behavioral;
