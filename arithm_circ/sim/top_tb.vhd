
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


library vunit_lib;
context vunit_lib.vunit_context;

entity top_tb is
	generic (runner_cfg : string);
end entity top_tb;


architecture rtl of top_tb is
	constant C_SIZE : natural := 16;

	signal s_clk  : std_logic;
	signal s_rst  : std_logic;
	signal s_en   : std_logic;
	signal s_done_tb : std_logic;
	signal s_raw  : std_logic_vector(C_SIZE-1 downto 0);
	signal s_res_tb  : std_logic_vector(C_SIZE-1 downto 0);
begin

	clk_gen: process
	begin
		s_clk <= '0';
		wait for 5 ns;
		s_clk <= '1';
		wait for 5 ns;
	end process clk_gen;

	dut: entity work.top(rtl)
		generic map(
			N => C_SIZE
		)
		port map(
			i_clk  => s_clk,
			i_rst  => s_rst,
			i_en   => s_en,
			i_raw  => s_raw,
			o_res  => s_res_tb,
			o_done => s_done_tb
		);

	main: process
	begin
		test_runner_setup(runner, runner_cfg);
		s_rst <= '1';
		s_en  <= '0';
		s_raw <= X"8500";
		wait for 20 ns;
		s_rst <= '0';
		wait for 20 ns;
		s_en  <= '1';

		--wait for 10 ns;
		wait until s_done_tb = '1';
		--wait for 20 ns;
		check_equal(s_res_tb, 52);
		test_runner_cleanup(runner);
	end process main;

end architecture rtl;

