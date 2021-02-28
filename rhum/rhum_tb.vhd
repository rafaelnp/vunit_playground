--
--
--
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


library vunit_lib;
context vunit_lib.vunit_context;

entity rhum_tb is
	generic (runner_cfg : string);
end entity rhum_tb;

architecture rtl of rhum_tb is
	constant C_SIZE : natural := 16;

	signal s_data_in  : std_logic_vector(C_SIZE - 1 downto 0);
	signal s_data_out : std_logic_vector(C_SIZE - 1 downto 0);
begin

	proc_data: entity work.rhum(rtl)
	generic map (
		N => C_SIZE
	)
	port map(
		i_data => s_data_in,
		o_data => s_data_out
	);

	main: process
	begin
		test_runner_setup(runner, runner_cfg);

		s_data_in <= X"0000";
		wait for  100 ns;
		s_data_in <=  X"8500";
		wait on s_data_out;
		check_equal(s_data_out, 51, "result should be 51 (0x33)");
		info("Hello world");
		s_data_in <= X"0000";
		wait for  100 ns;
		s_data_in <=  X"E500";
		wait on s_data_out;
		check_equal(s_data_out, 89, "result should be 89 (0x59)");
		test_runner_cleanup(runner);
	end process main;
end architecture;
