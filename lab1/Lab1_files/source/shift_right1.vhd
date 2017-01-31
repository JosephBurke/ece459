library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_right1 is
  Port ( input1 : in std_logic_vector(15 downto 0);
         output : out std_logic_vector(15 downto 0)
        );
end shift_right1;

architecture Behavioral of shift_right1 is
begin
    
    output <= input1(0) & input1(15 downto 1);

end Behavioral;
