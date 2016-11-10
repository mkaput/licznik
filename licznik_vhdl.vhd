---
--- licznik_vhdl
---

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity licznik_vhdl is
	port(
		CLK: 		in	std_logic;
		ADD_SUB: 	in	std_logic;
		OUT0, OUT1:	out	std_logic_vector(0 to 6)
	);
end entity;

architecture logic of licznik_vhdl is
	
	component counter
		port(
			CLK: 		in	std_logic;
			ADD_SUB: 	in	std_logic;
			COUNT:		out	std_logic_vector(3 downto 0)
		);
	end component;
	
	component encoder
		port(
			NUM:		in	std_logic_vector(3 downto 0);
			OUT0, OUT1:	out	std_logic_vector(0 to 6)
		);
	end component;
	
	component zegar
		port(
			CLK:		in 	std_logic;
			CLK_OUT:	out	std_logic
		);
	end component;
	
	signal ZZ_CLK:	 std_logic;
	signal ZZ_COUNT: std_logic_vector(3 downto 0);		
	
begin

	zegar0: zegar
		port map(
			CLK		=> CLK,
			CLK_OUT	=> ZZ_CLK
		);

	counter0: counter
		port map(
			CLK 	=> ZZ_CLK,
			ADD_SUB => ADD_SUB,
			COUNT	=> ZZ_COUNT
		);

	encoder0: encoder
		port map(
			NUM	 => ZZ_COUNT,
			OUT0 => OUT0,
			OUT1 => OUT1
		);
	
end architecture;


---
--- counter
---

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity counter is
	port(
		CLK: 		in		std_logic;
		ADD_SUB: 	in		std_logic;
		COUNT:		buffer	std_logic_vector(3 downto 0)
	);
end entity;

architecture logic of counter is
begin
	process (CLK, ADD_SUB) begin
		if (CLK'event and CLK = '1') then
			if (ADD_SUB = '1') then
				COUNT <= COUNT + 1;
			else
				COUNT <= COUNT - 1;
			end if;
		end if;
	end process;
end architecture;


---
--- encoder
---

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity encoder is
	port(
		NUM:		in	std_logic_vector(3 downto 0);
		OUT0, OUT1:	out	std_logic_vector(0 to 6)
	);
end entity;

architecture logic of encoder is
begin
	process (NUM) begin
		case (NUM) is
			when x"1" =>
				OUT0 <= "1001111";
				OUT1 <= "0000001";
			when x"2" =>
				OUT0 <= "0010010";
				OUT1 <= "0000001";
			when x"3" =>
				OUT0 <= "0000110";
				OUT1 <= "0000001";
			when x"4" =>
				OUT0 <= "1001100";
				OUT1 <= "0000001";
			when x"5" =>
				OUT0 <= "0100100";
				OUT1 <= "0000001";
			when x"6" =>
				OUT0 <= "0100000";
				OUT1 <= "0000001";
			when x"7" =>
				OUT0 <= "0001111";
				OUT1 <= "0000001";
			when x"8" =>
				OUT0 <= "0000000";
				OUT1 <= "0000001";
			when x"9" =>
				OUT0 <= "0000100";
				OUT1 <= "0000001";
			when x"A" =>
				OUT0 <= "0000001";
				OUT1 <= "1001111";
			when x"B" =>
				OUT0 <= "1001111";
				OUT1 <= "1001111";
			when x"C" =>
				OUT0 <= "0010010";
				OUT1 <= "1001111";
			when x"D" =>
				OUT0 <= "0000110";
				OUT1 <= "1001111";
			when x"E" =>
				OUT0 <= "1001100";
				OUT1 <= "1001111";
			when x"F" =>
				OUT0 <= "0100100";
				OUT1 <= "1001111";
			when others => 
				OUT0 <= "0000001";
				OUT1 <= "0000001";
		end case;
	end process;
end architecture;

--
-- zegar
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity zegar is
	port(
		CLK:		in	std_logic;
		CLK_OUT:	out	std_logic
	);
end entity;

architecture behaviour of zegar is
	signal count: integer := 0;
	signal sig: std_logic := '1';
begin
	process (CLK, sig) begin
		if (CLK'event and CLK = '1') then
			count <= count + 1;
			if (count = 12587500) then
				sig <= not sig;
				count <= 0;
			end if;
		end if;
		CLK_OUT <= sig;
	end process;
end architecture;
