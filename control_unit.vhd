library ieee;
use ieee.std_logic_1164.all;

entity control_unit is
	port(			
		pc_select      : out std_logic;
		constant_v     : out std_logic_vector(15 downto 0);
		rf_enable: out std_logic; 
		addr_a: out std_logic_vector(2 downto 0);
		addr_b: out std_logic_vector(2 downto 0);
		addr_w: out std_logic_vector(2 downto 0);
		rf_mux: out std_logic;
		ula_op: out std_logic_vector(2 downto 0);
		constant_select: out std_logic_vector(1 downto 0);		
		load_pc: out std_logic;
		clear_pc: out std_logic;
		load_ar: out std_logic;
		store_load_mux: out std_logic;
		load_ir: out std_logic;
		load_dr_out: out std_logic;
		load_dr_in: out std_logic;
		flag_eq: in std_logic;
		flag_gt: in std_logic;
		flag_gte: in std_logic;
		flag_lte: in std_logic;
		ir: in std_logic_vector(15 downto 0);	
		reset: in std_logic;
		clk  : in std_logic
	);
end entity;

architecture control_unit_arch of control_unit is
	
	type state_type is (START, SEARCH, DECODE, JUMPEQ, JUMPNEQ, JUMPGT, JUMPGTE, JUMPLT, JUMPLTE, JUMP, ADD, SUB, ADDI, SUBI, SHFL, SHFR, ST, LD, NOP, PC, PCK);
	signal state: state_type;
	
begin

	-- CHANGE STATE
	process(clk, reset, ir, flag_eq, flag_gt, flag_gte, flag_lte)
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
					case ir(15 downto 12) is
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
						state <= PC;
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

				when PC =>
					state <= SEARCH;

				when PCK =>
					state <= SEARCH;
					
			end case;
			
		end if;	
	end process;
	
	
	
	-- SET OUTPUTS
	process(state)
	begin
		case state is
			when START =>
				clear_pc <= '1';   -- resetar memoria, best way?
				
			when SEARCH =>
				load_ar    <= '1'; -- endereçar memoria
				load_dr_in <= '1'; -- receber dado da memoria rom
				load_ir    <= '1'; -- colocar instrução em IR
				
			when DECODE =>
					-- ver o arquivo instruction_project.pdf
					case ir(15 downto 12) is
					
						when "0000" => -- NOP
							-- não faz nada

						when "0001"|"0010"|"0011"|"0100"|"0101"|"0110" => -- JUMPXX
							addr_a     <= ir(11 downto 9);
							addr_b     <= ir(8 downto 6);
							constant_v <= "0000000000" & ir(5 downto 0);
							
						when "0111" => -- JUMP
							constant_v <= "0000" & ir(11 downto 0);
						
						when "1000"|"1001" => -- ADD SUB
							addr_a  <= ir(11 downto 9);
							addr_b  <= ir(8 downto 6);
							addr_w  <= ir(5 downto 3);
						
						when "1010"|"1011"|"1100"|"1101" => -- ADDI SUBI SHFL SHFR
							addr_a     <= ir(11 downto 9);
							addr_b     <= ir(8 downto 6);
							constant_v <= "0000000000" & ir(5 downto 0);
						
						when "1110" => -- ST
							addr_a     <= ir(11 downto 9);
							addr_b     <= ir(8 downto 6);
						
						when "1111" => -- LD
							addr_w     <= ir(11 downto 9);
							addr_b     <= ir(8 downto 6);
					end case;
			
			when JUMPEQ =>
				pc_select       <= '1';   -- ULA recebe A   isso poderia ir em decode????
				constant_select <= "01";  -- ULA recebe B
				ula_op <= "100";
			
			when JUMPNEQ =>
				pc_select       <= '1';   -- ULA recebe A   isso poderia ir em decode????
				constant_select <= "01";  -- ULA recebe B
				ula_op <= "100";
			
			when JUMPGT =>
				pc_select       <= '1';   -- ULA recebe A   isso poderia ir em decode????
				constant_select <= "01";  -- ULA recebe B
				ula_op <= "101";
			
			when JUMPGTE =>
				pc_select       <= '1';   -- ULA recebe A   isso poderia ir em decode????
				constant_select <= "01";  -- ULA recebe B
				ula_op <= "110";
			
			when JUMPLT=>
				pc_select       <= '1';   -- ULA recebe A   isso poderia ir em decode????
				constant_select <= "01";  -- ULA recebe B
				ula_op <= "101";
			
			when JUMPLTE =>
				pc_select       <= '1';   -- ULA recebe A   isso poderia ir em decode????
				constant_select <= "01";  -- ULA recebe B
				ula_op <= "111";
			
			when JUMP =>
				constant_select <= "00";  -- ULA recebe CONSTANTE
				
			when ADD =>
				pc_select       <= '1';   -- ULA recebe A
				constant_select <= "01";  -- ULA recebe B
				rf_enable <= '1';         -- Habilita escrita nos regs
				rf_mux <= '1';           -- dado direto da ula
				ula_op <= "000";
				
			when SUB =>
				pc_select       <= '1';   -- ULA recebe A
				constant_select <= "01";  -- ULA recebe B
				rf_enable <= '1';         -- Habilita escrita nos regs
				rf_mux <= '1';           -- dado direto da ula
				ula_op <= "001";
				
			when ADDI =>
				pc_select       <= '1';   -- ULA recebe A
				constant_select <= "00";  -- ULA recebe Constante
				rf_enable <= '1';         -- Habilita escrita nos regs
				rf_mux <= '1';           -- dado direto da ula
				ula_op <= "000";
				
			when SUBI =>
				pc_select       <= '1';   -- ULA recebe A
				constant_select <= "00";  -- ULA recebe Constante
				rf_enable <= '1';         -- Habilita escrita nos regs
				rf_mux <= '1';           -- dado direto da ula
				ula_op <= "001";

			when SHFL =>
				pc_select       <= '1';   -- ULA recebe A
				constant_select <= "00";  -- ULA recebe Constante
				rf_enable <= '1';         -- Habilita escrita nos regs
				rf_mux <= '1';           -- dado direto da ula
				ula_op <= "010";

			when SHFR =>
				pc_select       <= '1';   -- ULA recebe A
				constant_select <= "00";  -- ULA recebe Constante
				rf_enable <= '1';         -- Habilita escrita nos regs
				rf_mux <= '1';           -- dado direto da ula
				ula_op <= "011";

			when ST =>
				pc_select       <= '1';   -- ULA recebe A: dado
				constant_select <= "01";  -- ULA recebe B: addr
				store_load_mux  <= '0';   -- AR <= B
				load_dr_out <= '1';       -- habilita saida de dados
				load_ar <= '1';           -- habilita saida de addrs
				
			when LD =>
				constant_select <= "01";  -- ULA recebe B: addr
				store_load_mux  <= '0';   -- AR <= B
				rf_enable <= '1';         -- habilita escrita
				load_ar <= '1';           -- habilita saida de addrs
				load_dr_in <= '1';       -- habilita entrada de dados
				rf_mux <= '0';           -- dado direto da memrio
			
			when NOP =>
				-- nao faz nada
				
			when PC =>
				store_load_mux  <= '1';  --- AR <= PC
				pc_select       <= '0'; -- ULA recebe PC
				constant_select <= "10";  -- ULA recebe 1 : PC+=1
				
			when PCK =>				
				store_load_mux  <= '1';  --- AR <= PC
				pc_select       <= '0'; -- ULA recebe PC
				constant_select <= "00";  -- ULA recebe 1 : PC+=K
				
		end case;
	end process;
end architecture;
	