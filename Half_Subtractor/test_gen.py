# Python code for TRACEFILE.txt generation for HALF-SUBTRACTOR
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
    D= a ^ b
    BO = ((~a) & b)
    output = (BO << 1) | D

    # Convert output to binary (2-bit) format
    output_str = "{:02b}".format(int(output))

    # Write input and output test vector with 2-bit mask in TRACEFILE.txt
    f.write(input_str + " " + output_str + " 11\n")

# Close file
f.close()

# Alternate python code to produce the same result choose according to your preference

# Function to convert decimal to binary with fixed length
# def dec_to_bin(num, length):
#     return format(num, f'0{length}b')

# # Main function to generate the trace file
# def generate_tracefile():
#     output_file = "TRACEFILE_HalfSubtractor.txt"
#     input_len = 2  # Input vector length for HALF-SUBTRACTOR (2 inputs: a, b)
#     output_len = 2 # Output vector length for HALF-SUBTRACTOR (2 outputs: diff, borrow)
#     test_len = 2 ** input_len  # Total number of test vectors (exhaustive)

#     with open(output_file, "w") as optr:
#         for i in range(test_len):
#             input_bin = dec_to_bin(i, input_len)  # Get input in binary form

#             # Separate the inputs
#             a = int(input_bin[0])
#             b = int(input_bin[1])

#             # Perform the half subtractor operation (difference and borrow)
#             diff_bit = a ^ b          # Difference bit
#             borrow_bit = (not a) & b  # Borrow bit

#             # Combine borrow and difference into a single binary number
#             output_bin = f'{borrow_bit}{diff_bit}'

#             # Mask bits (equal to number of output bits)
#             mask = "11"

#             # Write input, output, and mask to the trace file
#             optr.write(f'{input_bin} {output_bin} {mask}\n')

# # Run the main function
# if __name__ == "__main__":
#     generate_tracefile()

