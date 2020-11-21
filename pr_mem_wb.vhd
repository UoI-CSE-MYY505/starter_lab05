library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pr_mem_wb is
	port(
		clk          : in  std_logic;
		reset          : in  std_logic;
		mem_aluOut   : in  std_logic_vector(31 downto 0);
		mem_mo       : in  std_logic_vector(31 downto 0);
		mem_memToReg : in  std_logic;
		mem_rd       : in  std_logic_vector(4 downto 0);
		mem_regWrite : in  std_logic;
		wb_aluOut    : out std_logic_vector(31 downto 0);
		wb_mo        : out std_logic_vector(31 downto 0);
		wb_memToReg  : out std_logic;
		wb_rd        : out std_logic_vector(4 downto 0);
		wb_regWrite  : out std_logic
	);
end entity pr_mem_wb;

architecture RTL of pr_mem_wb is
begin
	proc : process(clk, reset)
	begin
		if (reset = '1') then
			wb_rd       <= (others => '0');
			wb_regWrite <= '0';
			-- The rest are unimportant to be reset, and allowed to be X.
		elsif (rising_edge(clk)) then
			wb_mo       <= mem_mo after 10 ns;
			wb_aluOut   <= mem_aluOut after 10 ns;
			wb_memToReg <= mem_memToReg after 10 ns;
			wb_rd       <= mem_rd after 10 ns;
			wb_regWrite <= mem_regWrite after 10 ns;
		end if;
	end process proc;
end architecture RTL;
