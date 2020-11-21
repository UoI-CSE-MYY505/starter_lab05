library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pr_id_ex is
	port(
		clk           : in  std_logic;
		reset           : in  std_logic;
		-- Signals of Data I/O.
		id_brT        : in  std_logic_vector(31 downto 0);
		id_rdA        : in  std_logic_vector(31 downto 0);
		id_rdB        : in  std_logic_vector(31 downto 0);
		id_imm        : in  std_logic_vector(31 downto 0);
		ex_brT        : out std_logic_vector(31 downto 0);
		ex_rdA        : out std_logic_vector(31 downto 0);
		ex_rdB        : out std_logic_vector(31 downto 0);
		ex_imm        : out std_logic_vector(31 downto 0);
		-- Signals to control EX Stage.
		id_isLoad     : in  std_logic;
		id_isBranch   : in  std_logic;
		id_aluCont    : in  std_logic_vector(2 downto 0);
		id_aluSrc     : in  std_logic;
		id_forwardA   : in  std_logic_vector(1 downto 0);
		id_forwardB   : in  std_logic_vector(1 downto 0);
		ex_isLoad     : out std_logic;
		ex_isBranch   : out std_logic;
		ex_aluCont    : out std_logic_vector(2 downto 0);
		ex_aluSrc     : out std_logic;
		ex_forwardA   : out std_logic_vector(1 downto 0);
		ex_forwardB   : out std_logic_vector(1 downto 0);
		-- Signals to control MEM Stage.
		id_memWrite   : in  std_logic;
		id_ldstBypass : in  std_logic;
		ex_memWrite   : out std_logic;
		ex_ldstBypass : out std_logic;
		-- Signals to control WB Stage.
		id_memToReg   : in  std_logic;
		id_rd         : in  std_logic_vector(4 downto 0);
		id_regWrite   : in  std_logic;
		ex_memToReg   : out std_logic;
		ex_rd         : out std_logic_vector(4 downto 0);
		ex_regWrite   : out std_logic
	);
end entity pr_id_ex;

architecture RTL of pr_id_ex is
begin
	proc : process(clk, reset)
	begin
		if (reset = '1') then
			ex_rd       <= (others => '0'); -- Destination Register is $zero.
			ex_regWrite <= '0';		-- Do not write any Registers.
			ex_memWrite <= '0';		-- Do not write to Data Memory.
			-- The rest are unimportant to be reset, and allowed to be X.
		else
			if (rising_edge(clk)) then
				ex_brT        <= id_brT after 10 ns;
				ex_rdA        <= id_rdA after 10 ns;
				ex_rdB        <= id_rdB after 10 ns;
				ex_imm        <= id_imm after 10 ns;
				ex_isLoad     <= id_isLoad after 10 ns;
				ex_isBranch   <= id_isBranch after 10 ns;
				ex_aluCont    <= id_aluCont after 10 ns;
				ex_aluSrc     <= id_aluSrc after 10 ns;
				ex_forwardA   <= id_forwardA after 10 ns;
				ex_forwardB   <= id_forwardB after 10 ns;
				ex_memWrite   <= id_memWrite after 10 ns;
				ex_ldstBypass <= id_ldstBypass after 10 ns;
				ex_memToReg   <= id_memToReg after 10 ns;
				ex_rd         <= id_rd after 10 ns;
				ex_regWrite   <= id_regWrite after 10 ns;
			end if;
		end if;
	end process proc;
end architecture RTL;
