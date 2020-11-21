library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maindec is
	port(
		op       : in  std_logic_vector(5 downto 0); -- Op Code Field of Instruction.
		funct    : in  std_logic_vector(5 downto 0); -- Funct Field of R-type Instructions.
		branch   : out std_logic;
		jump     : out std_logic;
		lui      : out std_logic;
		isLoad   : out std_logic;
		isStore  : out std_logic;
		isNop    : out std_logic; -- This is all 0s, as sll $zero, $zero, $zero.
		readsRs  : out std_logic; -- The Instruction reads the 1st source register (rs).
		readsRt  : out std_logic; -- The Instruction reads the 2nd source register (rt).
		memwrite : out std_logic;
		regwrite : out std_logic;
		memtoreg : out std_logic;
		regdst   : out std_logic;
		alucontrol  : out std_logic_vector(2 downto 0);
		alusrc   : out std_logic
	);
end entity maindec;

architecture RTL of maindec is
	-- Implemented Instructions:
	-- lw, sw,
	-- beq, j,
	-- addi, addiu (same as addi, ignores overflows),
	-- ori,
	-- lui,
	-- add, sub, and, or, slt.
begin
	proc : process(op, funct)
	begin
		-- Default Values for Signals.
		branch   <= '0';
		jump     <= '0';
		lui      <= '0';
		isLoad   <= '0';
		isStore  <= '0';
		isNop    <= '0';
		readsRs  <= '1'; -- Most Instructions read the rs register.
		readsRt  <= '0';
		memwrite <= '0'; -- Don't write to the Data Memory.
		regwrite <= '0'; -- Don't write result to the Register File.
		memtoreg <= 'X'; -- Result Mux, unimportant.
		regdst   <= '0'; -- Destination Register, unimportant, but set to 0 for simplicity.
		alucontrol  <= "XXX"; -- ALU operation, unimportant.
		alusrc   <= 'X'; -- Second ALU source, unimportant.
		case op is
			when "000000" =>            -- RTYPE --
				regwrite <= '1'; -- All Implemented R-type instructions store result.
				regdst   <= '1'; -- Rd is the Destination Register.
				memtoreg <= '0'; -- AluOut to be stored to the Register File.
				alusrc   <= '0'; -- Second ALU source is the register value.
				readsRt  <= '1';
				case funct is
					when "100000" =>    -- ADD --
						alucontrol <= "010";
					when "100010" =>    -- SUB --
						alucontrol <= "110";
					when "100100" =>    -- AND --
						alucontrol <= "000";
					when "100101" =>    -- OR  --
						alucontrol <= "001";
					when "101010" =>    -- SLT --
						alucontrol <= "111";
					when "000000" =>    -- SLL --
						isNop    <= '1'; -- Assuming NOP, even if rs, rt, and rd are not $zero.
						regwrite <= '0';
					when others =>    -- Unknown.
						alucontrol <= "XXX";
				end case;
			when "100011" =>            --  LW   --
				isLoad   <= '1';
				regwrite <= '1'; -- Write Result to Register File.
				regdst   <= '0'; -- Rt is the Destination Register.
				memtoreg <= '1'; -- Signal Result is Mem Output.
				alusrc   <= '1'; -- Second ALU source is Immediate.
				alucontrol  <= "010";
			when "101011" =>            --  SW   --
				isStore  <= '1';
				memwrite <= '1'; -- Write to Data Memory.
				alusrc   <= '1'; -- Second ALU  source is Immediate.
				alucontrol  <= "010";
				readsRt  <= '1';
			when "000100" =>            --  BEQ  --
				branch  <= '1';
				readsRt <= '1';
				alusrc  <= '0'; -- Second ALU source is the register value.
				alucontrol <= "110";  -- subtract
			when "001000" | "001001" => -- ADDI, ADDIU --
				regwrite <= '1'; -- Write Result to Register File.
				regdst   <= '0'; -- Rt is the Destination Register.
				memtoreg <= '0'; -- Signal Result is ALU Output.
				alusrc   <= '1'; -- Second ALU source is Immediate.
				alucontrol  <= "010";
			when "000010" =>            --   J   --
				jump    <= '1';
				readsRs <= '0'; -- Does not read Rs.
			when "001111" =>            --  LUI  --
				lui      <= '1';
				regwrite <= '1'; -- Write Result to Register File.
				regdst   <= '0'; -- Rt is the Destination Register.
				memtoreg <= '0'; -- Signal Result is ALU Output.
				alusrc   <= '1'; -- Second ALU Source is Immediate.
				readsRs  <= '0'; -- Does not read Rs.
				alucontrol  <= "001";
			when "001101" =>            --  ORI  --
				regwrite <= '1'; -- Write Result to Register File.
				regdst   <= '0'; -- Rt is the Destination Register.
				memtoreg <= '0'; -- Signal Result is ALU Output.
				alusrc   <= '1'; -- Second ALU Source is Immediate.
				alucontrol  <= "001";
			when others =>            -- Unknown --
				isNop <= 'X'; -- Default values at the top cover this case.
		end case;
	end process proc;
end architecture RTL;
