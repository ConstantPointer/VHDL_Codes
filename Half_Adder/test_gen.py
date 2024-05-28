# Python code for TRACEFILE.txt generation for HALF-ADDER
# Open/create TRACEFILE.txt in write mode
f = open("TRACEFILE.txt", "w")

# Number of inputs
input_len = 2

# Number of outputs
output_len = 2

# Number of test vectors
test_len = 2 ** input_len

# Loop from 0 to (test_len-1)
for input_vec in range(test_len):
    # Convert input to binary (2-bit) format
    input_str = "{:02b}".format(int(input_vec))

    # Extracting the input bits
    a = (input_vec >> 1) & 1
    b = input_vec & 1

    # Generating the output
    S = a ^ b
    C = a & b
    output = (C << 1) | S

    # Convert output to binary (2-bit) format
    output_str = "{:02b}".format(int(output))

    # Write input and output test vector with 2-bit mask in TRACEFILE.txt
    f.write(input_str + " " + output_str + " 11\n")

# Close file
f.close()

# Alternate python code to produce the same result choose according to your preference

# Python code for TRACEFILE.txt generation for HALF-ADDER

# Function to convert decimal to binary with fixed length
# def dec_to_bin(num, length):
#     return format(num, f'0{length}b')

# # Main function to generate the trace file
# def generate_tracefile():
#     output_file = "TRACEFILE_HalfAdder.txt"
#     input_len = 2  # Input vector length for HALF-ADDER (2 inputs: a, b)
#     output_len = 2 # Output vector length for HALF-ADDER (2 outputs: sum, carry)
#     test_len = 2 ** input_len  # Total number of test vectors (exhaustive)

#     with open(output_file, "w") as optr:
#         for i in range(test_len):
#             input_bin = dec_to_bin(i, input_len)  # Get input in binary form

#             # Separate the inputs
#             a = int(input_bin[0])
#             b = int(input_bin[1])

#             # Perform the half adder operation (sum and carry)
#             sum_bit = a ^ b           # Sum bit
#             carry_bit = a & b         # Carry bit

#             # Combine carry and sum into a single binary number
#             output_bin = f'{carry_bit}{sum_bit}'

#             # Mask bits (equal to number of output bits)
#             mask = "11"

#             # Write input, output, and mask to the trace file
#             optr.write(f'{input_bin} {output_bin} {mask}\n')

# # Run the main function
# if __name__ == "__main__":
#     generate_tracefile()
