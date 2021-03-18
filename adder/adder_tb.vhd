
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity carry_ripple_adder_tb is
	generic (runner_cfg : string);
end carry_ripple_adder_tb;

architecture rtl of carry_ripple_adder_tb is
	constant N : natural := 8;
	signal s_x : std_logic_vector(N-1 downto 0);
	signal s_y : std_logic_vector(N-1 downto 0);
	signal s_s : std_logic_vector(N-1 downto 0);
begin

	cra: entity work.carry_ripple_adder(rtl)
	generic map(
		N => N
	)
	port map(
		a  => s_x,
		b  => s_y,
		cin => '0',
		s   => s_s,
		cout => OPEN
	);

	main: process
	begin
		test_runner_setup(runner, runner_cfg);
		--s_bin <= X"000";
		s_x <= X"0F";
		s_y <= X"0F";
		wait for 100 ns;
		--check_equal(s_s, 30);
		check(s_s = X"1E");

		s_x <= X"1F";
		s_y <= X"2F";
		wait for 100 ns;
		check(s_s = X"4E");
		test_runner_cleanup(runner);
	end process main;
end architecture rtl;

