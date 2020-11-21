library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity signext is
	port(
		a : in  std_logic_vector(15 downto 0);
		y : out std_logic_vector(31 downto 0)
	);
end entity signext;

architecture RTL of signext is
	constant empty : std_logic_vector(15 downto 0) := (others => '0');
	constant full  : std_logic_vector(15 downto 0) := (others => '1');
begin
	y <= full & a when (a(15) = '1') else empty & a;
end architecture RTL;
