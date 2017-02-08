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
    signal  left_shift_1_block   :   std_logic_vector (15 downto 0);      	-- upper block after left shift by 1 bit
    signal  left_shift_2_block   :   std_logic_vector (15 downto 0);      	-- upper block after left shift by 2 bit
    signal  left_shift_8_block   :   std_logic_vector (15 downto 0);      	-- upper block after left shift by 8 bit
    signal  and_1_8_blocks       :   std_logic_vector (15 downto 0);      	-- AND of the 1 and 8 left shifts
    signal  and_XOR_lower        :   std_logic_vector (15 downto 0);      	-- XOR of and result with lower_block
    signal  sl2_XOR_xor1         :   std_logic_vector (15 downto 0);      	-- XOR of the left shift by 2 block with the upper xor
    signal  lower_block          :   std_logic_vector (15 downto 0);		-- lower block of blockcipher
    signal  upper_block          :   std_logic_vector (15 downto 0);		-- upper block of blockcipher
    signal  xor2_XOR_key         :   std_logic_vector (15 downto 0);		-- xor of middle xor and the key

  begin     	
		   
    sl1         :   shift_left1 port map (blockcipher(31 downto 16), left_shift_1_block);               -- upper block shift left by 1
    sl8         :   shift_left8 port map (blockcipher(31 downto 16), left_shift_8_block);               -- upprr block shift left by 8
    and_1_8     :   and16bit    port map (left_shift_1_block, left_shift_8_block, and_1_8_blocks);      -- AND the 1-bit left shift and the 8-bit left shift blocks
    sl2         :   shift_left2 port map (blockcipher(31 downto 16), left_shift_2_block);               -- upper block shift left by 2
    xor1        :   xor16bit    port map (and_1_8_blocks, blockcipher(15 downto 0), and_XOR_lower);     -- XOR the result of the AND operation with the lower block of the blockcipher
    xor2        :   xor16bit    port map (left_shift_2_block, and_XOR_lower, sl2_XOR_xor1);             -- XOR the result of upper xor with the 2-bit left shift block
    xor3        :   xor16bit    port map (sl2_XOR_xor1, key_word, xor2_XOR_key);                        -- XOR the result of middle xor with the key
    
    lower_block <= blockcipher(31 downto 16);	-- new lower block is the upper block
    upper_block <= xor2_XOR_key;				-- new upper block is the result of bottom xor
    cipher_text <= upper_block & lower_block;	-- attach the two blocks together to form the cipher text - output
		 
end your_code;