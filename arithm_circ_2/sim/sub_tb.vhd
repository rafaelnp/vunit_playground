library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;


library vunit_lib;
context vunit_lib.vunit_context;

entity sub_tb is
	generic (runner_cfg : string);
end entity sub_tb;


architecture rtl of sub_tb is
	constant C_SIZE : natural := 16;

	signal s_x, s_y, s_z: std_logic_vector(C_SIZE-1 downto 0);
begin

	dut: entity work.sub(rtl)
	generic map(
		N => C_SIZE
	)
	port map(
		i_x    => s_x,
		i_y    => s_y,
		o_z    => s_z
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

		wait for 7 ns;
		info("first");
		check_equal(signed(s_z), 729 - 314);
		info(to_string(to_integer(signed(s_z))));

		wait for 10 ns;

		info("second");
		--check_equal(to_integer(s_z), to_integer(14 - 415));
		check_equal(signed(s_z), -401);
		--check_equal(to_integer(signed(s_z)), to_integer(signed(14 - 415)));
		info(to_string(to_integer(signed(s_z))));

		wait for 10 ns;

		info("third");
		check_equal(s_z, 322 - 322);
		info(to_string(to_integer(unsigned(s_z))));

		wait for 20 ns;

		info("fourth");
		check_equal(signed(s_z), 4032 - 6129);
		info(to_string(to_integer(signed(s_z))));

		test_runner_cleanup(runner);
	end process main;

end architecture rtl;

