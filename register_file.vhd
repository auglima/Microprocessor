library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is

	port(
		data  : in  std_logic_vector(15 downto 0);
		 
		addr_a: in  std_logic_vector(2 downto 0);
		addr_b: in  std_logic_vector(2 downto 0);
		addr_w: in  std_logic_vector(2 downto 0);
		
		out_a : out std_logic_vector(15 downto 0);
		out_b : out std_logic_vector(15 downto 0);
		
		enable: in  std_logic;
		clk   : in  std_logic
	);
	
end entity;

architecture register_file_arch of register_file is

	type register_array is array(0 to 7) of std_logic_vector(15 downto 0);
	signal registers: register_array;

begin

	process(clk) is
	begin
		if rising_edge(clk) then 
			out_a <= registers(to_integer(unsigned(addr_a)));
			out_b <= registers(to_integer(unsigned(addr_b)));
			
			if enable = '1' then
				registers(to_integer(unsigned(addr_w))) <= data;
			end if;
		end if;
	end process;
	
end architecture;
	