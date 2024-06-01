--NAND
library ieee;
use ieee.std_logic_1164.all;

entity NAND_2 is
port( A,B:in std_logic;Y:out std_logic);
end entity NAND_2;

architecture struct of NAND_2 is
begin
Y<=A nand B;
end architecture struct;

--AND
library ieee;
use ieee.std_logic_1164.all;

 entity AND_2 is
 port( A,B:in std_logic;Y:out std_logic);
end entity AND_2;

architecture struct1 of AND_2 is

component NAND_2 is
port (A,B: in std_logic; Y:out std_logic);
end component NAND_2;
signal Temp:std_logic;
begin
N1:NAND_2
port map(
		A=>A,
		B=>B,
		Y=>Temp
		);
N2:NAND_2
port map(
		A=>Temp,
		B=>Temp,
		Y=>Y
		);
end architecture struct1;
--OR
library ieee;
use ieee.std_logic_1164.all;

entity OR_2 is
 port( A,B:in std_logic;Y:out std_logic);
end entity OR_2;

architecture struct2 of OR_2 is

component NAND_2 is
port (A,B: in std_logic; Y:out std_logic);
end component NAND_2;
signal T1,T2:std_logic;
begin 
O1:NAND_2
port map (
		A=>A,
		B=>A,
		Y=>T1);
O2:NAND_2
port map (
		A=>B,
		B=>B,
		Y=>T2);
O3:NAND_2
port map (
		A=>T1,
		B=>T2,
		Y=>Y);
end architecture struct2;
--XOR
library ieee;
use ieee.std_logic_1164.all;

entity XOR_2 is
 port( A,B:in std_logic;Y:out std_logic);
end entity XOR_2;

architecture struct3 of XOR_2 is

component NAND_2 is
port (A,B: in std_logic; Y:out std_logic);
end component NAND_2;

signal T1,T2,T3:std_logic;
begin 
X1:NAND_2
port map (
		A=>A,
		B=>B,
		Y=>T1);
X2:NAND_2
port map (
		A=>A,
		B=>T1,
		Y=>T2);
X3:NAND_2
port map (
		A=>T1,
		B=>B,
		Y=>T3);
X4:NAND_2
port map (
		A=>T2,
		B=>T3,
		Y=>Y);
end architecture struct3;
--XNOR
library ieee;
use ieee.std_logic_1164.all;

 entity XNOR_2 is 
 port (A,B:in std_logic;Y:out std_logic);
 end entity XNOR_2;
  
 architecture struct4 of XNOR_2 is
 
 component XOR_2 is
 port (A,B: in std_logic; Y:out std_logic);
 end component XOR_2;
 
 component NAND_2 is
port (A,B: in std_logic; Y:out std_logic);
end component NAND_2;

signal demo:std_logic;

begin
Z1:XOR_2
port map (
		A=>A,
		B=>B,
		Y=>Demo);
Z2:NAND_2
port map(
		A=>Demo,
		B=>Demo,
		Y=>Y);
end architecture struct4;

--HALFADDER
library ieee;
use ieee.std_logic_1164.all;

entity Half_adder is 
port (A,B:in std_logic;S,C:out std_logic);
end entity Half_adder;

architecture struct5 of Half_adder is

 component XOR_2 is
 port (A,B: in std_logic; Y:out std_logic);
 end component XOR_2;
 
 
 component NAND_2 is
port (A,B: in std_logic; Y:out std_logic);
end component NAND_2;

signal demo:std_logic;

begin
S1:XOR_2
 port map (
		A=>A,
		B=>B,
		Y=>S);
S2:NAND_2
port map (
 A=>A,
 B=>B,
 Y=>Demo);


S3:NAND_2
port map(
		A=>Demo,
		B=>Demo,
		Y=>C);

end architecture struct5;
