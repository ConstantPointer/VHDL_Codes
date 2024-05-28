library ieee;  -- Use the IEEE standard library.
use ieee.std_logic_1164.all;  -- Use all components from the IEEE std_logic_1164 package.

-- Entity declaration for a Half Subtractor
entity Half_subtractor is
    port (
        A, B: in std_logic;  -- Inputs: A and B
        D, Bout: out std_logic  -- Outputs: Difference (D) and Borrow-out (Bout)
    );
end entity Half_subtractor;

-- Architecture for the Half Subtractor
architecture trivial of Half_subtractor is
begin
    D <= A xor B;  -- Difference is the XOR of inputs A and B.
    Bout <= (not A) and B;  -- Borrow-out is high if A is low and B is high.
end architecture trivial;

-- Entity declaration for a 2-input OR gate
entity Or2in is
    port (
        A, B: in std_logic;  -- Inputs: A and B
        Y: out std_logic  -- Output: Y
    );
end entity Or2in;

-- Architecture for the 2-input OR gate
architecture trivial of Or2in is
begin
    Y <= A or B;  -- Output Y is the OR of inputs A and B.
end architecture trivial;

-- Entity declaration for a Full Subtractor
entity Full_subtractor is
    port (
        A, B, Bin: in std_logic;  -- Inputs: A, B, and Borrow-in (Bin)
        D, Bout: out std_logic  -- Outputs: Difference (D) and Borrow-out (Bout)
    );
end entity Full_subtractor;

-- Structural architecture for the Full Subtractor
architecture struct of Full_subtractor is

    -- Component declaration for the Half Subtractor
    component Half_subtractor is
        port (
            A, B: in std_logic;  -- Inputs: A and B
            D, Bout: out std_logic  -- Outputs: Difference (D) and Borrow-out (Bout)
        );
    end component Half_subtractor;

    -- Component declaration for the 2-input OR gate
    component Or2in is 
        port (
            A, B: in std_logic;  -- Inputs: A and B
            Y: out std_logic  -- Output: Y
        );
    end component Or2in;

    -- Intermediate signals to connect components
    signal S, C1, C2: std_logic;
begin
    -- First Half Subtractor instance
    HS1: Half_subtractor 
    port map (
        A => A,  -- Connect A input of Full Subtractor to A input of Half Subtractor
        B => B,  -- Connect B input of Full Subtractor to B input of Half Subtractor
        D => S,  -- Connect Difference output to intermediate signal S
        Bout => C1  -- Connect Borrow-out output to intermediate signal C1
    );
    
    -- Second Half Subtractor instance
    HS2: Half_subtractor
    port map (
        A => S,  -- Connect intermediate signal S to A input of second Half Subtractor
        B => Bin,  -- Connect Borrow-in input of Full Subtractor to B input of second Half Subtractor
        D => D,  -- Connect Difference output to final output D
        Bout => C2  -- Connect Borrow-out output to intermediate signal C2
    );

    -- OR gate instance to combine the two borrow signals
    OR1: Or2in
    port map (
        A => C1,  -- Connect C1 signal to input A of OR gate
        B => C2,  -- Connect C2 signal to input B of OR gate
        Y => Bout  -- Connect output of OR gate to final Borrow-out (Bout)
    );
end architecture struct;

-- Commented out alternative architectures for the Full Subtractor

-- Architecture using dataflow modeling
-- architecture dataflow of Full_Subtractor is
-- begin
-- D <= A xor B xor Bin;  -- Difference is XOR of A, B, and Bin.
-- Bout <= (((not A) and Bin) or((not A) and B) or (B and Bin));  -- Borrow-out is OR of three conditions.
-- end architecture dataflow;

-- Architecture using behavioral modeling
-- architecture behav of Full_Subtractor is 
-- begin 
-- process(A, B, Bin)
-- begin
-- D <= A xor B xor Bin;  -- Difference is XOR of A, B, and Bin.
-- Bout <= (((not A) and Bin) or((not A) and B) or (B and Bin));  -- Borrow-out is OR of three conditions.
-- end process;
-- end architecture behav;
