library ieee;  
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comp1 is
  port (
    x : in std_logic_vector(3 downto 0);
    y1 : in std_logic_vector(3 downto 0);
    y2 : in std_logic_vector(3 downto 0);
    y3 : in std_logic_vector(3 downto 0);
    y4 : in std_logic_vector(3 downto 0);
    y5 : in std_logic_vector(3 downto 0);
    y6 : in std_logic_vector(3 downto 0);
    y7 : in std_logic_vector(3 downto 0);
    y8 : in std_logic_vector(3 downto 0);
    o: out std_logic
  );
end entity comp1;

architecture rtl of comp1 is

--signal c: std_logic_vector(56 downto 0);

begin

o <='1' when (x=y1) else
    '1' when (x=y2) else
    '1' when (x=y3) else
    '1' when (x=y4) else
    '1' when (x=y5) else
    '1' when (x=y6) else
    '1' when (x=y7) else
    '1' when (x=y8) else
    '0';


end rtl;



library ieee;  
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.autils.all;

entity comp2 is
  port (
    x : in std_logic_vector(3 downto 0);
    y1 : in std_logic_vector(3 downto 0);
    y2 : in std_logic_vector(3 downto 0);
    y3 : in std_logic_vector(3 downto 0);
    y4 : in std_logic_vector(3 downto 0);
    y5 : in std_logic_vector(3 downto 0);
    y6 : in std_logic_vector(3 downto 0);
    y7 : in std_logic_vector(3 downto 0);
    y8 : in std_logic_vector(3 downto 0);
    y9 : in std_logic_vector(3 downto 0);
    y10 : in std_logic_vector(3 downto 0);
    y11 : in std_logic_vector(3 downto 0);
    y12 : in std_logic_vector(3 downto 0);
    y13 : in std_logic_vector(3 downto 0);
    y14 : in std_logic_vector(3 downto 0);
    y15 : in std_logic_vector(3 downto 0);
    y16 : in std_logic_vector(3 downto 0);
    o: out std_logic
  );
end entity comp2;

architecture rtl of comp2 is

--signal c: std_logic_vector(56 downto 0);

begin

o <='1' when (x=y1) else
    '1' when (x=y2) else
    '1' when (x=y3) else
    '1' when (x=y4) else
    '1' when (x=y5) else
    '1' when (x=y6) else
    '1' when (x=y7) else
    '1' when (x=y8) else
    '1' when (x=y9) else
    '1' when (x=y10) else
    '1' when (x=y11) else
    '1' when (x=y12) else
    '1' when (x=y13) else
    '1' when (x=y14) else
    '1' when (x=y15) else
    '1' when (x=y16) else
    '0';


end rtl;



library ieee;  
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.autils.all;

entity comp3 is
  port (
    x : in std_logic_vector(3 downto 0);
    y1 : in std_logic_vector(3 downto 0);
    y2 : in std_logic_vector(3 downto 0);
    y3 : in std_logic_vector(3 downto 0);
    y4 : in std_logic_vector(3 downto 0);
    y5 : in std_logic_vector(3 downto 0);
    y6 : in std_logic_vector(3 downto 0);
    y7 : in std_logic_vector(3 downto 0);
    y8 : in std_logic_vector(3 downto 0);
    y9 : in std_logic_vector(3 downto 0);
    y10 : in std_logic_vector(3 downto 0);
    y11 : in std_logic_vector(3 downto 0);
    y12 : in std_logic_vector(3 downto 0);
    y13 : in std_logic_vector(3 downto 0);
    y14 : in std_logic_vector(3 downto 0);
    y15 : in std_logic_vector(3 downto 0);
    y16 : in std_logic_vector(3 downto 0);
    y17 : in std_logic_vector(3 downto 0);
    y18 : in std_logic_vector(3 downto 0);
    y19 : in std_logic_vector(3 downto 0);
    y20 : in std_logic_vector(3 downto 0);
    y21 : in std_logic_vector(3 downto 0);
    y22 : in std_logic_vector(3 downto 0);
    y23 : in std_logic_vector(3 downto 0);
    y24 : in std_logic_vector(3 downto 0);
    y25 : in std_logic_vector(3 downto 0);
    y26 : in std_logic_vector(3 downto 0);
    y27 : in std_logic_vector(3 downto 0);
    y28 : in std_logic_vector(3 downto 0);
    y29 : in std_logic_vector(3 downto 0);
    y30 : in std_logic_vector(3 downto 0);
    y31 : in std_logic_vector(3 downto 0);
    y32 : in std_logic_vector(3 downto 0);
    o: out std_logic
  );
end entity comp3;

architecture rtl of comp3 is

--signal c: std_logic_vector(56 downto 0);

begin

o <='1' when (x=y1) else
    '1' when (x=y2) else
    '1' when (x=y3) else
    '1' when (x=y4) else
    '1' when (x=y5) else
    '1' when (x=y6) else
    '1' when (x=y7) else
    '1' when (x=y8) else
    '1' when (x=y9) else
    '1' when (x=y10) else
    '1' when (x=y11) else
    '1' when (x=y12) else
    '1' when (x=y13) else
    '1' when (x=y14) else
    '1' when (x=y15) else
    '1' when (x=y16) else
    '1' when (x=y17) else
    '1' when (x=y18) else
    '1' when (x=y19) else
    '1' when (x=y20) else
    '1' when (x=y21) else
    '1' when (x=y22) else
    '1' when (x=y23) else
    '1' when (x=y24) else
    '1' when (x=y25) else
    '1' when (x=y26) else
    '1' when (x=y27) else
    '1' when (x=y28) else
    '1' when (x=y29) else
    '1' when (x=y30) else
    '1' when (x=y31) else
    '1' when (x=y32) else
    '0';

end rtl;


