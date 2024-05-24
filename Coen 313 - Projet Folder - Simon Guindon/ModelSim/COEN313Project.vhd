library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity COEN313Project is
    port(
        x: in  std_logic;
        y: in std_logic;
        reset: in std_logic;
        clk : in std_logic;
        z : out std_logic;
        current_occupancy: out std_logic_vector (5 downto 0)
    );
end entity COEN313Project;

architecture arch of COEN313Project is
    signal r_reg: unsigned(5 downto 0); -- max at 0111111 = 63 in unsigned, will trigger z at 0111111 (63)
    signal r_next: unsigned(5 downto 0);
  
begin
    --current state logic
    process(clk,reset) -- updating the occupancy in the register
    begin
        if (reset = '1') then r_reg <= (others=>'0');
        elsif (clk'event and clk = '1') then r_reg <= r_next;
        end if;
    end process;
--next state logic
    r_next <= (others =>'0') when reset='1' else
        r_reg + 1      when x='1' else
        r_reg - 1      when y='1' else
        r_reg;

--output logic
        
        z <= '1' when (r_reg="111111") else '0';
        current_occupancy <= std_logic_vector(r_reg);
        
    end architecture arch;