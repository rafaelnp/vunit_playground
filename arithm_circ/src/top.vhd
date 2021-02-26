
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity top is
	generic(
		N : natural := 8
	);
	port(
		i_clk  : in  std_logic;
		i_rst  : in  std_logic;
		i_en   : in  std_logic;
		i_x    : in  std_logic_vector(N-1 downto 0);
		i_y    : in  std_logic_vector(N-1 downto 0);
		o_z    : out std_logic_vector(2*N-1 downto 0);
		o_done : out std_logic
	);
end entity top;

architecture rtl of top is
	-------------
	-- user types
	-------------
	type state_t is (
		IDLE,
		MULT,
		SHIFT_16,
		DONE
	);

	------------
	-- constants
	------------


	----------
	-- signals
	----------
	signal s_state   : state_t;

	signal s_done : std_logic;

	signal s_x : std_logic_vector(N-1   downto 0);
	signal s_y : std_logic_vector(N-1   downto 0);
	signal s_z : std_logic_vector(2*N-1 downto 0);
begin

	o_done <= s_done;

	dut_mul: entity work.mul(rtl)
	port map(
		i_x    => s_x,
		i_y    => s_y,
		o_z    => s_z,
		o_cout => OPEN
	);

	calc: process(i_clk, i_rst)
	begin
		if i_rst = '1' then
			s_state <= IDLE;
		elsif rising_edge(i_clk) then
			case s_state is
				when IDLE =>
				when MULT =>
				when SHIFT_16 =>
				when DONE =>
					s_state <= IDLE;
				when others =>
					s_state <= IDLE;
			end case;
		end if;
	end process calc;

end architecture rtl;
