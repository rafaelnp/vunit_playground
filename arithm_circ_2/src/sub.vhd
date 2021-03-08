
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;


entity sub is
	generic(
		N : natural := 4
	);
	port(
		i_x    : in  std_logic_vector(N-1 downto 0);
		i_y    : in  std_logic_vector(N-1 downto 0);
		o_z    : out std_logic_vector(N-1 downto 0)
	);
end entity sub;

architecture rtl of sub is
	signal s_z : std_logic_vector(N-1 downto 0);
begin

	o_z <= s_z;

	subb: process(i_x, i_y)
	begin
		s_z <= i_x - i_y;
	end process subb;

end architecture rtl;
