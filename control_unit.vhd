library ieee;
use ieee.std_logic_1164.all;

entity control_unit is
	port(			
		load_dr_out    : out std_logic;
		select_rf      : out std_logic;
		rf_enable      : out std_logic; 
		select_constant: out std_logic;		
		ula_op         : out std_logic_vector(3 downto 0);
		load_ir        : out std_logic;
		load_ir2       : out std_logic;
		load_ar        : out std_logic;
		select_pc      : out std_logic;
		select_ar      : out std_logic;
		load_pc        : out std_logic;
		clear_pc       : out std_logic;
		load_dr_in     : out std_logic;
		
		flag_eq : in std_logic;
		flag_gt : in std_logic;
		flag_gte: in std_logic;
		flag_lt : in std_logic;
		flag_lte: in std_logic;	
		ir_op   : in std_logic_vector(3 downto 0);
		
		reset: in std_logic;
		clk  : in std_logic
	);
end entity;

architecture control_unit_arch of control_unit is
	
	type state_type is (START, SEARCH, DECODE, JUMPEQ, JUMPNEQ, JUMPGT, JUMPGTE, JUMPLT, JUMPLTE, JUMP, ADD, SUB, ADDI, SUBI, SHFL, SHFR, ST, LD, NOP, WB, EXTEND, EXTEND2);
	signal state: state_type;
	
begin

	-- CHANGE STATE
	process(clk, reset, ir, flag_eq, flag_gt, flag_gte, flag_lt, flag_lte)
	begin
	
		if reset='1' then
			state <= START;
		elsif rising_edge(clk) then
			case state is
				when START =>
					state <= SEARCH;	
					
				when SEARCH =>
					state <= DECODE;
					
				when DECODE =>
					-- ver o arquivo instruction_project.pdf
					case ir_op is
						when "0000" => state <= NOP;
						when "0001" => state <= JUMPEQ;
						when "0010" => state <= JUMPNEQ;
						when "0011" => state <= JUMPGT;
						when "0100" => state <= JUMPGTE;
						when "0101" => state <= JUMPLT;
						when "0110" => state <= JUMPLTE;
						when "0111" => state <= JUMP;
						when "1000" => state <= ADD;
						when "1001" => state <= SUB;
						when "1010" => state <= ADDI;
						when "1011" => state <= SUBI;
						when "1100" => state <= SHFL;
						when "1101" => state <= SHFR;
						when "1110" => state <= ST;
						when "1111" => state <= LD;
					end case;
				
				when JUMPEQ =>
					if flag_eq = '0' then
						state <= SEARCH;
					else
						state <= PCK;
					end if;
					
				when JUMPNEQ =>
					if flag_eq = '1' then
						state <= PC;
					else
						state <= PCK;
					end if;
					
				when JUMPGT =>
					if flag_gt = '0' then
						state <= PC;
					else
						state <= PCK;
					end if;

				when JUMPGTE =>
					if flag_gte = '0' then
						state <= PC;
					else
						state <= PCK;
					end if;
					
				when JUMPLT =>
					if flag_gt = '1' then
						state <= PC;
					else
						state <= PCK;
					end if;
					
				when JUMPLTE =>
					if flag_lte = '0' then
						state <= PC;
					else
						state <= PCK;
					end if;
					
				when JUMP =>
					state <= PCK;
				
				when ADD =>
					state <= PC;
					
				when SUB =>
					state <= PC;
				
				when ADDI =>
					state <= PC;
					
				when SUBI =>
					state <= PC;

				when SHFL =>
					state <= PC;
				
				when SHFR =>
					state <= PC;
	
				when ST =>
					state <= PC;

				when LD =>
					state <= PC;
					
				when NOP =>
					state <= PC;

				when EXTEND =>
					state <= SEARCH;

				when PCK =>
					state <= SEARCH;
					
			end case;
			
		end if;	
	end process;
	
	
	
	
	
	
	
	
	
	----------------------------------------------------------------------------------------------------------------------------
	-- SET OUTPUTS  ------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------
	process(state)
	begin
		case state is
			when START =>
				clear_pc <= '1';  -- zerar endereço
			
			
			
			when SEARCH =>
				-- limpar saida anterior
				clear_pc   <= '0';
				-- novas saidas
				select_ar  <= '1'; -- seleciona a saída de PC
				load_ar    <= '1'; -- escrita em AR
				load_dr_in <= '1'; -- escrita #m em dr_ir
				load_ir    <= '1'; -- escrita em IR
					
				
				
			when DECODE =>
				select_pc <= '1'; -- seleciona PC+1
				load_pc   <= '1'; -- escrita PC=PC+1
				
			
			when JUMPEQ =>
				ula_op          <= "0100 "; -- operação ==
				
						
			when JUMPNEQ =>
				ula_op          <= "0100"; -- operação !=
			
			when JUMPGT =>
				ula_op          <= "0101"; -- operação >
			
			when JUMPGTE =>
				ula_op          <= "0110"; -- operação >=
			
			when JUMPLT=>
				ula_op          <= "0111"; -- operação <
			
			when JUMPLTE =>
				ula_op          <= "1000"; -- operação <=
			
			when JUMP =>
				-- limpar saida anterior				
				-- novas saidas			
			
			
			
			when ADD =>
				-- limpar saida anterior				
				-- novas saidas
				select_constant <= '0';    -- ULA recebe B
				ula_op          <= "0000"; -- operação de soma
				select_rf       <= '0';    -- RF recebe valor da ULA
				rf_enable       <= '1';    -- escrita em RF
				
				
				
			when SUB =>
				-- limpar saida anterior				
				-- novas saidas
				select_constant <= '0';    -- ULA recebe B
				ula_op          <= "0001"; -- operação de subtração
				select_rf       <= '0';    -- RF recebe valor da ULA
				rf_enable       <= '1';    -- escrita em RF
								
				
				
			when ADDI =>
				
				
			when SUBI =>
				

			when SHFL =>
				

			when SHFR =>
				

			when ST =>
				-- limpar saida anterior				
				-- novas saidas
				select_ar  <= '0'; -- seleciona a saída #m em B
				load_ar    <= '1'; -- escrita em AR
				load_dr_out<= '1'; -- escrita dr_out em #m
				
				
				
			when LD =>
				-- limpar saida anterior				
				-- novas saidas
				select_ar  <= '0'; -- seleciona a saída #m em B
				load_ar    <= '1'; -- escrita em AR
				load_dr_in <= '1'; -- escrita #m em dr_in
				select_rf  <= '1'; -- RF recebe DR
				rf_enable  <= '1'; -- escrita em RF
				
			
			
			when NOP =>
				-- nao faz nada
			
			
			
			when EXTEND =>
				-- limpar saida anterior				
				-- novas saidas
				select_ar <= '1'; -- seleciona a saída de PC
				load_ar   <= '1'; -- escrita em AR
				load_dr_in<= '1'; -- escrita #m em dr_ir
				load_ir2  <= '1'; -- escrita em IR2
			
			
			
			when EXTEND2 =>
				-- limpar saida anterior				
				load_ar   <= '0'; -- escrita em AR
				load_dr_in<= '0'; -- escrita #m em dr_ir
				load_ir2  <= '0'; -- escrita em IR2
				-- novas saidas
				select_pc <= '1'; -- seleciona PC+1
				load_pc   <= '1'; -- escrita PC=PC+1
			
		end case;
	end process;
end architecture;
	