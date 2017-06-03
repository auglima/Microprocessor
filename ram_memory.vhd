library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_memory is

    port (
        clk    : in std_logic;
        enable : in std_logic;
        addr   : in std_logic_vector(6 - 1 downto 0);
        data_i : in std_logic_vector(16 - 1 downto 0);
        data_o : out std_logic_vector(16 - 1 downto 0)
    );

end entity;

architecture ram_memory_arch of ram_memory is
    type ram_t is array (0 to 2**6-1) of std_logic_vector(16 - 1 downto 0);

    signal ram_image : ram_t := (
        others => "0000000000000000"
    );
begin
    process (clk)
    begin
        if rising_edge(clk) then
            data_o <= ram_image(to_integer(unsigned(addr)));

            if enable='1' then
                ram_image(to_integer(unsigned(addr))) <= data_i;
            end if;
        end if;
    end process;
end architecture;
