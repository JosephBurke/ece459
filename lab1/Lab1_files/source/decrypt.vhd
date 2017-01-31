library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity decrypt is
  Port ( clk        : in std_logic;
         reset      : in std_logic;
         key_word   : in std_logic_vector(63 downto 0);
         cipher_text : in std_logic_vector(31 downto 0);
         ENC_EN       : in std_logic;
         plain_text  : out std_logic_vector(31 downto 0);
         done_flag    : out std_logic;
         running_flag : out std_logic
   );
end decrypt;

architecture Behavioral of decrypt is

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
  
  component reg16_en is
      port ( clk      : in std_logic;
             enb      : in std_logic;
             reset    : in std_logic;
             input_16 : in std_logic_vector(15 downto 0);
             flop16   : out std_logic_vector(15 downto 0)
             );
  end component reg16_en;
  
  signal block_half1, block_half2 : std_logic_vector(15 downto 0);
  signal text_holder, temp_block : std_logic_vector(31 downto 0);
  signal key_expanded : std_logic_vector(15 downto 0);
  signal key_round : std_logic_vector(15 downto 0);
  signal rnd, rnd2 : std_logic_vector(7 downto 0);
  signal enc_run : std_logic;
  signal key_ex_i : std_logic_vector(511 downto 0);

  signal trig_dec : std_logic;
  signal init : std_logic;
  signal sel_line : std_logic;
  signal sample : std_logic_vector(31 downto 0);

begin
   mux_left :  mux2to1 port map (trig_dec, cipher_text(15 downto 0),
                                temp_block(31 downto 16), block_half2);
   mux_right : mux2to1 port map (trig_dec, cipher_text(31 downto 16), 
                                temp_block(15 downto 0), block_half1);
   
   sel_line <= trig_dec or init;
   
   reg16_left :  reg16 port map (clk, reset, block_half2, text_holder(31 downto 16));
   reg16_right : reg16 port map (clk, reset, block_half1, text_holder(15 downto 0));
    
   plain_text <= text_holder(15 downto 0) & text_holder(31 downto 16);

    --gen: for i in 0 to 31 generate
   round : round_cipher port map (text_holder, key_round, temp_block);
    --end generate;   
    
    --gen: for i in 0 to 31 generate
   keys : key_expansion port map (rnd, ENC_EN, key_word, clk, reset, key_expanded);
    --end generate;
    
   rnd_ctl: process(clk)
     variable temp_i : integer := 31;
   begin
      if (clk'event and clk= '1') then
        if (reset = '1') then
          rnd <= x"00";
          rnd2 <= x"00";
          enc_run <= '0';
          init <= '0';
          done_flag <= '0';
          trig_dec <= '0';
          temp_i := 31;
        else
          if (rnd = x"1F") then
            rnd <= x"00";
            enc_run <= '0';
            temp_i := 31;
            --rnd2 <= x"00";
            trig_dec <= '1';
--            key_round <= key_ex_i((16*(temp_i+1)-1) downto (16*temp_i));
            
--            if (temp_i > 0) then
--              temp_i := temp_i - 1;
--            else
--              temp_i := 31;
--            end if;
            
            rnd2 <= x"00";--std_logic_vector(unsigned(rnd2) + 1);
--            init <= '1';
--            done_flag <= '1';
--          elsif (rnd = x"20" and init = '1') then
--            rnd <= x"00";
--            enc_run <= '0';
--            done_flag <= '1';
--          elsif trig_dec = '1' then
--            trig_dec <= '0';
          elsif (ENC_EN = '1' and enc_run = '0') then
            rnd <= x"00";
            enc_run <= '1';
            --temp_i := 31;
          elsif (enc_run = '1') then
            rnd <= std_logic_vector(unsigned(rnd) + 1);
          else
            rnd <= x"00";
            enc_run <= '0';
          end if;
          
          if (rnd2 = x"1F") then
            rnd2 <= x"00";
            enc_run <= '0';
            init <= '0';
            done_flag <= '1';
          elsif (trig_dec = '1' and init = '0') then
            --temp_i := 31;
            rnd2 <= x"00";
            init <= '1';
            trig_dec <= '0';
            done_flag <= '0';
            key_round <= key_ex_i((16*(temp_i+1)-1) downto (16*temp_i));
            
            if (temp_i > 0) then
              temp_i := temp_i - 1;
            else
              temp_i := 31;
            end if;
            
            --rnd2 <= std_logic_vector(unsigned(rnd2) + 1);
          elsif (init = '1') then
            key_round <= key_ex_i((16*(temp_i+1)-1) downto (16*temp_i));
            if (temp_i > 0) then
              temp_i := temp_i - 1;
            else
              temp_i := 31;
            end if; 
            rnd2 <= std_logic_vector(unsigned(rnd2) + 1);
          else
            rnd2 <= x"00";
            done_flag <= '0';
            init <= '0';
            --enc_run <= '0';
          end if;
          
        end if;
      end if;
    end process;
    
    rnd_enb: process(clk)
      variable temp : integer := 0;
    begin
--            for i in 0 to 31 loop
      if (clk'event and clk='1') then
        if (reset = '1') then
          for i in 0 to 31 loop
            sample(i) <= '0';
          end loop;        
        else
          --if (init = '0' and trig_dec = '0') then
            --temp := to_integer(unsigned(rnd));
--            if (ENC_EN = '1' and rnd = x"00") then
--              sample(temp) <= '1';
            if (ENC_EN = '1') then
              temp := 0;
              sample(0) <= '1';
              
            elsif (sample(31) = '1') then
              sample(31) <= '0';
            elsif (enc_run = '1') then
             -- if(temp < 32) then
                sample(temp) <= '0';
             -- end if;
              
              if(temp <31) then
              temp := temp + 1;
              else
              temp := 31;
              end if;
              
              --if(temp < 32) then
                sample(temp) <= '1';
              --end if;

            else
             -- if(temp < 32) then
                sample <= x"00000000";
             -- end if;
            end if;
          --else
          --  sample <= x"00000000";
          --end if;
        end if;
      end if;
    end process;
        
    generate_reg16_en: for i in 0 to 31 generate
        comp: reg16_en port map (clk, sample(i), reset, key_expanded, key_ex_i((16*(i+1)-1) downto (16*i)));
    end generate generate_reg16_en;
    
   running_flag <= enc_run or init;


end Behavioral;
