#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

// File pointer as global variable
FILE *optr;

// Function prototypes
void dec_to_bin(long long num, int len); // Function to convert decimal to binary and print in TRACEFILE.txt
int bin_to_dec(long long num);           // Function to convert binary to decimal for inputs

// Function definition for decimal to binary conversion
void dec_to_bin(long long num, int len)
{
    // Array to store binary values (initial length set to 20, change it according to your design)
    int bin[20];
    int rem, i, j;
    i = 0;

    // Simple binary conversion, pen paper logic
    while (num != 0)
    {
        rem = num % 2;
        num /= 2;
        bin[i] = rem;
        ++i;
    }

    // Print binary values with MSB first (padded with extra 0s)
    for (j = len - 1; j >= 0; j--)
    {
        if (j < i)
            fprintf(optr, "%d", bin[j]);
        else
            fprintf(optr, "0");
    }
}

// Function definition for binary to decimal conversion
int bin_to_dec(long long num)
{
    int i, dec, rem;
    dec = 0;
    i = 0;
    // Simple digit extraction logic
    while (num != 0)
    {
        rem = num % 10;
        num /= 10;
        dec += rem * pow(2, i);
        ++i;
    }
    return dec;
}

// Logic gate functions
void nand_2(int A, int B, int *Y) {
    *Y = !(A && B);
}

void and_2(int A, int B, int *Y) {
    *Y = A && B;
}

void or_2(int A, int B, int *Y) {
    *Y = A || B;
}

void xor_2(int A, int B, int *Y) {
    *Y = A ^ B;
}

void xnor_2(int A, int B, int *Y) {
    *Y = !(A ^ B);
}

// Half-adder functions
void half_adder(int A, int B, int *sum, int *carry) {
    *sum = A ^ B;
    *carry = A & B;
}

int main()
{
    char output_file[20];
    int input_len, output_len, test_len;
    int i, A, B, nand_out, and_out, or_out, xor_out, xnor_out, sum, carry;

    // Name the tracefile
    strcpy(output_file, "TRACEFILE.txt");
    // Open TRACEFILE.txt in write mode
    optr = fopen(output_file, "w");

    // Input and output vector length for 2-input gates
    input_len = 2;
    output_len = 1;
    // Total number of test vectors (exhaustive) = 2^(number of input bits)
    test_len = pow(2, input_len);

    // Run loop for all possible combinations of input for each gate
    for (i = 0; i < test_len; i++) {
        // Separate the inputs (binary form)
        A = (i / 2) % 2;    // Extract bit A
        B = i % 2;          // Extract bit B

        // Perform the gate operations
        nand_2(A, B, &nand_out);
        and_2(A, B, &and_out);
        or_2(A, B, &or_out);
        xor_2(A, B, &xor_out);
        xnor_2(A, B, &xnor_out);
        
        // Perform half-adder operation
        half_adder(A, B, &sum, &carry);

        // Print input in "TRACEFILE.txt" (in binary)
        dec_to_bin(i, input_len);

        // Single space
        fprintf(optr, " ");

        // Print outputs for all gates and half-adder in "TRACEFILE.txt" (in binary)
        dec_to_bin(sum, output_len);        // Sum bit (MSB)
        dec_to_bin(carry, output_len);      // Carry bit (second MSB)
        dec_to_bin(xnor_out, output_len);   // XNOR output (third MSB)
        dec_to_bin(xor_out, output_len);    // XOR output
        dec_to_bin(or_out, output_len);     // OR output
        dec_to_bin(and_out, output_len);    // AND output
        dec_to_bin(nand_out, output_len);   // NAND output (LSB)

        // Single space
        fprintf(optr, " ");

        // Mask bits (equal to number of output bits)
        for (int j = 0; j < 7; j++) {
            fprintf(optr, "1");
        }

        // Change line
        fprintf(optr, "\n");
    }

    // Close file (TRACEFILE.txt)
    fclose(optr);
    return 0;
}
