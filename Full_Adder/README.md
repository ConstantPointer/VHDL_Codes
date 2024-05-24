# Full Adder in VHDL

This repository contains the VHDL implementation of a full adder along with its testbench. The full adder is a basic combinational circuit that performs the arithmetic sum of three input bits: A, B, and Cin (carry-in). The testbench is designed to verify the correctness of the full adder by simulating various input combinations and checking the outputs.

## Repository Structure

- *src*: Contains the VHDL code for the full adder.
  - `full_adder.vhdl`: VHDL file implementing the full adder.
- *testbench*: Contains the VHDL code for the testbench.
  - `testbench.vhdl`: VHDL file for the testbench to test the full adder.

## Full Adder

The full adder takes three input bits and produces a sum bit and a carry-out bit according to the following logic:

- Inputs: `A`, `B`, `Cin`
- Outputs: `Sum`, `Cout`

### Truth Table

| A | B | Cin | Sum | Cout |
|---|---|-----|-----|------|
| 0 | 0 |  0  |  0  |   0  |
| 0 | 0 |  1  |  1  |   0  |
| 0 | 1 |  0  |  1  |   0  |
| 0 | 1 |  1  |  0  |   1  |
| 1 | 0 |  0  |  1  |   0  |
| 1 | 0 |  1  |  0  |   1  |
| 1 | 1 |  0  |  0  |   1  |
| 1 | 1 |  1  |  1  |   1  |

## Testbench

The testbench (`testbench.vhdl`) is designed to apply a series of test vectors to the full adder and verify its output. It includes:

- Test vectors for all possible combinations of inputs `A`, `B`, and `Cin`.
- Assertions to check the correctness of the `Sum` and `Cout` outputs.
