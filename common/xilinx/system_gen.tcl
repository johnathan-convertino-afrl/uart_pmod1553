# set freq hz of the clk to 48MHz, and set verilog parameter of top level.
set_property CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {48} [get_ips clk_wiz_1]
set CLK_FREQ_MHZ [get_property CONFIG.CLKOUT1_REQUESTED_OUT_FREQ [get_ips clk_wiz_1]]
set_property generic clock_speed=[ expr $CLK_FREQ_MHZ * 1000000 ] [current_fileset]
generate_target all [get_ips]
