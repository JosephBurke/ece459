-- MODIFY THIS FILE TO IMPLEMENT SIMON KEY EXPANSION ALGORITHM

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;

entity key_expansion is
  port (
    round         : IN  std_logic_vector(7 downto 0);
    sel           : IN  std_logic;
    key_word      : IN  std_logic_vector(63 downto 0);
    clk           : IN  std_logic;   
    reset         : IN  std_logic;   
    key_expansion : OUT std_logic_vector(15 downto 0)
  );
end key_expansion;

architecture your_code of key_expansion is
  -- These components are available to use if desired...
  -- Feel free to implement your own...
  
  component reg16 is
    port (
      clk          : in  std_logic;
      reset        : in  std_logic;
      input_16bits : in  std_logic_vector(15 downto 0);
      flop16       : out std_logic_vector(15 downto 0)
    );
  end component reg16;
  
  component mux2to1 is
    port (
      SEL : in  std_logic;
      A   : in  std_logic_vector (15 downto 0);
      B   : in  std_logic_vector (15 downto 0);
      X   : out std_logic_vector (15 downto 0)
    );
  end component mux2to1;
  
  component shift_right1 is
    port (
      input1 : in  std_logic_vector(15 downto 0);
      output : out std_logic_vector(15 downto 0)
    );
  end component shift_right1;
  
  component shift_right3 is
    port (
      input1 : in  std_logic_vector(15 downto 0);
      output : out std_logic_vector(15 downto 0)
    );
  end component shift_right3;
  
  component xor16bit is
    port (
      input1 : in  std_logic_vector(15 downto 0);
      input2 : in  std_logic_vector(15 downto 0);
      output : out std_logic_vector(15 downto 0)
    );
  end component xor16bit;
  
  component u_bit is
    port (
      round : in  std_logic_vector(7 downto 0);
      u_out : out std_logic_vector(15 downto 0);
      u_int : out std_logic_vector(15 downto 0)
    );
  end component u_bit;
  
  component xor16bit_triple is
    port (
      input1 : in  std_logic_vector(15 downto 0);
      input2 : in  std_logic_vector(15 downto 0);
      input3 : in  std_logic_vector(15 downto 0);
      input4 : in  std_logic_vector(15 downto 0);
      output : out std_logic_vector(15 downto 0)
    );
  end component xor16bit_triple;

  -- Will need to declare intermediary signals here      

begin
  -- YOUR CODE GOES HERE!


end your_code;