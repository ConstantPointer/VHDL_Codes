library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Half Adder Entity and Architecture
entity HalfAdder is
    port (a, b: in bit;
          s, cy: out bit);
end entity HalfAdder;

architecture trivial of HalfAdder is
begin
    s <= a xor b;
    cy <= a and b;
end architecture trivial;

-- OR Gate Entity and Architecture
entity Or2in is
    port (a, b: in bit;
          aorb: out bit);
end entity Or2in;

architecture trivial of Or2in is
begin
    aorb <= a or b;
end architecture trivial;

-- Full Adder Entity and Architecture
entity FullAdder is
    port (a, b, C_in: in bit;
          sum, C_out: out bit);
end entity FullAdder;

architecture struct of FullAdder is
    component HalfAdder is
        port (a, b: in bit;
              s, cy: out bit);
    end component HalfAdder;

    component Or2in is
        port (a, b: in bit;
              aorb: out bit);
    end component Or2in;

    signal s1, cy1, cy2: bit;
begin
    HA1: HalfAdder
        port map (a => a,
                  b => b,
                  s => s1,
                  cy => cy1);

    HA2: HalfAdder
        port map (a => s1,
                  b => C_in,
                  s => sum,
                  cy => cy2);

    cmbn: Or2in
        port map (a => cy1,
                  b => cy2,
                  aorb => C_out);
end architecture struct;


