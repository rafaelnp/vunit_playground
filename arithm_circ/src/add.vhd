
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity add is
	generic(
		N : natural := 16
	);
	port(
		--i_clk  : in  std_logic;
		--i_rst  : in  std_logic;
		--i_en   : in  std_logic;
		i_x    : in  std_logic_vector(15 downto 0);
		i_y    : in  std_logic_vector(15 downto 0);
		i_cin  : in  std_logic;
		--o_done : out std_logic;
		o_z    : out std_logic_vector(15 downto 0);
		o_cout : out  std_logic
	);
end entity add;

architecture rtl of add is
	signal p : std_logic_vector(N - 1 downto 0);
	signal g : std_logic_vector(N - 1 downto 0);
	signal q : std_logic_vector(N downto 0);
begin
	q(0) <= i_cin;
	iterative_step: for i in 0 to N-1 generate
		p(i) <= i_x(i) xor i_y(i);
		g(i) <= i_y(i);
		with p(i) select q(i+1) <= q(i) when '1', g(i) when others;
		o_z(i) <= p(i) xor q(i);
	end generate;
	o_cout <= q(n);
end architecture rtl;
