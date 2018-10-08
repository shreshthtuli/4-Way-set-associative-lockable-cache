----------------------------------------------------------------------------------
-- Company: Indian Institute of technology Delhi
-- Engineer: Shreshth Tuli
-- 
-- Create Date: 09/18/2018 09:02:42 PM
-- Design Name: 4 way set associative cache
-- Module Name: Cache - Behavioral
-- Project Name: Assignment 2 COL719

-- Revision 0.01 - File Created
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.CONV_STD_LOGIC_VECTOR;
use IEEE.NUMERIC_STD.ALL;

entity Cache is
    Port (
    clk : IN std_logic := '0';
    address : IN std_logic_vector(4 downto 0) := "00000";
    read_data : OUT std_logic_vector(31 downto 0):= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    write_data : IN std_logic_vector(31 downto 0):= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    hit : OUT std_logic := '0';
    rw : IN std_logic := '0'; -- '0' means read, '1' means write
    lock : IN std_logic_vector(3 downto 0);
    delay : INOUT std_logic := '0'
     );
end Cache;

architecture Behavioral of Cache is
type pair is array(1 downto 0) of STD_LOGIC_VECTOR(31 DOWNTO 0);
type set is array(3 downto 0) of pair;
type cache is array(3 downto 0) of set;
signal cache_memory : cache; -- [set number][index][1 if tag, 0 if data]

signal mem_rw : std_logic := '0';
signal enable : std_logic := '0';
signal mem_read_data : std_logic_vector(31 downto 0) := X"00000000";
signal mem_write_data : std_logic_vector(31 downto 0) := X"00000000";

signal set_num : integer;
signal tag : std_logic_vector(2 downto 0);

begin

Memory:
ENTITY work.Memory
port map(clk, enable, address, mem_read_data, mem_write_data, rw);

set_num <= to_integer(unsigned(address(1 downto 0)));
tag <= address(4 downto 2);

PROCESS(clk)
BEGIN
    if(clk = '1' and clk'event) then
        if(rw = '0') then -- read
            enable <= '0';
            if(cache_memory(set_num)(0)(1)(2 downto 0) = tag) then -- hit with match to way 1
                hit <= '1';
                read_data <= cache_memory(set_num)(0)(0);
            elsif(cache_memory(set_num)(1)(1)(2 downto 0) = tag) then -- hit with match to way 2
                hit <= '1';
                read_data <= cache_memory(set_num)(1)(0);
            elsif(cache_memory(set_num)(2)(1)(2 downto 0) = tag) then -- hit with match to way 3
                hit <= '1';
                read_data <= cache_memory(set_num)(2)(0);
            elsif(cache_memory(set_num)(3)(1)(2 downto 0) = tag) then -- hit with match to way 4
                hit <= '1';
                read_data <= cache_memory(set_num)(3)(0);
            else
                hit <= '0';
                mem_rw <= '0';
                delay <= '1';                
            end if;
        elsif(rw = '1') then -- write
            if(cache_memory(set_num)(0)(1)(2 downto 0) = tag) then -- hit with match to way 1
                hit <= '1';
                cache_memory(set_num)(0)(0) <= write_data;
            elsif(cache_memory(set_num)(1)(1)(2 downto 0) = tag) then -- hit with match to way 2
                hit <= '1';
                cache_memory(set_num)(1)(0) <= write_data;
            elsif(cache_memory(set_num)(2)(1)(2 downto 0) = tag) then -- hit with match to way 3
                hit <= '1';
                cache_memory(set_num)(2)(0) <= write_data;
            elsif(cache_memory(set_num)(3)(1)(2 downto 0) = tag) then -- hit with match to way 4
                hit <= '1';
                cache_memory(set_num)(3)(0) <= write_data;
            else  -- miss
                hit <= '0';
            end if;
            enable <= '1';
            mem_rw <= '1';
            mem_write_data <= write_data;
        else
            enable <= '0';
        end if;
        
        if(delay = '1') then
            read_data <= mem_read_data;
            for k in 0 to 3 loop
                if(lock(k) = '0') then
                    -- update cache with first found
                    cache_memory(set_num)(k)(0) <= mem_read_data; -- update block 1
                    cache_memory(set_num)(k)(1)(2 downto 0) <= tag;
                    cache_memory(set_num)(k)(1)(31 downto 3) <= "00000000000000000000000000000";
                    exit;
                end if;
            end loop;
            delay <= '0';
        end if;
    end if;
    
END PROCESS;

end Behavioral;
