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

int main()
{
    char output_file[20];
    int input_len, output_len, test_len;
    int i, a, b, cin, sum, cout, input;

    // Name the tracefile
    strcpy(output_file, "TRACEFILE.txt");
    // Open TRACEFILE.txt in write mode
    optr = fopen(output_file, "w");

    // Input and output vector length for FULL-ADDER
    input_len = 3;
    output_len = 2;
    // Total number of test vectors (exhaustive) = 2^(number of input bits)
    test_len = pow(2, input_len);

    // Run loop for all possible combinations of input
    for (i = 0; i < test_len; i++)
    {
        input = i;
        // Separate the inputs (binary form)
        a = (i / 4) % 2;    // Extract bit A
        b = (i / 2) % 2;    // Extract bit B
        cin = i % 2;        // Extract Carry-in bit

        // Perform the full adder operation (sum and carry-out)
        sum = (a ^ b) ^ cin;       // Sum bit
        cout = (a & b) | (cin & (a ^ b)); // Carry-out bit

        // Print input in "TRACEFILE.txt" (in binary)
        dec_to_bin(input, input_len);

        // Single space
        fprintf(optr, " ");

        // Combine sum and carry-out for output
        int output = (cout << 1) | sum;

        // Print output in "TRACEFILE.txt" (in binary)
        dec_to_bin(output, output_len);

        // Single space
        fprintf(optr, " ");

        // Mask bits (equal to number of output bits)
        fprintf(optr, "11");

        // Change line
        fprintf(optr, "\n");
    }

    // Close file (TRACEFILE.txt)
    fclose(optr);
    return 0;
}
