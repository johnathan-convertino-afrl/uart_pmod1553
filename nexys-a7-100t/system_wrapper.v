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
 * CLOCK_SPEED          - Requested Master Clock Speed from clk wiz
 *
 * Ports:
 *
 * clk          - Input clock for all clocks
 * push_buttons - Buttons used for reset (push button 0).
 * pmod_ja      - 1553 PMOD device port (JA)
 * ftdi_tx      - FTDI UART input (TX)
 * ftdi_rx      - FTDI UART output (RX)
 * ftdi_rts     - FTDI Request To Send, input.
 * ftdi_cts     - FTDI Clear to send, output.
 */
module system_wrapper #(
  parameter CLOCK_SPEED = 2000000
  )
  (
  input           clk,
  input   [1:0]   push_buttons,
  inout   [7:0]   pmod_ja,
  input           ftdi_tx,
  output          ftdi_rx,
  input           ftdi_rts,
  output          ftdi_cts
  );
  
  assign ftdi_cts = ftdi_rts;

  wire sys_clk;
  wire resetn;
  
  // Group: Instantianted Modules

  // Module: inst_clk_wiz_1
  //
  // Module instance of clock wizard to change input clock to requested clock speed.
  clk_wiz_1 inst_clk_wiz_1 (
    .clk_out1(sys_clk),
    .clk_in1(clk)
  );

  // Module: inst_sys_rstgen
  //
  // Module instance of reset gen to create system reset.
  sys_rstgen inst_sys_rstgen (
    .slowest_sync_clk(sys_clk),
    .ext_reset_in(push_buttons[0]),
    .aux_reset_in(1'b1),
    .mb_debug_sys_rst(1'b0),
    .dcm_locked(1'b1),
    .mb_reset(),
    .bus_struct_reset(),
    .peripheral_reset(),
    .interconnect_aresetn(),
    .peripheral_aresetn(resetn)
  );

  // Module: inst_uart_1553_core
  //
  // Module instance of the 1553 UART with all cores tied together as a common device.
  uart_1553_core #(
    .CLOCK_SPEED(CLOCK_SPEED)
  ) inst_uart_1553_core (
    .aclk(sys_clk),
    .arstn(resetn),
    .rx_UART(ftdi_tx),
    .tx_UART(ftdi_rx),
    .tx_diff(pmod_ja[1:0]),
    .rx_diff(pmod_ja[3:2]),
    .tx_active(pmod_ja[4])
  );

endmodule
