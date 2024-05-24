library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity COEN313Project_tb is
    
end entity COEN313Project_tb;

ARCHITECTURE tbarch of COEN313Project_tb IS

    component COEN313Project is
        Port (
            x: in  std_logic;
            y: in std_logic;
            reset: in std_logic;
            clk : in std_logic;
            z : out std_logic;
            current_occupancy: out std_logic_vector (5 downto 0)
        );
    end component;
    
    CONSTANT max_simulation_time : TIME := 720 ps;
    CONSTANT clk_period          : TIME := 10 ps;
    
    signal x: std_logic :='0';
    signal y: std_logic :='0';
    signal reset: std_logic :='0';
    signal clk: std_logic :='0';
    signal z: std_logic :='0';
    signal current_occupancy: std_logic_vector (5 downto 0);
    
    
    
begin
    PROJECT : COEN313Project port map (
        x => x,
        y => y,
        reset => reset,
        clk => clk,
        z => z,
        current_occupancy => current_occupancy);
    
    clk_gen: PROCESS
    VARIABLE sim_time : TIME;
    BEGIN
        sim_time := 0 ps;
        WHILE sim_time <=  max_simulation_time LOOP
            clk <= '0';
            WAIT FOR 5 ps;
            clk <= '1';
            WAIT FOR 5 ps;
            sim_time := sim_time + clk_period;
        END LOOP;
        WAIT;
    END PROCESS;
    
    
    input_process: process
    begin
        reset<= '1'; wait for 20 ps;
        reset<= '0'; wait for 20 ps;
        x <= '0'; y <= '0'; wait for 10 ps;
        x <= '1'; y <= '0'; wait for 10 ps;
        x <= '0'; y <= '1'; wait for 10 ps;
        x <= '1'; y <= '0'; wait for 10 ps;
        x <= '0'; y <= '1'; wait for 10 ps;
        x <= '1'; y <= '0'; wait for 10 ps;
        x <= '1'; y <= '0'; wait for 10 ps;
        wait;
    end process;
END tbarch;