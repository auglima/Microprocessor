library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
 
entity rom_memory is 
	port(
		addr  : in std_logic_vector(1 downto 0); 
		enable: in std_logic; 
		clk   : in std_logic; 

		data  : out std_logic_vector(7 downto 0)
	);
end entity; 
 
architecture rom_memory_arch of rom_memory is 
	
	type rom_array is array (0 to 3)of std_logic_vector(15 downto 0); 
	
	constant content: rom_array := (
		0 => "10000001",    -- instructions 
      others=>"11111111"
	);
	
begin
	
	process(clk)--, Read, Address)
	begin
		if rising_edge(clk) then
			if enable = '1' then
				data<= content(to_integer(unsigned(addr)));
			else
				data <= (others=>'Z');
			end if;
		end if;
	end process; 

end architecture; 
