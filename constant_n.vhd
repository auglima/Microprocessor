library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity constant_n is
	generic (
		len : integer := 16;
		num : integer := 1
	);
	port(
		q     : out std_logic_vector(len-1 downto 0)  -- ouput
	);
	
end entity;

architecture constant_n_arch of constant_n is
begin
	
	q <= std_logic_vector(to_unsigned(num, len));
	
end architecture;