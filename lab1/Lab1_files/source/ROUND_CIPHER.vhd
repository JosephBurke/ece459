-- MODIFY THIS FILE TO IMPLEMENT SIMON SINGLE-ROUND ALGORITHM

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity round_cipher is
  port ( 
    blockcipher : in  std_logic_vector(31 downto 0);
    key_word    : in  std_logic_vector(15 downto 0);
    cipher_text : out std_logic_vector(31 downto 0)
  );
end round_cipher;

architecture your_code of round_cipher is
  -- You can use these components if needed...
  -- Feel free to develop your own logic as well...

  component shift_left1 is
    port (
      input1 : in  std_logic_vector(15 downto 0);
      output : out std_logic_vector(15 downto 0)
    );
  end component shift_left1;
    
  component shift_left2 is
    port (
      input1 : in  std_logic_vector(15 downto 0);
      output : out std_logic_vector(15 downto 0)
    );
  end component shift_left2;
    
  component shift_left8 is
    port (
      input1 : in  std_logic_vector(15 downto 0);
      output : out std_logic_vector(15 downto 0)
    );
  end component shift_left8;
    
  component xor16bit is
    port (
      input1 : in  std_logic_vector(15 downto 0);
      input2 : in  std_logic_vector(15 downto 0);
      output : out std_logic_vector(15 downto 0)
    );
  end component xor16bit;
    
  component and16bit is
    port (
      A : in  std_logic_vector(15 downto 0);
      B : in  std_logic_vector(15 downto 0);
      Y : out std_logic_vector(15 downto 0)
    );
  end component and16bit;
    
  component ctext_reg is
    port (
      clk           : in  std_logic;
      reset         : in  std_logic;
      round         : in  std_logic_vector(7 downto 0);
      input1_16bits : in  std_logic_vector(15 downto 0);
      input2_16bits : in  std_logic_vector(15 downto 0);
      flop32        : out std_logic_vector(31 downto 0);
      text_flag     : out std_logic
    );
  end component ctext_reg;

  -- Will need to declare intermediary signals

begin
  -- YOUR CODE GOES HERE!
  
  
end your_code;
