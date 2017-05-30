library ieee;
use ieee.std_logic_1164.all;

entity mux2 is
	
	port(
		a, b: in std_logic_vector(15 downto 0);  -- inputs
		sel : in std_logic;                      -- selector
		q   : out std_logic_vector(15 downto 0)  -- output
	);
	
end entity;

architecture mux2_arch of mux2 is
begin

	q <= a when (sel = '0') else b;

end architecture;