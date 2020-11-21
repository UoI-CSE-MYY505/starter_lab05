library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity constant0 is
	port(
		result : out std_logic_vector(31 downto 0)
	);
end entity constant0;

architecture RTL of constant0 is
begin
	result <= (others => '0');
end architecture RTL;
