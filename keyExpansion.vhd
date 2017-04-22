library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.aes128Pkg.all;

entity keyExpansion is
  
  port (

    Clk_CI : in std_logic;
    Reset_RBI : in std_logic;
    Start_SI : in std_logic;
    Cipherkey_DI : in std_logic_vector(127 downto 0);
    Roundkeys_DO : out roundkeyArrayType);

end entity keyExpansion;

architecture Behavioral of keyExpansion is

  type byteArrayType is array (0 to 9) of std_logic_vector(7 downto 0);
  type subWordArrayType is array (0 to 9) of Word;
  type expkeyArrayType is array (0 to 43) of Word;
  type rconArrayType is array (0 to 9) of Word;

  constant RCON : byteArrayType := (
    x"01", x"02", x"04", x"08", x"10", x"20", x"40", x"80", x"1B", x"36");

  function "xor" (
    left  : Word;
    right : Word) return Word is
    variable Result : Word;
  begin
    Result(0) := left(0) xor right(0);
    Result(1) := left(1) xor right(1);
    Result(2) := left(2) xor right(2);
    Result(3) := left(3) xor right(3);
    return Result;
  end "xor";

  function conv_std_logic_vector (
    input : Word)
    return std_logic_vector is
  begin  -- function conv_std_logic_vector
    return input(0) & input(1) & input(2) & input(3);
  end function conv_std_logic_vector;

  function conv_std_logic_vector (
    column0 : Word;
    column1 : Word;
    column2 : Word;
    column3 : Word)
    return std_logic_vector is
  begin  -- function conv_std_logic_vector
    return
      column0(0) & column0(1) & column0(2) & column0(3) &
      column1(0) & column1(1) & column1(2) & column1(3) &
      column2(0) & column2(1) & column2(2) & column2(3) &
      column3(0) & column3(1) & column3(2) & column3(3);
  end function conv_std_logic_vector;

  component subWord is
    port (
      In_DI  : in  Word;
      Out_DO : out Word);
  end component subWord;

  signal ExpKey_DN, ExpKey_DP : expkeyArrayType;
  signal SubWordIn_D : subWordArrayType;
  signal SubWordOut_D : subWordArrayType;
  signal Rcon_D : rconArrayType;
  signal Roundkeys_D : roundkeyArrayType;
  signal EnRndKeys_SN, EnRndKeys_SP :  std_logic_vector(0 to 9);
  signal AllRndKeysDisabled_S : std_logic;
  
begin  -- architecture rtl

  gen_subWords : for i in 0 to 9 generate
    subWords : subWord
      port map (
        In_DI  => SubWordIn_D(i),
        Out_DO => SubWordOut_D(i));
  end generate gen_subWords;


  gen_outputKeys : for i in 0 to 10 generate
    Roundkeys_DO(i) <= conv_std_logic_vector(
      ExpKey_DP(4*i), ExpKey_DP(4*i+1), ExpKey_DP(4*i+2), ExpKey_DP(4*i+3));
  end generate gen_outputKeys;

  ExpKey_DN(0) <= conv_word(Cipherkey_DI(127 downto 96)) when Start_SI = '1' else ExpKey_DP(0);
  ExpKey_DN(1) <= conv_word(Cipherkey_DI(95 downto 64))  when Start_SI = '1' else ExpKey_DP(1);
  ExpKey_DN(2) <= conv_word(Cipherkey_DI(63 downto 32))  when Start_SI = '1' else ExpKey_DP(2);
  ExpKey_DN(3) <= conv_word(Cipherkey_DI(31 downto 0))   when Start_SI = '1' else ExpKey_DP(3);

  gen_roundKeys : for i in 0 to 9 generate
    SubWordIn_D(i) <= ExpKey_DP(4*i+3);

    Rcon_D(i)(0) <= SubWordOut_D(i)(1) xor RCON(i);
    Rcon_D(i)(1) <= SubWordOut_D(i)(2);
    Rcon_D(i)(2) <= SubWordOut_D(i)(3);
    Rcon_D(i)(3) <= SubWordOut_D(i)(0);

    ExpKey_DN(4*(i+1)+0) <= Rcon_D(i) xor ExpKey_DP(4*i)                                                                when EnRndKeys_SP(i) = '1' else ExpKey_DP(4*(i+1)+0);
    ExpKey_DN(4*(i+1)+1) <= Rcon_D(i) xor ExpKey_DP(4*i) xor ExpKey_DP(4*i+1)                                           when EnRndKeys_SP(i) = '1' else ExpKey_DP(4*(i+1)+1);
    ExpKey_DN(4*(i+1)+2) <= Rcon_D(i) xor ExpKey_DP(4*i) xor ExpKey_DP(4*i+1) xor ExpKey_DP(4*i+2)                      when EnRndKeys_SP(i) = '1' else ExpKey_DP(4*(i+1)+2);
    ExpKey_DN(4*(i+1)+3) <= Rcon_D(i) xor ExpKey_DP(4*i) xor ExpKey_DP(4*i+1) xor ExpKey_DP(4*i+2) xor ExpKey_DP(4*i+3) when EnRndKeys_SP(i) = '1' else ExpKey_DP(4*(i+1)+3);
  end generate gen_roundKeys;


  EnRndKeys_SN <=
    '1' & EnRndKeys_SP(0 to 8) when Start_SI = '1' else
    EnRndKeys_SP when AllRndKeysDisabled_S = '1' else
    '0' & EnRndKeys_SP(0 to 8);

  pComb_CalcAllRndKeysDisabled : process (EnRndKeys_SP) is
    variable tmp : std_logic;
  begin  -- process pComb_CalcAllRndKeysDisabled
    tmp := EnRndKeys_SP(0);
    for i in 1 to 9 loop
      tmp := tmp or EnRndKeys_SP(i);
    end loop;  -- i
    AllRndKeysDisabled_S <= not tmp;
  end process pComb_CalcAllRndKeysDisabled;

  pSequ_FlipFlops : process (Clk_CI, Reset_RBI) is
  begin  -- process p_FlipFlops
    if Reset_RBI = '0' then             -- asynchronous reset (active low)
      ExpKey_DP    <= (others => ZERO_WORD);
      EnRndKeys_SP <= (others => '0');
    elsif Clk_CI'event and Clk_CI = '1' then  -- rising clock edge
      ExpKey_DP    <= ExpKey_DN;
      EnRndKeys_SP <= EnRndKeys_SN;
    end if;
  end process pSequ_FlipFlops;
end architecture Behavioral;
