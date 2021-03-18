
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;



entity mul is
	generic(
		N : natural := 4
	);
	port(
		i_x    : in  std_logic_vector(N-1 downto 0);
		i_y    : in  std_logic_vector(N-1 downto 0);
		o_z    : out std_logic_vector(2*N-1 downto 0);
		o_cout : out  std_logic
	);
end entity mul;

architecture rtl of mul is
	constant C_ZERO : std_logic_vector(N-1 downto 0) := (others => '0');
begin
	multi: process(i_x, i_y)
		variable pv : std_logic_vector(2*N-1 downto 0) := (others => '0');
		variable bp : std_logic_vector(2*N-1 downto 0) := (others => '0');
	begin
		bp := C_ZERO & i_y;
		pv := (others => '0');

		for i in 0 to N-1 loop
			if i_x(i) ='1' then
				pv := pv + bp;
			end if;

			bp := bp(2*N-2 downto 0) & '0';
		end loop;

		o_z <= pv;
	end process multi;

end architecture rtl;
