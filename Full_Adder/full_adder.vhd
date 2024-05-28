library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Half Adder Entity and Architecture
entity HalfAdder is
    port (
        a, b: in bit;
        s, cy: out bit
    );
end entity HalfAdder;

architecture trivial of HalfAdder is
begin
    -- XOR gate to compute the sum
    s <= a xor b;
    
    -- AND gate to compute the carry
    cy <= a and b;
end architecture trivial;

-- OR Gate Entity and Architecture
entity Or2in is
    port (
        a, b: in bit;
        aorb: out bit
    );
end entity Or2in;

architecture trivial of Or2in is
begin
    -- OR gate operation
    aorb <= a or b;
end architecture trivial;

-- Full Adder Entity and Architecture
entity FullAdder is
    port (
        a, b, C_in: in bit;
        sum, C_out: out bit
    );
end entity FullAdder;

architecture struct of FullAdder is
    component HalfAdder is
        port (
            a, b: in bit;
            s, cy: out bit
        );
    end component HalfAdder;

    component Or2in is
        port (
            a, b: in bit;
            aorb: out bit
        );
    end component Or2in;

    signal s1, cy1, cy2: bit;
begin
    -- First Half Adder
    HA1: HalfAdder
        port map (
            a => a,
            b => b,
            s => s1,
            cy => cy1
        );

    -- Second Half Adder
    HA2: HalfAdder
        port map (
            a => s1,
            b => C_in,
            s => sum,
            cy => cy2
        );

    -- OR gate to compute the final carry-out
    cmbn: Or2in
        port map (
            a => cy1,
            b => cy2,
            aorb => C_out
        );
end architecture struct;

    ---- Define the architecture named "dataflow" for the Full_Adder entity
--architecture dataflow of Full_Adder is
--begin
--    -- Calculate the sum (S) output 
--    S <= A xor B xor C;
--
--    -- Calculate the carry-out (Cout) output
--    Cout <= (A and B) or (B and C) or (C and A);
--end architecture dataflow;

--
---- Define the architecture named "behav" for the Full_Adder entity
--architecture behav of Full_Adder is 
--begin
--    -- Process block sensitive to changes in inputs A, B, and Cin
--    process(A, B, Cin)
--    begin
--        -- Calculate the sum (S) output
--        S <= A xor B xor Cin;
--        
--        -- Calculate the carry-out (Cout) output
--        Cout <= (A and B) or (B and Cin) or (Cin and A);
--    end process;
--end architecture behav;



