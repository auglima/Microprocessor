library ieee;
use ieee.std_logic_1164.all;

entity register16 is

	port(
		d     : in  std_logic_vector(15 downto 0); -- input
		load  : in  std_logic;							  -- write enable
		clear : in  std_logic;                      -- clear
		clk   : in  std_logic;                      -- clock
		q     : out std_logic_vector(15 downto 0)  -- ouput
	);
	
end entity;

architecture register16_arch of register16 is
begin
	
	process(clk, clear) is
	begin
	
		if clear = '1' then
			q <= (others => '0');
		elsif rising_edge(clk) then
			if load = '1' then
				q <= d;
			end if;
		end if;
		
	end process;
	
end architecture;