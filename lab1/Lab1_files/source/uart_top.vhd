library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library unisim;
use unisim.vcomponents.all;

entity uart_top is
  port ( 
    clk       : in  STD_LOGIC;
    reset     : in  STD_LOGIC;
    uart_rx   : in  std_logic;
    uart_tx   : out std_logic
  );
end uart_top;

architecture behavioral of uart_top is
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
    
  signal write_flag    : std_logic;
  signal write_flag2   : std_logic;
  signal write_flag3   : std_logic;
    
  signal key_word      : std_logic_vector(63 downto 0) := x"0000000000000000";
  signal rnd           : std_logic_vector(7 downto 0); -- := x"00";
  signal ENC_EN        : std_logic;  -- pulse high to start encrypt/decrypt
  signal enc_run       : std_logic;  -- remains high during encryption cycle
  signal DONE_e        : std_logic;
  signal cipher_text   : std_logic_vector(31 downto 0);

begin
  
  rx: uart_rx6 port map (serial_in           => uart_rx,
                         en_16_x_baud        => en_16_x_baud,
                         data_out            => uart_rx_data_out,
                         buffer_read         => read_from_uart_rx,
                         buffer_data_present => uart_rx_data_present,
                         buffer_half_full    => uart_rx_half_full,
                         buffer_full         => uart_rx_full,
                         buffer_reset        => reset,              
                         clk                 => clk );
  
  tx: uart_tx6 port map (data_in             => uart_rx_data_out,
                         en_16_x_baud        => en_16_x_baud,
                         serial_out          => uart_tx,
                         buffer_write        => read_from_uart_rx,
                         buffer_data_present => uart_tx_data_present,
                         buffer_half_full    => uart_tx_half_full,
                         buffer_full         => uart_tx_full,
                         buffer_reset        => reset,              
                         clk                 => clk );
            
  read_from_uart_rx <= uart_rx_data_present and not uart_tx_full;
  
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
