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
signal data : std_logic_vector(31 downto 0);
signal hit : std_logic := '0';
signal rw : std_logic := '0'; -- '0' means read, '1' means write
signal lock : std_logic_vector(3 downto 0) := "0000";
CONSTANT clk_period : TIME := 2us;
begin

Cache:
ENTITY work.Cache
port map(clk, address, data, hit, rw,lock);



-- Generate clock
clk <= not clk after 1us;




end Behavioral;

