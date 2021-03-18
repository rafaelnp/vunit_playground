

library ieee;
use ieee.std_logic_1164.all;

entity carry_ripple_adder is
	generic(
		n : integer := 8
	); --number of bits
	port(
		a   : in  std_logic_vector(n-1 downto 0);
		b   : in  std_logic_vector(n-1 downto 0);
		cin : in  std_logic;
		s   : out std_logic_vector(n-1 downto 0);
		cout: out std_logic
	);
end entity carry_ripple_adder;

architecture rtl of carry_ripple_adder is
begin
	adder: process(a, b, cin)
		variable carry : std_logic_vector (n downto 0);
	begin
	carry(0) := cin;
	for i in 0 to n-1 loop
		s(i) <= a(i) xor b(i) xor carry(i);
		carry(i+1) := (a(i) and b(i)) or (a(i) and carry(i)) or (b(i) and carry(i));
	end loop;
		cout <= carry(n);
	end process adder;
end rtl;
