
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


library vunit_lib;
context vunit_lib.vunit_context;

entity mul_tb is
	generic (runner_cfg : string);
end entity mul_tb ;


architecture rtl of mul_tb is
	constant C_SIZE : natural := 16;

	signal s_x : std_logic_vector(C_SIZE-1 downto 0);
	signal s_y : std_logic_vector(C_SIZE-1 downto 0);
	signal s_z : std_logic_vector(2*C_SIZE-1 downto 0);
begin

	dut: entity work.mul(rtl)
	port map(
		i_x    => s_x,
		i_y    => s_y,
		o_z    => s_z,
		o_cout => OPEN
	);

	s_x <= (others => '0'),
		std_logic_vector(to_unsigned(729, C_SIZE)) after 5 ns,
		std_logic_vector(to_unsigned(14, C_SIZE)) after 10 ns,
		std_logic_vector(to_unsigned(322, C_SIZE)) after 20 ns,
		std_logic_vector(to_unsigned(4032, C_SIZE)) after 30 ns;

	s_y <= (others => '0'),
		std_logic_vector(to_unsigned(314, C_SIZE)) after 5 ns,
		std_logic_vector(to_unsigned(415 , C_SIZE)) after 10 ns,
		std_logic_vector(to_unsigned(322 , C_SIZE)) after 20 ns,
		std_logic_vector(to_unsigned(6129, C_SIZE)) after 30 ns;


	main: process
	begin
		test_runner_setup(runner, runner_cfg);

		wait for 6 ns;
		info("first");
		check_equal(s_z, 729 * 314);
		info(to_string(to_integer(unsigned(s_z))));

		wait for 10 ns;
		info("second");
		check_equal(s_z, 14 * 415);
		info(to_string(to_integer(unsigned(s_z))));

		test_runner_cleanup(runner);
	end process main;

end architecture rtl;
