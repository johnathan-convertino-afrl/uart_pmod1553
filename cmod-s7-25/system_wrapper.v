// ***************************************************************************
// ***************************************************************************
//
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module system_wrapper #(
  parameter clock_speed = 2000000,
  parameter baud_rate = 1000000,
  parameter mil1553_sample_rate = 2000000
  )
  (
  // clock and reset
  input           clk,
  // general io
  input   [1:0]   push_buttons,
  // 1553
  inout   [7:0]   pmod_ja,
  // uart
  input           ftdi_tx,
  output          ftdi_rx
  );

  wire sys_clk;
  wire reset;
  wire resetn;
  
  clk_wiz_1 inst_clk_wiz_1 (
    .clk_out1(sys_clk),
    .reset(push_buttons[0]),
    .clk_in1(clk)
  );

  sys_rstgen inst_sys_rstgen (
    .slowest_sync_clk(sys_clk),
    .ext_reset_in(1'b1),
    .aux_reset_in(push_buttons[0]),
    .mb_debug_sys_rst(1'b0),
    .dcm_locked(1'b1),
    .mb_reset(),
    .bus_struct_reset(),
    .peripheral_reset(reset),
    .interconnect_aresetn(),
    .peripheral_aresetn(resetn)
  );

  uart_1553_core #(
    .clock_speed(clock_speed),
    .uart_baud_clock_speed(clock_speed),
    .uart_baud_rate(baud_rate),
    .uart_parity_ena(0),
    .uart_parity_type(0),
    .uart_stop_bits(1),
    .uart_data_bits(8),
    .uart_rx_delay(0),
    .uart_tx_delay(0),
    .mil1553_sample_rate(mil1553_sample_rate),
    .mil1553_rx_bit_slice_offset(0),
    .mil1553_rx_invert_data(0),
    .mil1553_rx_sample_select(0)
  ) inst_uart_1553_core (
    //master clock and reset.
    .aclk(sys_clk),
    .arstn(resetn),
    //uart clocks
    .uart_clk(sys_clk),
    .uart_rstn(resetn),
    //uart i/o
    .rx_UART(ftdi_tx),
    .tx_UART(ftdi_rx),
    .rts_UART(),
    .cts_UART(1'b1),
    //1553
    .rx0_1553(pmod_ja[0]),
    .rx1_1553(pmod_ja[1]),
    .tx0_1553(pmod_ja[2]),
    .tx1_1553(pmod_ja[3]),
    .en_tx_1553(pmod_ja[4])
  );

endmodule
