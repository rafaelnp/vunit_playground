--
--
--
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


library vunit_lib;
context vunit_lib.vunit_context;

entity multple_testcase_tb is
	generic (runner_cfg : string);
end multple_testcase_tb;

architecture rtl of multple_testcase_tb is
	signal test_done : boolean;
	signal test_1 : integer := 11;
	signal test_4 : integer := 20;
begin
	test_done <= false;

	test_runner : process
	begin
		test_runner_setup(runner, runner_cfg);

		while test_suite loop
			if run("test_1") then
				check_equal(test_1, 11);
				info("ooooo");
			elsif run("test_2") then
				--wait on test_done;
				info("testcase finished");
			elsif run("test_3") then
				wait for 10 us;
			elsif run("test_4") then
				check_false(test_4 = 25);
			end if;
		end loop;

		test_runner_cleanup(runner);
	end process test_runner;
end architecture;
