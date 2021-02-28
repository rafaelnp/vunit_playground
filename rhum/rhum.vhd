library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--
-- !Simple entity without additional modules
--
entity rhum is
	generic(
		N : natural := 8
	);
	port(
		i_clk  : in  std_logic;
		i_rst  : in  std_logic;
		i_en   : in  std_logic;
		i_raw  : in  std_logic_vector(N-1 downto 0);
		o_res  : out std_logic_vector(N-1 downto 0);
		o_done : out std_logic
	);
end rhum;

architecture rtl of rhum is
	-------------
	--! user types
	-------------
	type state_t is (
		IDLE,
		LOAD,
		MULT,
		SHIFT_16,
		DONE
	);

	------------
	--! constants
	------------
	-- constant 100
	constant C_MULT_100 : std_logic_vector(N-1 downto 0) := X"0064";
	----------------------
	--! user defined types
	----------------------

	----------
	-- signals
	----------
	signal s_state   : state_t;

	signal s_done : std_logic;
	signal s_res : std_logic_vector(N-1 downto 0);

	-- multiplication
	signal s_mul   : std_logic_vector(N-1 downto 0);
begin
	--! implement  RM% = (RH_RAW * 100) / 2^16;

	--! Multiplier
	--! input: 16-bits
	--! ouput: 32-bits
	mult : entity work.mul
		port map(
			i_x    => i_raw,
			i_y    => C_MULT_100,
			o_z    => s_mul,
			o_done => OPEN
		);

	o_done <= s_done;
	o_res  <= s_res;

	calc: process(i_clk, i_rst, s_mul_done, s_shift_done)
		variable pv : std_logic_vector(2*N-1 downto 0) := (others => '0');
		variable bp : std_logic_vector(2*N-1 downto 0) := (others => '0');
	begin
		if i_rst = '1' then
			s_state       <= IDLE;
			s_shift       <= (others => '0');
			s_mul_start   <= '0';
			s_mul_res     <= (others => '0');
			s_res         <= (others => '0');
			s_done        <= '0';
		elsif rising_edge(i_clk) then
			case s_state is
			when IDLE =>
			when others =>
			end case;
		end if;
	end process calc;
end architecture rtl;
