--library ieee;
--use ieee.std_logic_1164.all;
--entity DUT is 
--  port(
--  in_vector:in std_logic_vector(1 downto 0);
--  out_vector:out std_logic_vector(1 downto 0)
--);
--end entity DUT;
--architecture DUTWRAP of DUT is 
--component Half_adder is 
--  port (
--    A,B:in std_logic;
--    S,C:out std_logic
--  );
--end component Half_adder;
--begin
--  HA:Half_adder
--  port map (A=>in_vector(0),B=>in_vector(1),S=>out_vector(0),C=>out_vector(1));
--end architecture DUTWRAP;
library ieee;
use ieee.std_logic_1164.all;

entity DUT is 
    port(
        input_vector: in std_logic_vector(1 downto 0);
        output_vector: out std_logic_vector(1 downto 0)
    );
end entity DUT;

architecture DUTWRAP of DUT is 
    component half_adder is 
        port(A, B: in std_logic; S, C: out std_logic);
    end component half_adder;
begin
    HA: half_adder
        port map(
            A => input_vector(0),
            B => input_vector(1),
            S => output_vector(0),
            C => output_vector(1)
        );
end architecture DUTWRAP;
