#!/usr/bin/env python
# coding: utf-8

# In[3]:


import math

# Function to convert decimal to binary with fixed length
def dec_to_bin(num, length):
    return format(num, f'0{length}b')

# Function to perform NAND operation
def nand_2(A, B):
    return int(not (A and B))

# Function to perform AND operation
def and_2(A, B):
    return int(A and B)

# Function to perform OR operation
def or_2(A, B):
    return int(A or B)

# Function to perform XOR operation
def xor_2(A, B):
    return int(A ^ B)

# Function to perform XNOR operation
def xnor_2(A, B):
    return int(not (A ^ B))

# Function to perform half-adder operation
def half_adder(A, B):
    sum = xor_2(A, B)
    carry = and_2(A, B)
    return sum, carry

# Main function to generate the trace file
def generate_tracefile():
    output_file = "TRACEFILE.txt"
    input_len = 2  # Input vector length for 2-input gates
    output_len = 1 # Output vector length for 2-input gates
    test_len = 2 ** input_len  # Total number of test vectors (exhaustive)
    
    with open(output_file, "w") as optr:
        for i in range(test_len):
            input_bin = dec_to_bin(i, input_len)  # Get input in binary form

            # Separate the inputs
            A = int(input_bin[0])
            B = int(input_bin[1])

            # Perform the gate operations
            nand_out = nand_2(A, B)
            and_out = and_2(A, B)
            or_out = or_2(A, B)
            xor_out = xor_2(A, B)
            xnor_out = xnor_2(A, B)
            
            # Perform half-adder operation
            sum, carry = half_adder(A, B)

            # Combine all outputs in the required order
            outputs = [
                sum,        # Sum bit (MSB)
                carry,      # Carry bit (second MSB)
                xnor_out,   # XNOR output (third MSB)
                xor_out,    # XOR output
                or_out,     # OR output
                and_out,    # AND output
                nand_out    # NAND output (LSB)
            ]

            # Create the output binary string
            output_bin = ''.join(dec_to_bin(out, output_len) for out in outputs)

            # Mask bits (equal to number of output bits)
            mask = "1" * len(outputs)

            # Write input, output, and mask to the trace file
            optr.write(f'{input_bin} {output_bin} {mask}\n')

# Run the main function
if __name__ == "__main__":
    generate_tracefile()



# Open/create TRACEFILE.txt in write mode
f = open("TRACEFILE.txt", "w")

# Number of inputs
input_len = 2

# Number of outputs
output_len = 1

# Number of test vectors (2^input_len)
test_len = 2 ** input_len

# Loop through all possible input vectors (from 0 to test_len-1)
for input_vec in range(test_len):
    # Convert input to binary (2-bit) format
    input_str = "{:02b}".format(input_vec)
    
    # Extract individual input bits
    a = (input_vec >> 1) & 1  # Most significant bit
    b = input_vec & 1         # Least significant bit
    
    # Calculate outputs for gates
    nand_output = int(not (a & b))
    and_output = a & b
    or_output = a | b
    xor_output = a ^ b
    xnor_output = int(not (a ^ b))
    
    # Calculate outputs for half-adder
    sum_output = xor_output
    carry_output = and_output
    
    # Combine all outputs in the required order
    # sum as MSB, carry as second MSB, XNOR as third MSB, and so on.
    outputs = [
        sum_output,   # Sum bit (MSB)
        carry_output, # Carry bit (second MSB)
        xnor_output,  # XNOR output (third MSB)
        xor_output,   # XOR output
        or_output,    # OR output
        and_output,   # AND output
        nand_output   # NAND output (LSB)
    ]
    
    # Create the output binary string
    output_str = ''.join(str(out) for out in outputs)

    # Mask bits (equal to number of output bits)
    mask = "1" * len(outputs)

    # Write input, output, and mask to the trace file
    f.write(f"{a}{b} {output_str} {mask}\n")

# Close the file
f.close()




