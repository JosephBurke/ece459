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
  signal ( lower_block          :   std_logic_vector (15 downto 0);     -- lower block (16-bits) of blockcipher
           upper_block          :   std_logic_vector (15 downto 0;      -- upper block (16-bits) of blockcipher
           left_shit_1_block    :   std_logic_vector (15 downto 0;      -- 16 bit block to hold the upper block after left shift by 1 bit
           left_shit_2_block    :   std_logic_vector (15 downto 0;      -- 16 bit block to hold the upper block after left shift by 2 bit
           left_shit_8_block    :   std_logic_vector (15 downto 0;      -- 16 bit block to hold the upper block after left shift by 8 bit
           )

begin
  -- YOUR CODE GOES HERE!
  sl1:  shit_left1 port map(upper_block, left_shit_1_block);
  sl2:  shit_left2 port map(upper_block, left_shit_2_block);
  sl8:  shit_left8 port map(upper_block, left_shit_8_block);
  
  upper_block <= blockcipher(31 downto 16);     -- separates the blockcipher to 2 halves
  lower_block <= blockcipher(15 downto 0);
  
  process                                       -- HOW MANY ROUNDS????
    
    
  end process
  
  
end your_code;
