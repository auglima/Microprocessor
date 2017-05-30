library ieee;
use ieee.std_logic_1164.all;

entity control_unit is
	port(
		-- to do
		reset: in std_logic;
		clk:   in std_logic;
	);
end entity;

architecture control_unit_arch of control_unit is
	
	type state_type is (estado1, estado2, estado3) -- coloque nomes para representar cada estado
	signal state: state_type;
begin

	-- muda os estados
	process(clk, reset)
	begin
		
		if reset = '1' then

			state <= estado1; -- volta para o primeiro estado

		elsif rising_edge(clk)
		
			case state is
				when estado1 =>
					--if lalala =1
					--	   state <= estado3
				
				... 
				
			end case;
		
		end if;
	
	end process;


	
	-- define as saidas
	process(state)
	begin
		case state is
			when state =>
				--saidas
			,,,
			
		end case;	
	end process;	

end architecture;
	