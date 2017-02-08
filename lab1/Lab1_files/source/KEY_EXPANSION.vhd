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
	signal uout0		:	std_logic_vector(15 downto 0);	-- 'C'
	signal uout1		:	std_logic_vector(15 downto 0);	-- 'Z'
	signal XOR4_out		:	std_logic_vector(15 downto 0);	-- output of XOR 'C', 'Z', key0, XOR2_out - "bambam"
	signal mux1_out		:	std_logic_vector(15 downto 0);	-- output of left mux1 
	signal mux2_out		:	std_logic_vector(15 downto 0);  -- output of 2nd from the left mux2
	signal mux3_out		:	std_logic_vector(15 downto 0);  -- output of 3rd from the left mux3
	signal mux4_out		:	std_logic_vector(15 downto 0);  -- output of right mux4
	signal key3			: 	std_logic_vector(15 downto 0);	-- output of register key3
	signal key2			: 	std_logic_vector(15 downto 0);	-- output of register key2
	signal key1			: 	std_logic_vector(15 downto 0);	-- output of register key1
	signal key0			: 	std_logic_vector(15 downto 0);	-- output of register key0 - "fred"
	signal sr3_out		:	std_logic_vector(15 downto 0);	-- output of the shift_rt3
	signal key1_XOR_sr3	:	std_logic_vector(15 downto 0);	-- output of xor01, input are key1 and sr3
	signal sr1_out		:	std_logic_vector(15 downto 0);	-- output of the shift_rt1
	signal xor2_out		:	std_logic_vector(15 downto 0);	-- output of xor2_out - "Wilma"
	
begin

	u_find		:	u_bit			port map (round, uout0, uout1);								-- round -> 'C' and 'Z'
	xor4		:	xor16bit_triple	port map (uout0, uout1, key0, xor2_out, XOR4_out); 			-- xor 4 inputs -> input of mux1
	mux1		:	mux2to1			port map (sel, key_word(63 downto 48), XOR4_out, mux1_out); -- mux xor4_output and key -> key3 
	key3_reg	:	reg16			port map (clk, reset, mux1_out, key3);                  	-- register 3
	mux2		:	mux2to1			port map (sel, key_word(47 downto 32), key3, mux2_out);		-- mux key3 and key -> key2 
	key2_reg	:	reg16			port map (clk, reset, mux2_out, key2);						-- register 2
	sr3			:	shift_right3	port map (key3, sr3_out);									-- key3 shift right by 3 bits
	mux3		:	mux2to1			port map (sel, key_word(31 downto 16), key2, mux3_out);		-- mux key2 and key -> key1 
	key1_reg	:	reg16			port map (clk, reset, mux3_out, key1);						-- register 1
	mux4		:	mux2to1			port map (sel, key_word(15 downto 0), key1, mux4_out);		-- mux key1 and key -> key0
	key0_reg	:	reg16			port map (clk, reset, mux4_out, key0);						-- register 0
	xor1		:	xor16bit		port map (key1, sr3_out, key1_XOR_sr3);						-- xor key1 and shift_rt3
	sr1			:	shift_right1	port map (key1_XOR_sr3, sr1_out);							-- xor01 shift right by 1 bit
	xor2		:	xor16bit		port map (sr1_out, key1_XOR_sr3, xor2_out);					-- xor shift_rt1 and xor01
		
	key_expansion <= key0;	-- output

end your_code;