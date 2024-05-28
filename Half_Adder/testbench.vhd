-- Standard library for text I/O operations
library std;
use std.textio.all;

-- IEEE library for standard logic types
library ieee;
use ieee.std_logic_1164.all;

-- Entity declaration for the testbench
entity Testbench is
end entity;

-- Architecture declaration for the testbench
architecture Behave of Testbench is

    -- Constants defining the number of input and output bits for the DUT
    constant number_of_inputs  : integer := 2;  -- # input bits to design.
    constant number_of_outputs : integer := 2;  -- # output bits from design.

    -- Component declaration for the Device Under Test (DUT)
    component DUT is
        port(
            input_vector: in std_logic_vector(number_of_inputs-1 downto 0);
            output_vector: out std_logic_vector(number_of_outputs-1 downto 0)
        );
    end component;

    -- Signals to connect to the DUT
    signal input_vector  : std_logic_vector(number_of_inputs-1 downto 0);
    signal output_vector : std_logic_vector(number_of_outputs-1 downto 0);

    -- Function to convert a bit_vector to a std_logic_vector
    function to_std_logic_vector(x: bit_vector) return std_logic_vector is
        alias lx: bit_vector(1 to x'length) is x;
        variable ret_val: std_logic_vector(1 to x'length);
    begin
        for i in 1 to x'length loop
            if lx(i) = '1' then
                ret_val(i) := '1';
            else
                ret_val(i) := '0';
            end if;
        end loop; 
        return ret_val;
    end to_std_logic_vector;

    -- Function to convert a std_logic_vector to a bit_vector
    function to_bit_vector(x: std_logic_vector) return bit_vector is
        alias lx: std_logic_vector(1 to x'length) is x;
        variable ret_val: bit_vector(1 to x'length);
    begin
        for i in 1 to x'length loop
            if lx(i) = '1' then
                ret_val(i) := '1';
            else
                ret_val(i) := '0';
            end if;
        end loop; 
        return ret_val;
    end to_bit_vector;

begin
    -- Main process for the testbench
    process 
        variable err_flag : boolean := false;  -- Flag to track errors
        file INFILE: text open read_mode is "TRACEFILE.txt";  -- Input file for test vectors
        file OUTFILE: text open write_mode is "outputs.txt";  -- Output file for results

        variable input_vector_var: bit_vector (number_of_inputs-1 downto 0);  -- Variable to store input vectors from file
        variable output_vector_var: bit_vector (number_of_outputs-1 downto 0);  -- Variable to store expected output vectors from file
        variable output_mask_var: bit_vector (number_of_outputs-1 downto 0);  -- Variable to store output mask from file

        variable output_comp_var: std_logic_vector (number_of_outputs-1 downto 0);  -- Variable for output comparison
        constant ZZZZ : std_logic_vector(number_of_outputs-1 downto 0) := (others => '0');  -- Constant for zero comparison

        variable INPUT_LINE: line;  -- Variable for reading input lines from file
        variable OUTPUT_LINE: line;  -- Variable for writing output lines to file
        variable LINE_COUNT: integer := 0;  -- Line counter for error reporting

    begin
        -- Loop until the end of the input file
        while not endfile(INFILE) loop 
            -- Increment line counter
            LINE_COUNT := LINE_COUNT + 1;

            -- Read input vector, expected output vector, and output mask from file
            readline(INFILE, INPUT_LINE);
            read(INPUT_LINE, input_vector_var);
            read(INPUT_LINE, output_vector_var);
            read(INPUT_LINE, output_mask_var);

            -- Apply input vector to the DUT
            input_vector <= to_std_logic_vector(input_vector_var);

            -- Wait for the circuit to settle
            wait for 10 ns;

            -- Compare actual output with expected output
            output_comp_var := (to_std_logic_vector(output_mask_var) and 
                                (output_vector xor to_std_logic_vector(output_vector_var)));
            if output_comp_var /= ZZZZ then
                -- Log error if outputs do not match
                write(OUTPUT_LINE, string'("ERROR: line "));
                write(OUTPUT_LINE, LINE_COUNT);
                writeline(OUTFILE, OUTPUT_LINE);
                err_flag := true;
            end if;

            -- Write input and output vectors to the output file
            write(OUTPUT_LINE, to_bit_vector(input_vector));
            write(OUTPUT_LINE, string'(" "));
            write(OUTPUT_LINE, to_bit_vector(output_vector));
            writeline(OUTFILE, OUTPUT_LINE);

            -- Advance time by 4 ns
            wait for 4 ns;
        end loop;

        -- Report results based on error flag
        assert (err_flag) report "FAILURE, some tests failed." severity error;
        assert (not err_flag) report "SUCCESS, all tests passed." severity note;

        wait;  -- Wait indefinitely to stop the process
    end process;

    -- Instantiate the DUT and connect signals
    dut_instance: DUT 
        port map(input_vector => input_vector, output_vector => output_vector);

end Behave;
