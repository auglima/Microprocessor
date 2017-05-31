library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity alu is
	
	port(
		a, b     : in  std_logic_vector (15 downto 0);  -- duas entradas de 16bits
		op       : in  std_logic_vector (2  downto 0);  -- operaçao (+, -, <<, >>, ==, >, >=, <=) 8
		flag_eq  : out std_logic;                       -- resultado ==
		flag_gt  : out std_logic;                       -- resultado >
		flag_gte : out std_logic;                       -- resultado >=
		flag_lte : out std_logic;                       -- resultado <=
		result   : out std_logic_vector(15 downto 0)    -- resposta
	);
	
	
end entity;

architecture alu_arch of alu is
begin

	process(op, a, b)
	begin
	
		case op is
			when "000" => -- operação +
				result <= a + b;
				
			when "001" => -- operação -
				result <= a - b;
				
			when "010" => -- operação <<
				--result <= shift_left(a, 1);
				--case b is
				--	when "0000000000000001" => result <= a(0  downto 0) & "000000000000000";
				--	when "0000000000000010" => result <= a(1  downto 0) & "00000000000000";
				--	when "0000000000000011" => result <= a(2  downto 0) & "0000000000000";
				--	when "0000000000000100" => result <= a(3  downto 0) & "000000000000";
				--	when "0000000000000101" => result <= a(4  downto 0) & "00000000000";
				--	when "0000000000000110" => result <= a(5  downto 0) & "0000000000";
				--	when "0000000000000111" => result <= a(6  downto 0) & "000000000";
				--	when "0000000000001000" => result <= a(7  downto 0) & "00000000";
				--	when "0000000000001001" => result <= a(8  downto 0) & "0000000";
				--	when "0000000000001010" => result <= a(9  downto 0) & "000000";
				--	when "0000000000001011" => result <= a(10 downto 0) & "00000";
				--	when "0000000000001100" => result <= a(11 downto 0) & "0000";
				--	when "0000000000001101" => result <= a(12 downto 0) & "000";
				--	when "0000000000001110" => result <= a(13 downto 0) & "00";
				--	when others =>             result <= a(14 downto 0) & '0';
				--end case;
				
			when "011" => -- operação >>
				--result <= shift_right(a, 1);
								
			when "100" => -- operação ==
				if (a = b) then
					flag_eq <= '0';
				else
					flag_eq <= '1';
				end if;
				
			when "101" => -- operação >
				if (a > b) then
					flag_gt <= '0';
				else
					flag_gt <= '1';
				end if;
			
			when "110" => -- operação >=
				if (a >= b) then
					flag_gte <= '0';
				else
					flag_gte <= '1';
				end if;
			
			when "111" => -- operação <=
				if (a <= b) then
					flag_lte <= '0';
				else
					flag_lte <= '1';
				end if;

		end case;
		
	end process;

end architecture;