-- File: full_adder.vhd
-- Generated by MyHDL 0.9.0
-- Date: Sat Apr 22 13:43:12 2017


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

use work.pck_myhdl_090.all;

entity full_adder is
    port (
        A: in std_logic;
        B: in std_logic;
        C_in: in std_logic;
        K1: in std_logic;
        K2: in std_logic;
        K3: in std_logic;
        Sum_out: out std_logic;
        C_out: out std_logic
    );
end entity full_adder;
-- full adder circuit
-- {A,B,C} --- inputs
-- {Sum_out,C_out} -- outputs

architecture MyHDL of full_adder is






begin





FULL_ADDER_LOGIC: process (B, C_in, K2, K3, K1, A) is
    variable Sig3: integer;
    variable Sig1: integer;
    variable Sig2: integer;
begin
    Sig1 := to_integer(((A xor B) xor K1));
    Sig2 := to_integer(((stdl(Sig1) and C_in) xor K2));
    Sig3 := to_integer(((A and B) xor K3));
    Sum_out <= (stdl(Sig1) xor C_in);
    C_out <= stdl((Sig2 or Sig3));
end process FULL_ADDER_LOGIC;

end architecture MyHDL;
