library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
 
entity rom_memory is 
	port(
		addr  : in std_logic_vector(15 downto 0); 
		clk   : in std_logic; 

		data  : out std_logic_vector(15 downto 0)
	);
end entity; 
 
architecture rom_memory_arch of rom_memory is 
	
	type rom_array is array (0 to 15)of std_logic_vector(15 downto 0); 
	
	constant content: rom_array := (
		0 => "0000000000000001",    -- instructions 
      others=>"1111111111111111"
	);
	
begin
	
	process(clk)
	begin
	
		if rising_edge(clk) then
			data <= content(to_integer(unsigned(addr)));
		end if;
	
	end process;
	
	--process(clk)--, Read, Address)
	--begin
	--	if rising_edge(clk) then
	--		if enable = '1' then
	--			data<= content(to_integer(unsigned(addr)));
	--		else
	--			data <= (others=>'Z');
	--		end if;
	--	end if;
	--end process;
	

end architecture; 
