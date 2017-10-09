library verilog;
use verilog.vl_types.all;
entity decoder7_vlg_check_tst is
    port(
        \Out\           : in     vl_logic_vector(6 downto 0);
        sampler_rx      : in     vl_logic
    );
end decoder7_vlg_check_tst;
