-- Include the IEEE library for standard logic types
library ieee;
use ieee.std_logic_1164.all;

-- Entity declaration for the half subtractor
entity half_sub is 
  port(
    A, B: in std_logic;    -- Inputs
    D, BO: out std_logic   -- Outputs
  );
end entity half_sub;

-- Architecture for the half subtractor
architecture struct of half_sub is

  -- Component declaration for XOR gate
  component XOR_2 is
    port(
      A, B: in std_logic;
      Y: out std_logic
    );
  end component;

  -- Component declaration for INVERTER
  component INVERTER is
    port(
      A: in std_logic;
      Y: out std_logic
    );
  end component;

  -- Component declaration for AND gate
  component AND_2 is
    port(
      A, B: in std_logic;
      Y: out std_logic
    );
  end component;

  -- Internal signals for intermediate results
  signal INV, DIFF, BOUT: std_logic;

begin

  -- XOR gate instance for the difference calculation
  D_OUT: XOR_2
    port map(
      A => A,
      B => B,
      Y => DIFF
    );

  -- Inverter instance for the borrow calculation
  Temp: INVERTER
    port map(
      A => A,
      Y => INV
    );

  -- AND gate instance for the borrow out calculation
  B_OUT: AND_2
    port map(
      A => INV,
      B => B,
      Y => BOUT
    );

  -- Assign the internal signals to the output ports
  D <= DIFF;
  BO <= BOUT;

end architecture struct;

-- Architecture for the XOR_2 component
architecture behav of XOR_2 is
begin
  process(A, B)
  begin
    -- XOR operation for the input signals
    Y <= A xor B;
  end process;
end architecture behav;

-- Architecture for the INVERTER component
architecture behav of INVERTER is
begin
  process(A)
  begin
    -- NOT operation for the input signal
    Y <= not A;
  end process;
end architecture behav;

-- Architecture for the AND_2 component
architecture behav of AND_2 is
begin
  process(A, B)
  begin
    -- AND operation for the input signals
    Y <= A and B;
  end process;
end architecture behav;

-- Alternative architecture for the half_sub entity using dataflow style
-- Commented out for reference
-- architecture dataflow of half_sub is
--   begin
--     D <= A xor B;
--     BO <= ((not A) and B);
-- end architecture dataflow;

-- Alternative architecture for the half_sub entity using behavioral style
-- Commented out for reference
-- architecture behav of half_sub is 
-- begin
--   process(A, B)
--     begin
--       D <= A xor B;
--       BO <= ((not A) and B);
--     end process;
-- end architecture behav;
