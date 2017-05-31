library ieee;
use ieee.std_logic_1164.all;

entity register16_bidir is

	port(
		data    : inout std_logic_vector(15 downto 0);  -- bidirectional input
		data_in : in    std_logic_vector(15 downto 0);  -- input
		data_out: out   std_logic_vector(15 downto 0);  -- input
		load    : in    std_logic;							   -- write enable
		clk     : in    std_logic                       -- clock
	
	);
	
end entity;

architecture register16_bidir_arch of register16_bidir is
	signal a: std_logic_vector(15 downto 0);
	signal b: std_logic_vector(15 downto 0);
begin
	
	
	
end architecture;