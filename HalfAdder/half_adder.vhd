--library ieee;
--use ieee.std_logic_1164.all;
--
--library ieee;
--use ieee.std_logic_1164.all;
--  entity AND_gate is
--    port(A,B:in std_logic;Y:out std_logic);
--    end entity AND_gate;
--    
--    architecture behav of AND_gate is
--      begin
--      Y<=A and B;
--    end architecture behav;
--library ieee;
--use ieee.std_logic_1164.all;
--    
--  entity XOR_gate is
--    port(A,B:in std_logic;Y:out std_logic);
--    end entity XOR_gate;
--    
--    architecture behav of XOR_gate is
--      begin
--      Y<=A xor B;
--    end architecture behav;
--  library ieee;
--use ieee.std_logic_1164.all;
--  
--entity half_adder is 
--  port( A,B: in std_logic; S,C: out std_logic);
--  end entity half_adder;
--  
--architecture struct of half_adder is 
--component AND_gate is 
--   port (
--            A, B: in std_logic;
--            Y: out std_logic
--        );
--    end component AND_gate;
--    component XOR_gate is 
--   port (
--            A, B: in std_logic;
--            Y: out std_logic
--        );
--    end component XOR_gate;
--    signal SUM,COUT:std_logic;
--    begin
--      S_OUT:XOR_gate
--      port map(
--        A=>A,
--        B=>B,
--        Y=>SUM        
--      );
--      C_OUT:AND_gate
--      port map(
--        A=>A,
--        B=>B,
--        Y=>COUT  
--      );
--      S<=SUM;
--      C<=COUT;
--    end architecture struct;

--library ieee;
--use ieee.std_logic_1164.all;
--entity half_adder is
--  port (A,B:in std_logic; S,C:out std_logic);
--  end entity half_adder;
--  architecture dataflow of half_adder is 
--  begin
--  S<=A xor B;
--  C<=A and B;
--  end architecture dataflow;
--
--library ieee;
--use ieee.std_logic_1164.all;
--entity half_adder is 
--  port (A,B:in std_logic; S,C:out std_logic);
--  end entity half_adder;
--  
--  architecture behav of half_adder is
--    begin 
--      process(A,B)
--        begin
--        S<=A xor B;
--        C<=A and B;
--        end process;
--        end architecture behav;

library ieee;
use ieee.std_logic_1164.all;

entity AND_gate is
    port(A, B: in std_logic; Y: out std_logic);
end entity AND_gate;

architecture behav of AND_gate is
begin
    Y <= A and B;
end architecture behav;

library ieee;
use ieee.std_logic_1164.all;

entity XOR_gate is
    port(A, B: in std_logic; Y: out std_logic);
end entity XOR_gate;

architecture behav of XOR_gate is
begin
    Y <= A xor B;
end architecture behav;
library ieee;
use ieee.std_logic_1164.all;

entity half_adder is 
    port(A, B: in std_logic; S, C: out std_logic);
end entity half_adder;

architecture struct of half_adder is 
    component AND_gate is 
        port(A, B: in std_logic; Y: out std_logic);
    end component AND_gate;

    component XOR_gate is 
        port(A, B: in std_logic; Y: out std_logic);
    end component XOR_gate;

    signal SUM, COUT: std_logic;
begin
    S_OUT: XOR_gate
        port map(A => A, B => B, Y => SUM);

    C_OUT: AND_gate
        port map(A => A, B => B, Y => COUT);

    S <= SUM;
    C <= COUT;
end architecture struct;


