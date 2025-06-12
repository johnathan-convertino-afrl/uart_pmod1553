//******************************************************************************
//  file:     system_wrapper.v
//
//  author:   JAY CONVERTINO
//
//  date:     2024/11/25
//
//  about:    Brief
//  System wrapper for pl
//
//  license: License MIT
//  Copyright 2024 Jay Convertino
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//******************************************************************************

`timescale 1ns/100ps

/*
 * Module: system_wrapper
 *
 * System wrapper for pl
 *
 * Parameters:
 *
 * clock_speed          - Requested Master Clock Speed from clk wiz
 * baud_rate            - UART BAUD rate
 * mil1553_sample_rate  - Sample rate for 1553, must be 2 MHz or above, and divide evenly into clock_speed.
 *
 * Ports:
 *
 * clk          - Input clock for all clocks
 * push_buttons - Buttons used for reset (push button 0).
 * pmod_ja      - 1553 PMOD device port (JA)
 * ftdi_tx      - FTDI UART input (TX)
 * ftdi_rx      - FTDI UART output (RX)
 */
module system_wrapper #(
  parameter clock_speed = 2000000,
  parameter mil1553_sample_rate = 2000000
  )
  (
  input           clk,
  input   [1:0]   push_buttons,
  inout   [7:0]   pmod_ja,
  input           ftdi_tx,
  output          ftdi_rx
  );

  wire sys_clk;
  wire reset;
  wire resetn;
  
  // Group: Instantianted Modules

  // Module: inst_clk_wiz_1
  //
  // Module instance of clock wizard to change input clock to requested clock speed.
  clk_wiz_1 inst_clk_wiz_1 (
    .clk_out1(sys_clk),
    .reset(push_buttons[0]),
    .clk_in1(clk)
  );

  // Module: inst_sys_rstgen
  //
  // Module instance of reset gen to create system reset.
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

  // Module: inst_uart_1553_core
  //
  // Module instance of the 1553 UART with all cores tied together as a common device.
  uart_1553_core #(
    .clock_speed(clock_speed),
    .mil1553_sample_rate(mil1553_sample_rate),
    .mil1553_rx_bit_slice_offset(0),
    .mil1553_rx_invert_data(0),
    .mil1553_rx_sample_select(0)
  ) inst_uart_1553_core (
    .aclk(sys_clk),
    .arstn(resetn),
    .rx_UART(ftdi_tx),
    .tx_UART(ftdi_rx),
    .rx0_1553(pmod_ja[0]),
    .rx1_1553(pmod_ja[1]),
    .tx0_1553(pmod_ja[2]),
    .tx1_1553(pmod_ja[3]),
    .en_tx_1553(pmod_ja[4])
  );

endmodule
