
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity top is
	port(
		i_clk  : in  std_logic;
		i_rst  : in  std_logic;
		i_en   : in  std_logic;
		i_data : in  std_logic_vector(15 downto 0);
		o_done : out std_logic;
		o_data : out std_logic_vector(15 downto 0)
	);
end entity top;

architecture rtl of top is
begin

end architecture rtl;
