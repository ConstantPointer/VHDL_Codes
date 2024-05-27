// Test vector file generation using C language you can also use python to generate "TRACEFILE.txt
#include <stdio.h> 
#include <stdlib.h>
#include <string.h>
#include <math.h>

// file pointer as global
FILE *optr;

// user defined function to convert decimal to binary and print in TRACEFILE.txt
void dec_to_bin(long long num, int len);

// user defined function to convert binary to decimal for inputs
int bin_to_dec(long long num);

// function definition for decimal to binary conversion
void dec_to_bin(long long num, int len) {
    // array to store binary values (initial length set to 20, change it according to your design)
    int bin[20];
    int rem, i, j;
    i = 0;

    // simple binary conversion, pen paper logic
    while(num != 0) {
        rem = num % 2;
        num /= 2;
        bin[i] = rem;
        ++i;
    }

    // print binary values with MSB first (padded with extra 0s)
    for(j = len - 1; j >= 0; j--) {
        if(j < i)
            fprintf(optr, "%d", bin[j]);
        else
            fprintf(optr, "0");
    }
}

// function definition for binary to decimal conversion
int bin_to_dec(long long num) {
    int i, dec, rem;
    dec = 0;
    i = 0;
    // simple digit extraction logic
    while(num != 0) {
        rem = num % 10;
        num /= 10;
        dec += rem * pow(2, i);
        ++i;
    }
    return dec;
}

int main() {
    char output_file[20];
    int input_len, output_len, test_len;
    int i, a, b, output, input;
    
    // name the tracefile
    strcpy(output_file, "TRACEFILE.txt");
    // open TRACEFILE.txt in write mode
    optr = fopen(output_file, "w");

    // input and output vector length for HALF-SUBTRACTOR
    input_len = 2;
    output_len = 2;
    // total number of test vectors (exhaustive) = 2^(number of input bits)
    test_len = pow(2, input_len);

    // run loop for all possible combinations of input
    for(i = 0; i < test_len; i++) {
        input = i;
        // separate the inputs (binary form)
        a = (i >> 1) & 1;
        b = i & 1;

        // perform the operation (in decimal)
        int D= a ^ b;
        int BO = ((!a) & b);
        output = (BO << 1) | D;

        // print input in "TRACEFILE.txt" (in binary)
        dec_to_bin(input, input_len);

        // single space
        fprintf(optr, " ");

        // print output in "TRACEFILE.txt" (in binary)
        dec_to_bin(output, output_len);

        // single space
        fprintf(optr, " ");

        // mask bits (equal to number of output bits)
        fprintf(optr, "11");

        // change line
        fprintf(optr, "\n");
    }

    // close file (TRACEFILE.txt)
    fclose(optr);
    return 0;
}