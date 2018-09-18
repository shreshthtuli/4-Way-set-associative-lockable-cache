----------------------------------------------------------------------------------
-- Company: Indian Institute of technology Delhi
-- Engineer: Shreshth Tuli
-- 
-- Create Date: 10/18/2018 12:11:42 AM
-- Design Name: 4 way set associative cache
-- Module Name: Cache_tb - Behavioral
-- Project Name: Assignment 2 COL719

-- Revision 0.01 - File Created
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.CONV_STD_LOGIC_VECTOR;
use IEEE.NUMERIC_STD.ALL;

entity Cache_tb is
    --Port ()
end Cache_tb;

architecture Behavioral of Cache_tb is
signal clk : std_logic := '0';
signal address : std_logic_vector(4 downto 0) := "00000";
signal read_data : std_logic_vector(31 downto 0);
signal write_data : std_logic_vector(31 downto 0);
signal hit : std_logic := '0';
signal rw : std_logic := '0'; -- '0' means read, '1' means write
signal lock : std_logic_vector(3 downto 0) := "0000";
signal stall : std_logic;
CONSTANT clk_period : TIME := 2us;
begin

Cache:
ENTITY work.Cache
port map(clk, address, read_data, write_data, hit, rw, lock, stall);


-- Generate clock
clk <= not clk after 1us;

PROCESS
BEGIN
    
    -- write 1 to address 0
    rw <= '1';
    address <= "00000";
    write_data <= X"00000001";
    lock <= "0000";
        
    wait for clk_period;
    
    -- write 2 to address 1
    rw <= '1';
    address <= "00001";
    write_data <= X"00000002";
    lock <= "0000";
    
    wait for clk_period;    
    
    -- write 3 to adress 4
    rw <= '1';
    address <= "00100";
    write_data <= X"00000003";
    lock <= "0000";
    
    wait for clk_period;
    
    -- write 4 to address 5
    rw <= '1';    
    address <= "00101";    
    write_data <= X"00000004";   
    lock <= "0000";
    
    wait for clk_period;
    
    -- read address 0 to cache set 0 - should be miss
    rw <= '0';
    address <= "00000";
    lock <= "0000";
    
    wait for 2*clk_period;
    
    -- read address 1 to cache set 1 - should be miss
    rw <= '0';
    address <= "00001";
    lock <= "0000";
    
    wait for 2*clk_period;
    
    -- read address 4 to cache set 0 - should be miss
    rw <= '0';
    address <= "00100";
    lock <= "0000";
    
    wait for 2*clk_period;
    
    -- read address 5 to cache set 1 - should be miss
    rw <= '0';
    address <= "00101";
    lock <= "0000";
    
    wait for 2*clk_period;
    
    -- read address 0 - should be hit
    rw <= '0';
    address <= "00000";
    lock <= "0000";
    
    wait for clk_period;
    
    -- read address 4 - should be hit
    rw <= '0';
    address <= "00100";
    lock <= "0000";
    
    wait for clk_period;
    
    -- read address 8 with locked - should be miss, cache does not change
    rw <= '0';
    address <= "01000";
    lock <= "0001";
    
    wait for 2*clk_period;
   
     -- read address 9 without locked - should be miss, cache changes
    rw <= '0';
    address <= "01001";
    lock <= "0001";
    
    wait for 2*clk_period;
    
    -- read address 0 - should be hit (as cache did not change)
    rw <= '0';
    address <= "00000";
    lock <= "0000";
    
    wait for clk_period;
    
    -- read address 4 - should be hit (as cache did not change)
    rw <= '0';
    address <= "00100";
    lock <= "0000";
    
    wait for clk_period;
    
    
END PROCESS;

end Behavioral;

