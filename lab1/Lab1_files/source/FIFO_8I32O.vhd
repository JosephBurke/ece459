LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
 
entity FIFO_8I32O is
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
end FIFO_8I32O;
 
architecture behavioral of FIFO_8I32O is
begin
  -- Memory Pointer Process
  fifo_proc : process (CLK)
    type FIFO_Memory is array (0 to FIFO_DEPTH - 1) of STD_LOGIC_VECTOR (DATAOUT_WIDTH - 1 downto 0);
    variable Memory : FIFO_Memory;
    variable Head : natural range 0 to FIFO_DEPTH - 1;
    variable Tail : natural range 0 to FIFO_DEPTH - 1;
    variable Looped : boolean;
    variable writepos : natural range 0 to (DATAOUT_WIDTH / DATAINP_WIDTH)-1 := 0;
  begin
    if rising_edge(CLK) then
      if RST = '1' then
        Head := 0;
        Tail := 0;			
        Looped := false;
        Full  <= '0';
        Empty <= '1';
      else
        if (ReadEn = '1') then
          if ((Looped = true) or (Head /= Tail)) then
            -- Update data output
            DataOut <= Memory(Tail);

            -- Update Tail pointer as needed
            if (Tail = FIFO_DEPTH - 1) then
              Tail := 0;
              Looped := false;
            else
              Tail := Tail + 1;
            end if;
          end if;
        end if;
				
        if (WriteEn = '1') then
          if ((Looped = false) or (Head /= Tail)) then
            -- Write Data to Memory
            Memory(Head)(((writepos+1)*DATAINP_WIDTH-1) downto (writepos*DATAINP_WIDTH)) := DataIn;

            if (writepos = ((DATAOUT_WIDTH / DATAINP_WIDTH)-1)) then
              -- Increment Head pointer as needed
              if (Head = FIFO_DEPTH - 1) then
                Head := 0;
                Looped := true;
              else
                Head := Head + 1;
              end if;

              writepos := 0;
            else
              writepos := writepos + 1;
            end if;
          end if;
        end if;

        -- Update Empty and Full flags
        if (Head = Tail) then
          if Looped then
            Full <= '1';
          else
            Empty <= '1';
          end if;
        else
          Empty <= '0';
          Full  <= '0';
        end if;
      end if;
    end if;
  end process;
end behavioral;
