----------------------------------------------------------------------------------
-- Company: Indian Institute of technology Delhi
-- Engineer: Shreshth Tuli
-- 
-- Create Date: 09/18/2018 09:02:42 PM
-- Design Name: 4 way set associative cache
-- Module Name: Memory - Behavioral
-- Project Name: Assignment 2 COL719

-- Revision 0.01 - File Created
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.CONV_STD_LOGIC_VECTOR;
use IEEE.NUMERIC_STD.ALL;

-- This is a 32 block, with 1 bit data memory

entity Memory is
  Port (
  clk : IN std_logic := '0';
  enable : IN std_logic := '0';
  address : IN std_logic_vector(4 downto 0) := "00000";
  read_data : OUT std_logic_vector(31 downto 0) := X"00000000";
  write_data : IN std_logic_vector(31 downto 0) := X"00000000";
  rw : IN std_logic := '0' -- '0' means read, '1' means write
  );
end Memory;

architecture Behavioral of Memory is
type arr is array(0 to 31) of STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL memory_array : arr:= (
    X"00000000", -- initialize data memory 
    X"00000000", -- mem 1
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",                     
    X"00000000",                     
    X"00000000", -- mem 10             
    X"00000000",                      
    X"00000000",                    
    X"00000000",                   
    X"00000000",                  
    X"00000000",                   
    X"00000000",                    
    X"00000000",                     
    X"00000000",                  
    X"00000000",                        
    X"00000000", -- mem 20             
    X"00000000",                        
    X"00000000",                        
    X"00000000",                        
    X"00000000", 
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000", 
    X"00000000", -- mem 30
    X"00000000");

begin

read_data <= memory_array(to_integer(unsigned(address))) when rw = '0';
memory_array(to_integer(unsigned(address))) <= write_data when rw = '1' and enable = '1';
--PROCESS(clk)
--BEGIN
--    if(clk = '1' and clk'event) then
--        if(rw = '0') then
--            data <= memory_array(to_integer(unsigned(address)));
--        elsif(rw = '1' and enable = '1') then
--            memory_array(to_integer(unsigned(address))) <= data;
--        end if;
--    end if;
--END PROCESS;

end Behavioral;
