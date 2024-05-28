library std;  -- Standard library
use std.textio.all;  -- Import text input-output functions

library ieee;  -- IEEE library for standard logic types
use ieee.std_logic_1164.all;  -- Use standard logic types

entity Testbench is
end entity;

architecture Behave of Testbench is
  -- Define the number of inputs and outputs for your DUT
  constant number_of_inputs  : integer := 3;  -- Number of input bits
  constant number_of_outputs : integer := 2;  -- Number of output bits

  -- Component declaration for the DUT
  component DUT is
    port (
      input_vector: in std_logic_vector(number_of_inputs-1 downto 0);
      output_vector: out std_logic_vector(number_of_outputs-1 downto 0)
    );
  end component;

  -- Signals for input and output vectors
  signal input_vector  : std_logic_vector(number_of_inputs-1 downto 0);
  signal output_vector : std_logic_vector(number_of_outputs-1 downto 0);

  -- Function to convert string to std_logic_vector
  function to_string(x: string) return string is
    variable ret_val: string(1 to x'length);
    alias lx : string (1 to x'length) is x;
  begin  
    ret_val := lx;
    return(ret_val);
  end to_string;

  -- Function to convert bit_vector to std_logic_vector
  function to_std_logic_vector(x: bit_vector) return std_logic_vector is
    alias lx: bit_vector(1 to x'length) is x;
    variable ret_val: std_logic_vector(1 to x'length);
  begin
    for I in 1 to x'length loop
      if lx(I) = '1' then
        ret_val(I) := '1';
      else
        ret_val(I) := '0';
      end if;
    end loop; 
    return ret_val;
  end to_std_logic_vector;

  -- Function to convert std_logic_vector to bit_vector
  function to_bit_vector(x: std_logic_vector) return bit_vector is
    alias lx: std_logic_vector(1 to x'length) is x;
    variable ret_val: bit_vector(1 to x'length);
  begin
    for I in 1 to x'length loop
      if lx(I) = '1' then
        ret_val(I) := '1';
      else
        ret_val(I) := '0';
      end if;
    end loop; 
    return ret_val;
  end to_bit_vector;

begin
  -- Testbench process
  process 
    variable err_flag : boolean := false;  -- Error flag
    File INFILE: text open read_mode is "TRACEFILE.txt";  -- Open input file
    FILE OUTFILE: text open write_mode is "outputs.txt";  -- Open output file

    -- Variables for reading input/output vectors from file
    variable input_vector_var: bit_vector (number_of_inputs-1 downto 0);
    variable output_vector_var: bit_vector (number_of_outputs-1 downto 0);
    variable output_mask_var: bit_vector (number_of_outputs-1 downto 0);
    variable output_comp_var: std_logic_vector (number_of_outputs-1 downto 0);
    constant ZZZZ : std_logic_vector(number_of_outputs-1 downto 0) := (others => '0');
    variable INPUT_LINE: Line;
    variable OUTPUT_LINE: Line;
    variable LINE_COUNT: integer := 0;
  begin
    -- Main loop for testbench
    while not endfile(INFILE) loop 
      LINE_COUNT := LINE_COUNT + 1;

      -- Read input from file
      readLine (INFILE, INPUT_LINE);
      read (INPUT_LINE, input_vector_var);
      read (INPUT_LINE, output_vector_var);
      read (INPUT_LINE, output_mask_var);
      
      -- Apply input
      input_vector <= to_std_logic_vector(input_vector_var);

      -- Wait for the circuit to settle 
      wait for 10 ns;

      -- Check output
      output_comp_var := (to_std_logic_vector(output_mask_var) and 
                          (output_vector xor to_std_logic_vector(output_vector_var)));
      if output_comp_var  /= ZZZZ then
        write(OUTPUT_LINE, to_string("ERROR: line "));
        write(OUTPUT_LINE, LINE_COUNT);
        writeline(OUTFILE, OUTPUT_LINE);
        err_flag := true;
      end if;

      write(OUTPUT_LINE, to_bit_vector(input_vector));
      write(OUTPUT_LINE, to_string(" "));
      write(OUTPUT_LINE, to_bit_vector(output_vector));
      writeline(OUTFILE, OUTPUT_LINE);

      -- Advance time by 4 ns
      wait for 4 ns;
    end loop;

    -- Check if any errors occurred during the test
    assert (err_flag) report "SUCCESS, all tests passed." severity note;
    assert (not err_flag) report "FAILURE, some tests failed." severity error;

    wait;
  end process;

  -- Instantiate DUT and connect signals
  dut_instance: DUT 
    port map(input_vector => input_vector, output_vector => output_vector);

end architecture Behave;
