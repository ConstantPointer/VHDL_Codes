import math

# Function to convert decimal to binary with fixed length
def dec_to_bin(num, length):
    # Convert to binary and fill with leading zeros to match the required length
    return format(num, f'0{length}b')

# Function to convert binary to decimal
def bin_to_dec(binary_str):
    return int(binary_str, 2)

# Main function to generate the trace file
def generate_tracefile():
    output_file = "TRACEFILE.txt"
    input_len = 3  # Input vector length for FULL-ADDER
    output_len = 2 # Output vector length for FULL-ADDER
    test_len = 2 ** input_len  # Total number of test vectors (exhaustive)

    with open(output_file, "w") as optr:
        # Loop for all possible combinations of input
        for i in range(test_len):
            input_bin = dec_to_bin(i, input_len)  # Get input in binary form

            # Separate the inputs
            a = int(input_bin[0])
            b = int(input_bin[1])
            cin = int(input_bin[2])

            # Perform the full adder operation (sum and carry-out)
            sum_bit = (a ^ b) ^ cin           # Sum bit
            cout_bit = (a & b) | (cin & (a ^ b))  # Carry-out bit

            # Combine sum and carry-out for output
            output_bin = f'{cout_bit}{sum_bit}'

            # Mask bits (equal to number of output bits)
            mask = "11"

            # Write input, output, and mask to the trace file
            optr.write(f'{input_bin} {output_bin} {mask}\n')

# Run the main function
if __name__ == "__main__":
    generate_tracefile()


# Alternate python code to produce the same result choose according to your preference

# # Python code for TRACEFILE.txt generation for FULL-ADDER

# # Open/create TRACEFILE.txt in write mode
# f = open("TRACEFILE.txt", "w")

# # Number of inputs
# input_len = 3

# # Number of outputs
# output_len = 2

# # Number of test vectors (2^input_len)
# test_len = 2 ** input_len

# # Loop through all possible input vectors (from 0 to test_len-1)
# for input_vec in range(test_len):
#     # Convert input to binary (3-bit) format
#     input_str = "{:03b}".format(input_vec)
    
#     # Extract individual input bits
#     a = (input_vec >> 2) & 1  # Most significant bit
#     b = (input_vec >> 1) & 1  # Middle bit
#     cin = (input_vec) & 1     # Least significant bit
    
#     # Calculate sum and carry-out for the full adder
#     sum_bit = (a ^ b) ^ cin           # Sum bit
#     cout_bit = (a & b) | (cin & (a ^ b))  # Carry-out bit

#     # Combine carry-out and sum into a single binary number
#     output = (cout_bit << 1) | sum_bit
    
#     # Convert output to binary (2-bit) format
#     output_str = "{:02b}".format(output)
    
#     # Write input and output test vector with a 2-bit mask in TRACEFILE.txt
#     f.write(input_str + " " + output_str + " 11\n")

# # Close the file
# f.close()
