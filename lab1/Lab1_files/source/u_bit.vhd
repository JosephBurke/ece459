library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity u_bit is

 Generic ( u          : std_logic_vector(15 downto 0) := "1111111111111100";
           u_sequence : std_logic_vector(0 to 30)     := "1111101000100101011000011100110"
           );

  Port ( round : in std_logic_vector(7 downto 0);
         u_out : out std_logic_vector(15 downto 0);
         u_int : out std_logic_vector(15 downto 0)
         );
end u_bit;

architecture Behavioral of u_bit is

begin

    process(round)
        variable u_seq : std_logic;
        variable temp1 : integer;
        variable temp2 : std_logic_vector(15 downto 0);

    begin
    
    temp1 := to_integer(unsigned(round));
    u_seq := u_sequence((temp1 mod 31));
    if(u_seq = '1') then
        temp2 := "0000000000000001";
    else
        temp2 := "0000000000000000";
    end if;
    
    u_int <= temp2;
    u_out <= u;
    
    end process;

end Behavioral;
