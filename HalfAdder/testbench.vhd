--library std;
--use std.textio.all;
--
--library ieee;
--use ieee.std_logic_1164.all;
--
--entity Testbench is
--end entity;
--
--architecture Behave of Testbench is
--    ----------------------------------------------------------------
--    --  Edit the following lines to set the number of I/O's of your DUT.
--    ----------------------------------------------------------------
--    constant number_of_inputs  : integer := 2;  -- # input bits to your design.
--    constant number_of_outputs : integer := 2;  -- # output bits from your design.
--    ----------------------------------------------------------------
--
--    component DUT is
--        port(
--            input_vector: in std_logic_vector(number_of_inputs-1 downto 0);
--            output_vector: out std_logic_vector(number_of_outputs-1 downto 0)
--        );
--    end component;
--
--    signal input_vector  : std_logic_vector(number_of_inputs-1 downto 0);
--    signal output_vector : std_logic_vector(number_of_outputs-1 downto 0);
--
--    -- Bit-vector to std-logic-vector and vice-versa
--    function to_std_logic_vector(x: bit_vector) return std_logic_vector is
--        alias lx: bit_vector(1 to x'length) is x;
--        variable ret_val: std_logic_vector(1 to x'length);
--    begin
--        for i in 1 to x'length loop
--            if lx(i) = '1' then
--                ret_val(i) := '1';
--            else
--                ret_val(i) := '0';
--            end if;
--        end loop; 
--        return ret_val;
--    end to_std_logic_vector;
--
--    function to_bit_vector(x: std_logic_vector) return bit_vector is
--        alias lx: std_logic_vector(1 to x'length) is x;
--        variable ret_val: bit_vector(1 to x'length);
--    begin
--        for i in 1 to x'length loop
--            if lx(i) = '1' then
--                ret_val(i) := '1';
--            else
--                ret_val(i) := '0';
--            end if;
--        end loop; 
--        return ret_val;
--    end to_bit_vector;
--
--begin
--    process 
--        variable err_flag : boolean := false;
--        file INFILE: text open read_mode is "TRACEFILE.txt";
--        file OUTFILE: text open write_mode is "outputs.txt";
--
--        variable input_vector_var: bit_vector (number_of_inputs-1 downto 0);
--        variable output_vector_var: bit_vector (number_of_outputs-1 downto 0);
--        variable output_mask_var: bit_vector (number_of_outputs-1 downto 0);
--
--        variable output_comp_var: std_logic_vector (number_of_outputs-1 downto 0);
--        constant ZZZZ : std_logic_vector(number_of_outputs-1 downto 0) := (others => '0');
--
--        variable INPUT_LINE: line;
--        variable OUTPUT_LINE: line;
--        variable LINE_COUNT: integer := 0;
--
--    begin
--        while not endfile(INFILE) loop 
--            -- Read a new line every 10 ns, apply input, wait for 1 ns for circuit to settle, read output.
--            LINE_COUNT := LINE_COUNT + 1;
--
--            -- Read input at current time
--            readline(INFILE, INPUT_LINE);
--            read(INPUT_LINE, input_vector_var);
--            read(INPUT_LINE, output_vector_var);
--            read(INPUT_LINE, output_mask_var);
--
--            -- Apply input
--            input_vector <= to_std_logic_vector(input_vector_var);
--
--            -- Wait for the circuit to settle 
--            wait for 10 ns;
--
--            -- Check output
--            output_comp_var := (to_std_logic_vector(output_mask_var) and 
--                                (output_vector xor to_std_logic_vector(output_vector_var)));
--            if output_comp_var /= ZZZZ then
--                write(OUTPUT_LINE, string'("ERROR: line "));
--                write(OUTPUT_LINE, LINE_COUNT);
--                writeline(OUTFILE, OUTPUT_LINE);
--                err_flag := true;
--            end if;
--
--            write(OUTPUT_LINE, to_bit_vector(input_vector));
--            write(OUTPUT_LINE, string'(" "));
--            write(OUTPUT_LINE, to_bit_vector(output_vector));
--            writeline(OUTFILE, OUTPUT_LINE);
--
--            -- Advance time by 4 ns
--            wait for 4 ns;
--        end loop;
--
--        assert (err_flag) report "FAILURE, some tests failed." severity error;
--        assert (not err_flag) report "SUCCESS, all tests passed." severity note;
--
--        wait;
--    end process;
--
--    dut_instance: DUT 
--        port map(input_vector => input_vector, output_vector => output_vector);
--
--end Behave;
--
library std;
use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;

entity Testbench is
end entity;

architecture Behave of Testbench is
    ----------------------------------------------------------------
    --  Edit the following lines to set the number of I/O's of your DUT.
    ----------------------------------------------------------------
    constant number_of_inputs  : integer := 2;  -- # input bits to your design.
    constant number_of_outputs : integer := 2;  -- # output bits from your design.
    ----------------------------------------------------------------

    component DUT is
        port(
            input_vector: in std_logic_vector(number_of_inputs-1 downto 0);
            output_vector: out std_logic_vector(number_of_outputs-1 downto 0)
        );
    end component;

    signal input_vector  : std_logic_vector(number_of_inputs-1 downto 0);
    signal output_vector : std_logic_vector(number_of_outputs-1 downto 0);

    -- Bit-vector to std-logic-vector and vice-versa
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
    process 
        variable err_flag : boolean := false;
        file INFILE: text open read_mode is "TRACEFILE.txt";
        file OUTFILE: text open write_mode is "outputs.txt";

        variable input_vector_var: bit_vector (number_of_inputs-1 downto 0);
        variable output_vector_var: bit_vector (number_of_outputs-1 downto 0);
        variable output_mask_var: bit_vector (number_of_outputs-1 downto 0);

        variable output_comp_var: std_logic_vector (number_of_outputs-1 downto 0);
        constant ZZZZ : std_logic_vector(number_of_outputs-1 downto 0) := (others => '0');

        variable INPUT_LINE: line;
        variable OUTPUT_LINE: line;
        variable LINE_COUNT: integer := 0;

    begin
        while not endfile(INFILE) loop 
            -- Read a new line every 10 ns, apply input, wait for 1 ns for circuit to settle, read output.
            LINE_COUNT := LINE_COUNT + 1;

            -- Read input at current time
            readline(INFILE, INPUT_LINE);
            read(INPUT_LINE, input_vector_var);
            read(INPUT_LINE, output_vector_var);
            read(INPUT_LINE, output_mask_var);

            -- Apply input
            input_vector <= to_std_logic_vector(input_vector_var);

            -- Wait for the circuit to settle 
            wait for 10 ns;

            -- Check output
            output_comp_var := (to_std_logic_vector(output_mask_var) and 
                                (output_vector xor to_std_logic_vector(output_vector_var)));
            if output_comp_var /= ZZZZ then
                write(OUTPUT_LINE, string'("ERROR: line "));
                write(OUTPUT_LINE, LINE_COUNT);
                writeline(OUTFILE, OUTPUT_LINE);
                err_flag := true;
            end if;

            write(OUTPUT_LINE, to_bit_vector(input_vector));
            write(OUTPUT_LINE, string'(" "));
            write(OUTPUT_LINE, to_bit_vector(output_vector));
            writeline(OUTFILE, OUTPUT_LINE);

            -- Advance time by 4 ns
            wait for 4 ns;
        end loop;

        assert (err_flag) report "FAILURE, some tests failed." severity error;
        assert (not err_flag) report "SUCCESS, all tests passed." severity note;

        wait;
    end process;

    dut_instance: DUT 
        port map(input_vector => input_vector, output_vector => output_vector);

end Behave;
