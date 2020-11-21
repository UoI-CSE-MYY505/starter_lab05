library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pr_ex_mem is
	port(
		clk            : in  std_logic;
		reset            : in  std_logic;
		-- Signals of Data I/O.
		ex_aluOut      : in  std_logic_vector(31 downto 0);
		ex_src2        : in  std_logic_vector(31 downto 0);
		mem_aluOut     : out std_logic_vector(31 downto 0);
		mem_src2       : out std_logic_vector(31 downto 0);
		-- Signals to control MEM Stage.
		ex_memWrite    : in  std_logic;
		ex_ldstBypass  : in  std_logic;
		mem_memWrite   : out std_logic;
		mem_ldstBypass : out std_logic;
		-- Signals to control WB Stage.
		ex_memToReg    : in  std_logic;
		ex_rd          : in  std_logic_vector(4 downto 0);
		ex_regWrite    : in  std_logic;
		mem_memToReg   : out std_logic;
		mem_rd         : out std_logic_vector(4 downto 0);
		mem_regWrite   : out std_logic
	);
end entity pr_ex_mem;

architecture RTL of pr_ex_mem is
begin
	proc : process(clk, reset)
	begin
		if (reset = '1') then
			mem_rd       <= (others => '0'); -- Destination Register is $zero.
			mem_regWrite <= '0';	-- Do not write any Registers.
			mem_memWrite <= '0';	-- Do not write to Data Memory.
			-- The rest are unimportant to be reset, and allowed to be X.
		else
			if (rising_edge(clk)) then
				mem_src2       <= ex_src2 after 10 ns;
				mem_aluOut     <= ex_aluOut after 10 ns;
				mem_memWrite   <= ex_memWrite after 10 ns;
				mem_ldstBypass <= ex_ldstBypass after 10 ns;
				mem_memToReg   <= ex_memToReg after 10 ns;
				mem_rd         <= ex_rd after 10 ns;
				mem_regWrite   <= ex_regWrite after 10 ns;
			end if;
		end if;
	end process proc;
end architecture RTL;
