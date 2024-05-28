library ieee;  -- Import IEEE library
use ieee.std_logic_1164.all;  -- Use standard logic types

entity DUT is
   port (
        input_vector: in std_logic_vector(2 downto 0);  -- Input vector with 3 bits
        output_vector: out std_logic_vector(1 downto 0)  -- Output vector with 2 bits
    );
end entity;

architecture DutWrap of DUT is
   component Full_Subtractor is  -- Component declaration for the Full Subtractor
     port (
          A, B, Bin: in std_logic;  -- Inputs: A, B, and Bin
          D, Bout: out std_logic  -- Outputs: D and Bout
      );
   end component;

begin
   -- Instantiate Full Subtractor component and connect signals
   add_instance: Full_Subtractor 
       port map (
           -- Inputs: Bin, B, A (order as per comment)
           Bin => input_vector(0),  -- Bit 0 of input_vector is Bin
           B   => input_vector(1),  -- Bit 1 of input_vector is B
           A   => input_vector(2),  -- Bit 2 of input_vector is A
           -- Outputs: D, Bout (order as per comment)
           D => output_vector(1),  -- Bit 1 of output_vector is D
           Bout => output_vector(0)  -- Bit 0 of output_vector is Bout
       );

end DutWrap;
