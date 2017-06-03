library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity adder is
	port(
		a, b: in std_logic_vector(15 downto 0);
		q   : out std_logic_vector(15 downto 0)
	);
end entity;

architecture adder_arch of adder is
begin

	q <= a + b;
	
end architecture;