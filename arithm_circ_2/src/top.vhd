
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;


library vunit_lib;
context vunit_lib.vunit_context;


--!
--! 
--!
--!
--! i_raw: raw sensor data 
entity top is
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
	-- constant 100
	constant C_MULT_100 : std_logic_vector(N-1 downto 0) := X"0064";

	----------
	-- signals
	----------
	signal s_state   : state_t;

	signal s_done : std_logic;
	signal s_prev_en : std_logic;

	signal s_res : std_logic_vector(N-1 downto 0);

	-- multiplication
	signal s_mul_done  : std_logic;
	signal s_mul_start : std_logic;
	signal s_mul_res   : std_logic_vector(2*N-1 downto 0);

	-- shift
	signal s_shift_done  : std_logic;
	signal s_shift_start : std_logic;
	signal s_shift       : std_logic_vector(2*N-1 downto 0);
begin

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
					print("IDLE");
					s_done    <= '0';
					s_mul_start   <= '0';
					s_shift       <= (others => '0');
					s_mul_res     <= (others => '0');

					if i_en = '1' then
						s_state     <= MULT;
					else
						s_state <= IDLE;
					end if;
				when MULT =>
					s_res     <= (others => '0');
					print("MULT");

					bp := X"0000" & i_raw;
					pv := (others => '0');

					for i in 0 to N-1 loop
						if C_MULT_100(i) ='1' then
							pv := pv + bp;
						end if;
						bp := bp(2*N-2 downto 0) & '0';
					end loop;

					s_mul_res  <= pv;
					s_mul_done <= '1';

					if s_mul_done = '1' then
						s_state       <= SHIFT_16;

					else
						s_state <= MULT;
					end if;
				when SHIFT_16 =>
					print("SHIFT_16");
					--s_shift_start <= '1';
					s_shift <= s_mul_res srl N;
					--s_shift_done <= '1';

					s_state <= DONE;

				when DONE =>
					print("DONE");
					s_res         <= s_shift(N-1 downto 0);
					s_done        <= '1';
					s_state       <= IDLE;
					--s_en     <= '0';
				when others =>
					s_state <= IDLE;
			end case;
		end if;
	end process calc;
end architecture rtl;
