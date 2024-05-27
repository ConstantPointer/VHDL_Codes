library ieee;
use ieee.std_logic_1164.all;

-- Entity declaration for the DUT
entity DUT is
  port(
    input_vector: in std_logic_vector(1 downto 0);  -- 2-bit input vector
    output_vector: out std_logic_vector(1 downto 0) -- 2-bit output vector
  );
end entity DUT;

-- Architecture for the DUT
architecture DutWrap of DUT is

  -- Component declaration for the half subtractor
  component half_sub is
    port(
      A, B: in std_logic;    -- Inputs
      D, BO: out std_logic   -- Outputs
    );
  end component;

begin

  -- Instantiate the half_sub component and connect it to the input and output vectors
  HS: half_sub
    port map(
      A => input_vector(1),    -- Most significant bit of input_vector
      B => input_vector(0),    -- Least significant bit of input_vector
      D => output_vector(0),   -- Most significant bit of output_vector
      BO => output_vector(1)   -- Least significant bit of output_vector
    );

end architecture DutWrap;
