library ieee;
use ieee.std_logic_1164.all;

entity mux4 is
	
	port(
		a,b,c,d: in std_logic_vector(15 downto 0);  -- inputs
		sel    : in std_logic_vector(1 downto 0);   -- selector
		q      : out std_logic_vector(15 downto 0)  -- output
	);
	
end entity;

architecture mux4_arch of mux4 is
begin

	with sel select q <=
		a when "00",
		b when "01",
		c when "10",
		d when "11";

end architecture;