library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench is
-- empty
end testbench;

architecture tb of testbench is
    signal a, b, C_in: bit;
    signal sum, C_out: bit;

    component FullAdder is
        port (a, b, C_in: in bit;
              sum, C_out: out bit);
    end component FullAdder;

begin
    uut: FullAdder
        port map (a => a,
                  b => b,
                  C_in => C_in,
                  sum => sum,
                  C_out => C_out);

    stim_proc: process
    begin
        -- Test case 1: 0 + 0 + 0
        a <= '0'; b <= '0'; C_in <= '0';
        wait for 10 ns;
        
        -- Test case 2: 0 + 0 + 1
        a <= '0'; b <= '0'; C_in <= '1';
        wait for 10 ns;
        
        -- Test case 3: 0 + 1 + 0
        a <= '0'; b <= '1'; C_in <= '0';
        wait for 10 ns;
        
        -- Test case 4: 0 + 1 + 1
        a <= '0'; b <= '1'; C_in <= '1';
        wait for 10 ns;
        
        -- Test case 5: 1 + 0 + 0
        a <= '1'; b <= '0'; C_in <= '0';
        wait for 10 ns;
        
        -- Test case 6: 1 + 0 + 1
        a <= '1'; b <= '0'; C_in <= '1';
        wait for 10 ns;
        
        -- Test case 7: 1 + 1 + 0
        a <= '1'; b <= '1'; C_in <= '0';
        wait for 10 ns;
        
        -- Test case 8: 1 + 1 + 1
        a <= '1'; b <= '1'; C_in <= '1';
        wait for 10 ns;

        -- End of simulation
        wait;
    end process;
end architecture tb;

