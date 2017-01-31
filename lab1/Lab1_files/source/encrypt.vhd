library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity encrypt is
  Port ( clk        : in std_logic;
         reset      : in std_logic;
         key_word   : in std_logic_vector(63 downto 0);
         plain_text : in std_logic_vector(31 downto 0);
         ENC_EN       : in std_logic;
         cipher_text  : out std_logic_vector(31 downto 0);
         done_flag    : out std_logic;
         running_flag : out std_logic
   );
end encrypt;

architecture Behavioral of encrypt is
  component round_cipher is
    port ( 
      blockcipher : in  std_logic_vector(31 downto 0);
      key_word    : in  std_logic_vector(15 downto 0);
      cipher_text : out std_logic_vector(31 downto 0)
    );
  end component round_cipher;

  component key_expansion is
    port (
      round         : in  std_logic_vector(7 downto 0);
      sel           : in  std_logic;
      key_word      : in  std_logic_vector(63 downto 0);
      clk           : in  std_logic;   
      reset         : in  std_logic;   
      key_expansion : out std_logic_vector(15 downto 0)
    );
  end component key_expansion;

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
      SEL : in  STD_LOGIC;
      A   : in  STD_LOGIC_VECTOR (15 downto 0);
      B   : in  STD_LOGIC_VECTOR (15 downto 0);
      X   : out STD_LOGIC_VECTOR (15 downto 0)
    );
  end component mux2to1;
  
  signal block_half1, block_half2 : std_logic_vector(15 downto 0);
  signal text_holder, temp_block : std_logic_vector(31 downto 0);
  signal key_expanded : std_logic_vector(15 downto 0);
  signal rnd : std_logic_vector(7 downto 0);
  signal enc_run : std_logic;

begin
   mux_left:  mux2to1 port map(ENC_EN, plain_text(31 downto 16), temp_block(31 downto 16), 
                                block_half2);
   mux_right: mux2to1 port map(ENC_EN, plain_text(15 downto 0), 
                                temp_block(15 downto 0), block_half1);
    
   reg16_left:  reg16 port map (clk, reset, block_half2, text_holder(31 downto 16));
   reg16_right: reg16 port map (clk, reset, block_half1, text_holder(15 downto 0));
    
   cipher_text <= text_holder;

   round: round_cipher port map (text_holder, key_expanded, temp_block);

   keys: key_expansion port map (rnd, ENC_EN, key_word, clk, reset, key_expanded);
    
   rnd_ctl: process(clk)
   begin
     if (clk'event and clk= '1') then
       if (reset = '1') then
         rnd <= x"00";
         enc_run <= '0';
         done_flag <= '0';
       else
         if (rnd = x"1F") then
           rnd <= x"00";
           enc_run <= '0';
           done_flag <= '1';
         elsif (ENC_EN = '1' and enc_run = '0') then
           rnd <= x"00";
           enc_run <= '1';
         elsif (enc_run = '1') then
           rnd <= std_logic_vector(unsigned(rnd) + 1);
         else
           rnd <= x"00";
           done_flag <= '0';
           enc_run <= '0';
         end if;
       end if;
     end if;
   end process;
    
   running_flag <= enc_run;

end Behavioral;
