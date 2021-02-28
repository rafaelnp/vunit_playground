
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;



entity mul is
	port(
		i_x    : in  std_logic_vector(15 downto 0);
		i_y    : in  std_logic_vector(15 downto 0);
		--o_done : out std_logic;
		o_z    : out std_logic_vector(31 downto 0);
		o_done : out  std_logic
	);
end entity mul;

architecture rtl of mul is
	signal s_i : natural;
begin
	
	o_done <= '1' when s_i = 15 else '0';

	multi: process(i_x, i_y)
		variable pv : std_logic_vector(31 downto 0) := (others => '0');
		variable bp : std_logic_vector(31 downto 0) := (others => '0');
	begin
		bp := X"0000" & i_y;
		pv := (others => '0');

		for i in 0 to 15 loop
			if i_x(i) ='1' then
				pv := pv + bp;
			end if;
			s_i <= i;
			bp := bp(30 downto 0) & '0';
		end loop;

		o_z <= pv;
	end process multi;

end architecture rtl;
