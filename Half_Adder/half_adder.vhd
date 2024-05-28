-- Library declaration for using standard logic types

library ieee;
use ieee.std_logic_1164.all;

-- Entity declaration for AND_gate

entity AND_gate is
    port(A, B: in std_logic; Y: out std_logic);
end entity AND_gate;

-- Architecture for AND_gate using Dataflow modeling
    
architecture behav of AND_gate is
begin
    -- Concurrent signal assignment for AND operation
    
    Y <= A and B;
end architecture behav;

-- Library declaration for using standard logic types
    
library ieee;
use ieee.std_logic_1164.all;

-- Entity declaration for XOR_gate
    
entity XOR_gate is
    port(A, B: in std_logic; Y: out std_logic);
end entity XOR_gate;

-- Architecture for XOR_gate using Dataflow modeling
    
architecture behav of XOR_gate is
begin
    -- Concurrent signal assignment for XOR operation
    Y <= A xor B;
end architecture behav;

-- Library declaration for using standard logic types
    
library ieee;
use ieee.std_logic_1164.all;

-- Entity declaration for half_adder
    
entity half_adder is 
    port(A, B: in std_logic; S, C: out std_logic);
end entity half_adder;

-- Architecture for half_adder using Structural modeling
    
architecture struct of half_adder is 
    -- Component declaration for AND_gate
    component AND_gate is 
        port(A, B: in std_logic; Y: out std_logic);
    end component AND_gate;

    -- Component declaration for XOR_gate
    component XOR_gate is 
        port(A, B: in std_logic; Y: out std_logic);
    end component XOR_gate;

    -- Internal signals for sum and carry outputs
    signal SUM, COUT: std_logic;
begin
    -- Instantiate XOR_gate component
    S_OUT: XOR_gate
        port map(A => A, B => B, Y => SUM);

    -- Instantiate AND_gate component
    C_OUT: AND_gate
        port map(A => A, B => B, Y => COUT);

    -- Connect internal signals to output ports
    S <= SUM;
    C <= COUT;
end architecture struct;

-- Alternate implementations for half_adder (commented out entity and library declaration remains same)
    
-- The following are two alternative architectures for the half_adder using different modeling styles.
    
-- 1)Architecture for half_adder using Dataflow modeling
    
--architecture dataflow of half_adder is 
--begin
--  -- Concurrent signal assignments for XOR and AND operations
--  S <= A xor B;
--  C <= A and B;
--end architecture dataflow;

-- 2)Architecture for half_adder using Behavioral modeling
    
--architecture behav of half_adder is
--begin 
--  -- Process for sequential execution
    
--  process(A, B)
--  begin
--    S <= A xor B;
--    C <= A and B;
--  end process;
--end architecture behav;
