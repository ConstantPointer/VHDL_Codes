library ieee;
use ieee.std_logic_1164.all;

entity DUT is
    port (
        input_vector: in std_logic_vector(1 downto 0); -- 2-bit input vector for each gate
        output_vector: out std_logic_vector(6 downto 0) -- 1-bit output for each of the 5 gates
    );
end entity DUT;

architecture DutWrap of DUT is
    component NAND_2 is
        port (A, B: in std_logic; Y: out std_logic);
    end component NAND_2;

    component AND_2 is
        port (A, B: in std_logic; Y: out std_logic);
    end component AND_2;

    component OR_2 is
        port (A, B: in std_logic; Y: out std_logic);
    end component OR_2;

    component XOR_2 is
        port (A, B: in std_logic; Y: out std_logic);
    end component XOR_2;

    component XNOR_2 is
        port (A, B: in std_logic; Y: out std_logic);
    end component XNOR_2;
	 
    component Half_adder is
        port (A, B: in std_logic; S,C: out std_logic);
    end component Half_adder;
begin
    -- Mapping input vector to the NAND gate
    U_NAND_1: NAND_2
        port map (
            A => input_vector(1),
            B => input_vector(0),
            Y => output_vector(0)
        );

    -- Mapping input vector to the AND gate
    U_AND_1: AND_2
        port map (
            A => input_vector(1),
            B => input_vector(0),
            Y => output_vector(1)
        );

    -- Mapping input vector to the OR gate
    U_OR_1: OR_2
        port map (
            A => input_vector(1),
            B => input_vector(0),
            Y => output_vector(2)
        );

    -- Mapping input vector to the XOR gate
    U_XOR_1: XOR_2
        port map (
            A => input_vector(1),
            B => input_vector(0),
            Y => output_vector(3)
        );

    -- Mapping input vector to the XNOR gate
    U_XNOR_1: XNOR_2
        port map (
            A => input_vector(1),
            B => input_vector(0),
            Y => output_vector(4)
        );
	 U_HA_1: Half_adder
        port map (
            A => input_vector(1),
            B => input_vector(0),
            S => output_vector(6),
				C => output_vector(5)
        );

end DutWrap;
