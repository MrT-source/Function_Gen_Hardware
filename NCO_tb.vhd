LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY NCO_TB IS
END NCO_TB;

ARCHITECTURE NCO_TB_ARC OF NCO_TB IS
	SIGNAL CLK : STD_LOGIC := '0';
	SIGNAL RST : STD_LOGIC := '0';
	SIGNAL EN : STD_LOGIC := '0';
	SIGNAL FTW_IN : UNSIGNED(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL LUT_ADDRESS : UNSIGNED(7 DOWNTO 0);
	SIGNAL SQR_OUT : STD_LOGIC;

	COMPONENT NCO PORT (
		CLK : IN STD_LOGIC;
		RST : IN STD_LOGIC;
		EN : IN STD_LOGIC;
		FTW_IN : IN UNSIGNED(31 DOWNTO 0);
		LUT_ADDRESS : OUT UNSIGNED(7 DOWNTO 0);
		SQR_OUT : OUT STD_LOGIC
	);
	END COMPONENT;
-- Assign test bench signals to DUT ports NCO VHDL Entity.
BEGIN
	DUT : NCO PORT MAP (
		CLK => CLK,
		RST => RST,
		EN => EN,
		FTW_IN => FTW_IN,
		LUT_ADDRESS => LUT_ADDRESS,
		SQR_OUT => SQR_OUT
	);

PROCESS 
	BEGIN
		-- Clock generation
		LOOP
			CLK <= '0';
			WAIT FOR 10 ns;
			CLK <= '1';
			WAIT FOR 10 ns;
		END LOOP;
END PROCESS;

-- check general functionality of the NCO, counting up as a Saw tooth and a square wave output.
PROCESS 
	BEGIN
		-- Test reset when RST 0.
		RST <= '0';
		EN <= '0';
		FTW_IN <= (OTHERS => '0');
		WAIT FOR 20 ns;
		
		-- Release reset and check address 0
		RST <= '1';
		EN <= '1';
		FTW_IN <= (OTHERS => '0');
		WAIT FOR 20 ns;
		
		-- Set FTW to 100,000Hz TUNING WORD and wait for 20000ns.
		FTW_IN <= TO_UNSIGNED(8589935, 32);
		WAIT FOR 20000 ns;
		
	END PROCESS;

END NCO_TB_ARC;
