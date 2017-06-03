library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity alu is
	
	port(
		a, b     : in  std_logic_vector (15 downto 0);  -- inputs 16 bits 
		op       : in  std_logic_vector (3  downto 0);  -- 9 operators (+, -, <<, >>, ==, >, >=, <. <=)
		flag_eq  : out std_logic;                       -- 	ado ==
		flag_gt  : out std_logic;                       -- 	ado >
		flag_gte : out std_logic;                       -- 	ado >=
		flag_lt  : out std_logic;                       -- 	ado >
		flag_lte : out std_logic;                       -- 	ado <=
		r        : out std_logic_vector(15 downto 0)    -- resposta
	);
	
end entity;

architecture alu_arch of alu is
begin

	process(op, a, b)
	begin
	
	
		case op is
			when "0000" => -- operação +
				--r <= a + b;
				
			when "0001" => -- operação -
				--r <= a - b;
				
			when "0010" => -- operação <<
				
				--r <= to_stdlogicvector(to_bitvector(a) sra to_integer(unsigned(b)));
				
			when "0011" => -- operação >>
				--r <= to_stdlogicvector(to_bitvector(a) srl to_integer(unsigned(b)));
								
			when "0100" => -- operação ==
				if (a = b) then
					flag_eq <= '0';
				else
					flag_eq <= '1';
				end if;
				
			when "0101" => -- operação >
				if (a > b) then
					flag_gt <= '0';
				else
					flag_gt <= '1';
				end if;
			
			when "0110" => -- operação >=
				if (a >= b) then
					flag_gte <= '0';
				else
					flag_gte <= '1';
				end if;
			
			when "0111" => -- operação <
				if (a <= b) then
					flag_lt <= '0';
				else
					flag_lt <= '1';
				end if;
			
			when "1000" => -- operação <=
				if (a <= b) then
					flag_lte <= '0';
				else
					flag_lte <= '1';
				end if;
				
			when others =>

		end case;
		
	end process;

end architecture;