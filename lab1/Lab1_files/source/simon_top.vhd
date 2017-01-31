library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity simon_top is
  port ( 
    clk       : in  STD_LOGIC;
    reset     : in  STD_LOGIC;
    cipher_en : in  STD_LOGIC;
    enc_decN  : in  STD_LOGIC;
    uart_rx   : in  std_logic;
    uart_tx   : out std_logic
  );
end simon_top;

architecture behavioral of simon_top is
  component FIFO_8I32O is
    generic (
      constant DATAINP_WIDTH : positive := 8;
      constant DATAOUT_WIDTH : positive := 32;
      constant FIFO_DEPTH : positive := 64
    );
    port ( 
      CLK       : in  STD_LOGIC;
      RST       : in  STD_LOGIC;
      WriteEn   : in  STD_LOGIC;
      DataIn    : in  STD_LOGIC_VECTOR (DATAINP_WIDTH - 1 downto 0);
      ReadEn    : in  STD_LOGIC;
      DataOut   : out STD_LOGIC_VECTOR (DATAOUT_WIDTH - 1 downto 0);
      Empty     : out STD_LOGIC;
      Full      : out STD_LOGIC
    );
  end component FIFO_8I32O;
    
  component FIFO_32I8O is
    generic (
      constant DATAINP_WIDTH : positive := 32;
      constant DATAOUT_WIDTH : positive := 8;
      constant FIFO_DEPTH : positive := 64
    );
    port ( 
      CLK       : in  STD_LOGIC;
      RST       : in  STD_LOGIC;
      WriteEn   : in  STD_LOGIC;
      DataIn    : in  STD_LOGIC_VECTOR (DATAINP_WIDTH - 1 downto 0);
      ReadEn    : in  STD_LOGIC;
      DataOut   : out STD_LOGIC_VECTOR (DATAOUT_WIDTH - 1 downto 0);
      Empty     : out STD_LOGIC;
      Full      : out STD_LOGIC
    );
  end component FIFO_32I8O;
    
  component uart_rx6 
    port (
      serial_in               : in  std_logic;
      en_16_x_baud            : in  std_logic;
      data_out                : out std_logic_vector(7 downto 0);
      buffer_read             : in  std_logic;
      buffer_data_present     : out std_logic;
      buffer_half_full        : out std_logic;
      buffer_full             : out std_logic;
      buffer_reset            : in  std_logic;
      clk                     : in  std_logic
    );
  end component;
    
  component uart_tx6 
    port (
      data_in                 : in  std_logic_vector(7 downto 0);
      en_16_x_baud            : in  std_logic;
      serial_out              : out std_logic;
      buffer_write            : in  std_logic;
      buffer_data_present     : out std_logic;
      buffer_half_full        : out std_logic;
      buffer_full             : out std_logic;
      buffer_reset            : in  std_logic;
      clk                     : in  std_logic
    );
  end component;
    
  component encrypt is
    Port ( clk        : in std_logic;
           reset      : in std_logic;
           key_word   : in std_logic_vector(63 downto 0);
           plain_text : in std_logic_vector(31 downto 0);
           ENC_EN       : in std_logic;
           cipher_text  : out std_logic_vector(31 downto 0);
           done_flag    : out std_logic;
           running_flag : out std_logic
           
     );
  end component encrypt;
  
  component decrypt is
    Port ( clk        : in std_logic;
           reset      : in std_logic;
           key_word   : in std_logic_vector(63 downto 0);
           cipher_text : in std_logic_vector(31 downto 0);
           ENC_EN       : in std_logic;
           plain_text  : out std_logic_vector(31 downto 0);
           done_flag    : out std_logic;
           running_flag : out std_logic    
     );
  end component decrypt;
    
  signal uart_rx_data_out      : std_logic_vector(7 downto 0);
  signal read_from_uart_rx     : std_logic;
  signal uart_rx_data_present  : std_logic;
  signal uart_rx_half_full     : std_logic;
  signal uart_rx_full          : std_logic;
    
  signal uart_tx_data_in       : std_logic_vector(7 downto 0);
  signal write_to_uart_tx      : std_logic;
  signal uart_tx_data_present  : std_logic;
  signal uart_tx_half_full     : std_logic;
  signal uart_tx_full          : std_logic;
    
  signal baud_count            : integer range 0 to 53 := 0; 
  signal en_16_x_baud          : std_logic := '0';

  signal F1toENC_Data : std_logic_vector(31 downto 0);

  signal Empty_8IN     : std_logic;
  signal Full_8IN      : std_logic;
  signal Empty_32IN    : std_logic;
  signal Full_32IN     : std_logic;
  signal ReadEn_8IN    : std_logic;
  signal WriteEn_8IN   : std_logic;
  signal WriteEn_32IN  : std_logic;
  signal ReadEn_32IN   : std_logic;
  signal DataOut_8IN   : std_logic_vector(31 downto 0);
  signal DataIn_32IN   : std_logic_vector(31 downto 0);
    
  signal write_flag    : std_logic;
  signal write_flag2   : std_logic;
  signal write_flag3   : std_logic;
    
  signal key_word      : std_logic_vector(63 downto 0) := x"0000000000000000";
  signal rnd           : std_logic_vector(7 downto 0); -- := x"00";
  signal ENC_EN        : std_logic;                -- pulse high to start encrypt/decrypt
  signal enc_run       : std_logic;                -- remains high during encryption cycle
  signal DONE_e        : std_logic;
  signal cipher_text   : std_logic_vector(31 downto 0);
  signal cipher_text2   : std_logic_vector(31 downto 0);
  
  signal DONE_d        : std_logic;
  signal plain_text    : std_logic_vector(31 downto 0);
  signal dec_run       : std_logic;
  signal DEC_EN        : std_logic;
  
  signal crypto_text   : std_logic_vector(31 downto 0);
  signal crypto_en     : std_logic;
  signal done_c        : std_logic;

begin

  F8I32O: FIFO_8I32O port map (clk, reset, WriteEn_8IN, uart_rx_data_out, 
                               ReadEn_8IN, F1toENC_Data, Empty_8IN, Full_8IN );

  enc: encrypt port map (clk, reset, key_word, F1toENC_Data, ENC_EN, 
                         cipher_text, DONE_e, enc_run);
  dec: decrypt port map (clk, reset, key_word, F1toENC_Data, ENC_EN,
                         plain_text, DONE_d, dec_run);

  crypto_text <= cipher_text when (enc_decN = '1') else plain_text;
  done_c <= DONE_e when (enc_decN = '1') else DONE_d;

  DataIn_32IN <= crypto_text when (cipher_en = '1') else F1toENC_Data;
  WriteEn_32IN <= done_c when (cipher_en = '1') else ENC_EN;

  F32I8O: FIFO_32I8O port map (clk, reset, WriteEn_32IN, DataIn_32IN, 
                               ReadEn_32IN, uart_tx_data_in, Empty_32IN, 
                               Full_32IN );
  
  rx: uart_rx6 port map (serial_in           => uart_rx,
                         en_16_x_baud        => en_16_x_baud,
                         data_out            => uart_rx_data_out,
                         buffer_read         => read_from_uart_rx,
                         buffer_data_present => uart_rx_data_present,
                         buffer_half_full    => uart_rx_half_full,
                         buffer_full         => uart_rx_full,
                         buffer_reset        => reset,              
                         clk                 => clk );
  
  tx: uart_tx6 port map (data_in             => uart_tx_data_in,
                         en_16_x_baud        => en_16_x_baud,
                         serial_out          => uart_tx,
                         buffer_write        => write_to_uart_tx,
                         buffer_data_present => uart_tx_data_present,
                         buffer_half_full    => uart_tx_half_full,
                         buffer_full         => uart_tx_full,
                         buffer_reset        => reset,              
                         clk                 => clk );
  
  -- control flow of data through cipher engine and UART I/O
  rw_control: process(clk)
  begin
    if (clk'event and clk='1') then
      if (reset = '1') then
        write_flag        <= '0';
        write_flag2       <= '0';
        write_flag3       <= '0';
        ReadEn_8IN        <= '0';
        ReadEn_32IN       <= '0';
        WriteEn_8IN       <= '0';
        read_from_uart_rx <= '0';
        write_to_uart_tx  <= '0';
      else
        if (uart_rx_data_present = '1') then
          if (write_flag = '0') then
            write_flag        <= '1';
            read_from_uart_rx <= '0';
            WriteEn_8IN       <= '0';
          elsif (Full_8IN = '0') then
            write_flag        <= '0';
            read_from_uart_rx <= '1';
            WriteEn_8IN       <= '1';
          else
            write_flag        <= '0';
            read_from_uart_rx <= '0';
            WriteEn_8IN       <= '0';
          end if;
        else
          write_flag        <= '0';
          read_from_uart_rx <= '0';
          WriteEn_8IN       <= '0';
        end if;
      
        if (Empty_8IN = '0') then
          if (write_flag3 = '0') then
            write_flag3 <= '1';
            ENC_EN      <= '0';
            ReadEn_8IN  <= '0';
          elsif (dec_run = '0' and enc_run = '0') then
            if (ReadEn_8IN = '0') then
              ENC_EN      <= '0';
              ReadEn_8IN  <= '1';
            else
              write_flag3 <= '0';
              ENC_EN      <= '1';
              ReadEn_8IN  <= '0';
            end if;
          end if;
        else
          write_flag3 <= '0';
          ReadEn_8IN  <= '0';
          ENC_EN      <= '0';
        end if;
      
        if (uart_tx_full = '0') then
          if (Empty_32IN = '0') then
            if (write_flag2 = '0') then
              write_flag2      <= '1';
              ReadEn_32IN      <= '0';
              write_to_uart_tx <= '0';
            elsif (ReadEn_32IN = '0') then
              ReadEn_32IN      <= '1';
              write_to_uart_tx <= '0';
            else
              write_flag2 <= '0';
              ReadEn_32IN <= '0';
              write_to_uart_tx <= '1';
            end if;
          else
            write_flag2      <= '0';
            ReadEn_32IN      <= '0';
            write_to_uart_tx <= '0';
          end if;
        else
          write_flag2      <= '0';
          ReadEn_32IN      <= '0';
          write_to_uart_tx <= '0';
        end if;
      end if;
    end if;
  end process;
  
  -- sets the baud rate of the UART to 11520
  baud_rate: process(clk)
  begin
    if clk'event and clk = '1' then
      if baud_count = 53 then             -- counts 54 states including zero
        baud_count   <= 0;
        en_16_x_baud <= '1';              -- single cycle enable pulse
      else
        baud_count   <= baud_count + 1;
        en_16_x_baud <= '0';
      end if;
    end if;
  end process baud_rate;

end behavioral;
