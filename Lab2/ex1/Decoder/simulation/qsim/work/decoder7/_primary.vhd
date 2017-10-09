library verilog;
use verilog.vl_types.all;
entity decoder7 is
    port(
        \In\            : in     vl_logic_vector(3 downto 0);
        \Out\           : out    vl_logic_vector(6 downto 0);
        Clk             : in     vl_logic
    );
end decoder7;
