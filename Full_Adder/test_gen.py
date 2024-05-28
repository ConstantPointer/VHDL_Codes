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
