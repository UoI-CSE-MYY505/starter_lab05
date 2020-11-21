library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pr_if_id is
	port(
		clk      : in  std_logic;
		reset      : in  std_logic;
		loadEn   : in  std_logic;
		pcf      : in  std_logic_vector(31 downto 0);
		if_instr : in  std_logic_vector(31 downto 0);
		pcSeq    : out std_logic_vector(31 downto 0);
		id_instr : out std_logic_vector(31 downto 0)
	);
end entity pr_if_id;

architecture RTL of pr_if_id is
begin
	proc : process(clk, reset)
	begin
		if (reset = '1') then
				-- No need to reset PC, the Instruction is Nop.
				id_instr <= (others => '0'); -- Nop Instruction: sll $zero, $zero, $zero.
		else
			if (rising_edge(clk)) then
				if (loadEn = '1') then
					id_instr <= if_instr after 10 ns;
				end if;
			end if;
		end if;
	end process proc;
	only : process(clk)
	begin
		if (rising_edge(clk)) then
			if (loadEn = '1') then
				pcSeq <= pcf after 10 ns;
			end if;
		end if;
	end process only;
end architecture RTL;
