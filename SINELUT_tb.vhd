LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY SINELUT_TB IS
END SINELUT_TB;

ARCHITECTURE SINELUT_TB_ARC OF SINELUT_TB IS
	SIGNAL EN : STD_LOGIC := '0';
	SIGNAL RST : STD_LOGIC := '0';
	SIGNAL LUT_ADDRESS : UNSIGNED(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL SINE_WAVE : UNSIGNED(7 DOWNTO 0);

COMPONENT SINELUT
	PORT (
		EN : IN STD_LOGIC;
		RST : IN STD_LOGIC;
		LUT_ADDRESS : IN UNSIGNED(7 DOWNTO 0);
		SINE_WAVE : OUT UNSIGNED(7 DOWNTO 0)
	);
END COMPONENT;

-- Assign test bench signals to DUT ports SINLUT VHDL Entity.
BEGIN
	dut : SINELUT PORT MAP (
			EN => EN,
			RST => RST,
			LUT_ADDRESS => LUT_ADDRESS,
			SINE_WAVE => SINE_WAVE
		);

PROCESS
	BEGIN
		-- Test reset when RST 0.
		RST <= '0';
		EN <= '0';
		LUT_ADDRESS <= (OTHERS => '0');
		WAIT FOR 10 ns;

		-- enable LUT and set LUT address to 0.
		RST <= '1';
		EN <= '1';
		LUT_ADDRESS <= (OTHERS => '0');
		WAIT FOR 10 ns;

		-- check every LUT address from 0 to 255 and wait for 10ns for each sample.
		FOR i IN 0 TO 255 LOOP
			LUT_ADDRESS <= TO_UNSIGNED(i, 8);
			WAIT FOR 10 ns; -- TO CHECK EACH SAMPLE.
		END LOOP;
	END PROCESS;
END SINELUT_TB_ARC;
