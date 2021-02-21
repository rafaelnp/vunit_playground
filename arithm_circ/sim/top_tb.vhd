
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


library vunit_lib;
context vunit_lib.vunit_context;

entity top_tb is
	generic (runner_cfg : string);
end entity top_tb;


architecture rtl of top_tb is
begin

	main: process
	begin
		test_runner_setup(runner, runner_cfg);
		test_runner_cleanup(runner);
	end process main;

end architecture rtl;

