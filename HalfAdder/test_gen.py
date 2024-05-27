#!/usr/bin/env python
# coding: utf-8

# In[2]:


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


# In[ ]:




