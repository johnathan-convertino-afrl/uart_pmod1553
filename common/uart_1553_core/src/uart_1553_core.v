//******************************************************************************
//  file:     uart_1553_core.v
//
//  author:   JAY CONVERTINO
//
//  date:     2021/06/28
//
//  about:    Brief
//  Core that ties together all ips into a single uart to 1553 core.
//
//
//  license: License MIT
//  Copyright 2021 Jay Convertino
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
 * Module: uart_1553_core
 *
 * Core that ties together all ips into a single uart to 1553 core.
 *
 * Parameters:
 *
 * CLOCK_SPEED - Requested Master Clock Speed from clk wiz
 *
 * Ports:
 *
 * aclk       - Master Clock
 * arstn      - Base Reset
 * rx_UART    - UART RX input
 * tx_UART    - UART TX output
 * rx_diff    - MIL-STD-1553 receive
 * tx_diff    - MIL-STD-1553 transmit
 */
module uart_1553_core #(
    parameter CLOCK_SPEED = 2000000
  )
  (
    input         aclk,
    input         arstn,
    input         rx_UART,
    output        tx_UART,
    input  [1:0]  rx_diff,
    output [1:0]  tx_diff,
    output        tx_active
  );
  
  //decoder path
  //1553 decoder m_axis (data output)
  wire [15:0]   m1553_decoder_data;
  wire          m1553_decoder_valid;
  wire [ 5:0]   m1553_decoder_user;
  wire          m1553_decoder_ready;
  //decoder fifo m_axis (data output)
  wire [15:0]   mfifo_decoder_data;
  wire          mfifo_decoder_valid;
  wire [ 5:0]   mfifo_decoder_user;
  wire          mfifo_decoder_ready;
  //string encoder m_axis (data output)
  wire [167:0]  mstring_encoder_data;
  wire          mstring_encoder_valid;
  wire          mstring_encoder_ready;
  //data width converter (string to char) m_axis (data output)
  wire [ 7:0]   mstring_to_char_data;
  wire          mstring_to_char_valid;
  wire          mstring_to_char_ready;
  //fifo char data for string to char m_axis (data output)
  wire [ 7:0]   mout_char_fifo_data;
  wire          mout_char_fifo_valid;
  wire          mout_char_fifo_ready;
  
  //encoder path
  //uart m_axis (data output)
  wire [ 7:0]   muart_char_data;
  wire          muart_char_valid;
  wire          muart_char_ready;
  //fifo char data for tx uart m_axis (data output)
  wire [ 7:0]   min_char_fifo_data;
  wire          min_char_fifo_valid;
  wire          min_char_fifo_ready;
  //string builder m_axis (data output)
  wire [167:0]  mchar_to_string_data;
  wire          mchar_to_string_valid;
  wire          mchar_to_string_ready;
  //string decoder m_axis (data output)
  wire [15:0]   mstring_decoder_data;
  wire          mstring_decoder_valid;
  wire [ 7:0]   mstring_decoder_user;
  wire          mstring_decoder_ready;
  //fifo encoder
  wire [15:0]   mfifo_encoder_data;
  wire          mfifo_encoder_valid;
  wire [ 7:0]   mfifo_encoder_user;
  wire          mfifo_encoder_ready;
  
  // Group: Instantianted Modules
  
  // Module: decoder_fifo
  //
  // FIFO for decoder data output
  axis_fifo #(
    .FIFO_DEPTH  (256),
    .COUNT_WIDTH (0),
    .BUS_WIDTH   (2),
    .USER_WIDTH  (6),
    .DEST_WIDTH  (1),
    .RAM_TYPE    ("block"),
    .PACKET_MODE (0),
    .COUNT_DELAY (0),
    .COUNT_ENA   (0)
  ) decoder_fifo (
    .s_axis_aclk(aclk),
    .s_axis_arstn(arstn),
    .s_axis_tvalid(m1553_decoder_valid),
    .s_axis_tready(m1553_decoder_ready),
    .s_axis_tdata(m1553_decoder_data),
    .s_axis_tkeep(~0),
    .s_axis_tlast(0),
    .s_axis_tuser(m1553_decoder_user),
    .s_axis_tdest(0),
    .m_axis_aclk(aclk),
    .m_axis_arstn(arstn),
    .m_axis_tvalid(mfifo_decoder_valid),
    .m_axis_tready(mfifo_decoder_ready),
    .m_axis_tdata(mfifo_decoder_data),
    .m_axis_tkeep(),
    .m_axis_tlast(),
    .m_axis_tuser(mfifo_decoder_user),
    .m_axis_tdest(),
    .data_count_aclk(0),
    .data_count_arstn(0),
    .data_count()
  );
  
  // Module: string_encoder
  //
  // 1553 to string core
  axis_1553_string_encoder string_encoder
  (
    .aclk(aclk),
    .arstn(arstn),
    .s_axis_tdata(mfifo_decoder_data),
    .s_axis_tvalid(mfifo_decoder_valid),
    .s_axis_tuser(mfifo_decoder_user),
    .s_axis_tready(mfifo_decoder_ready),
    .m_axis_tdata(mstring_encoder_data),
    .m_axis_tvalid(mstring_encoder_valid),
    .m_axis_tready(mstring_encoder_ready)
  );
  
  // Module: string_to_char
  //
  // data width converter
  axis_data_width_converter #(
    .SLAVE_WIDTH(21),
    .MASTER_WIDTH(1),
    .REVERSE(1)
  ) string_to_char (
    .aclk(aclk),
    .arstn(arstn),
    .s_axis_tdata(mstring_encoder_data),
    .s_axis_tvalid(mstring_encoder_valid),
    .s_axis_tready(mstring_encoder_ready),
    .m_axis_tdata(mstring_to_char_data),
    .m_axis_tvalid(mstring_to_char_valid),
    .m_axis_tready(mstring_to_char_ready)
  );
  
  // Module: outgoing_char_fifo
  //
  // fifo for 1553 encoded into character string.
  axis_tiny_fifo #(
    .FIFO_DEPTH(4),
    .BUS_WIDTH(8)
  ) outgoing_char_fifo (
    .aclk(aclk),
    .arstn(arstn),
    .s_axis_tdata(mstring_to_char_data),
    .s_axis_tvalid(mstring_to_char_valid),
    .s_axis_tready(mstring_to_char_ready),
    .m_axis_tdata(mout_char_fifo_data),
    .m_axis_tvalid(mout_char_fifo_valid),
    .m_axis_tready(mout_char_fifo_ready)
  );
  
  // Module: string_to_char
  //
  // AXIS UART
  fast_axis_uart #(
    .CLOCK_SPEED(CLOCK_SPEED),
    .BAUD_RATE(115200),
    .PARITY_TYPE(0),
    .STOP_BITS(1),
    .DATA_BITS(8)
  ) axis_uart (
    .aclk(aclk),
    .arstn(arstn),
    .s_axis_tdata(mout_char_fifo_data),
    .s_axis_tvalid(mout_char_fifo_valid),
    .s_axis_tready(mout_char_fifo_ready),
    .m_axis_tdata(muart_char_data),
    .m_axis_tvalid(muart_char_valid),
    .m_axis_tready(muart_char_ready),
    .tx(tx_UART),
    .rx(rx_UART)
  );
  
  // Module: incomming_char_fifo
  //
  // fifo for chars to be decoded into 1553 data.
  axis_tiny_fifo #(
    .FIFO_DEPTH(4),
    .BUS_WIDTH(8)
  ) incomming_char_fifo (
    .aclk(aclk),
    .arstn(arstn),
    .s_axis_tdata(muart_char_data),
    .s_axis_tvalid(muart_char_valid),
    .s_axis_tready(muart_char_ready),
    .m_axis_tdata(min_char_fifo_data),
    .m_axis_tvalid(min_char_fifo_valid),
    .m_axis_tready(min_char_fifo_ready)
  );
  
  // Module: char_to_string
  //
  // data width converter
  axis_char_to_string_converter #(
    .master_width(21)
  ) char_to_string (
    .aclk(aclk),
    .arstn(arstn),
    .s_axis_tdata(min_char_fifo_data),
    .s_axis_tvalid(min_char_fifo_valid),
    .s_axis_tready(min_char_fifo_ready),
    .m_axis_tdata(mchar_to_string_data),
    .m_axis_tvalid(mchar_to_string_valid),
    .m_axis_tready(mchar_to_string_ready)
  );
  
  // Module: char_to_string
  //
  // string to 1553
  axis_1553_string_decoder string_decoder
  (
    .aclk(aclk),
    .arstn(arstn),
    .s_axis_tdata(mchar_to_string_data),
    .s_axis_tvalid(mchar_to_string_valid),
    .s_axis_tready(mchar_to_string_ready),
    .m_axis_tdata(mstring_decoder_data),
    .m_axis_tvalid(mstring_decoder_valid),
    .m_axis_tuser(mstring_decoder_user),
    .m_axis_tready(mstring_decoder_ready)
  );
  
  // Module: encoder_fifo
  //
  // fifo for decoder data
  axis_fifo #(
    .FIFO_DEPTH  (256),
    .COUNT_WIDTH (0),
    .BUS_WIDTH   (2),
    .USER_WIDTH  (6),
    .DEST_WIDTH  (1),
    .RAM_TYPE    ("block"),
    .PACKET_MODE (0),
    .COUNT_DELAY (0),
    .COUNT_ENA   (0)
  ) encoder_fifo (
    .s_axis_aclk(aclk),
    .s_axis_arstn(arstn),
    .s_axis_tvalid(mstring_decoder_valid),
    .s_axis_tready(mstring_decoder_ready),
    .s_axis_tdata(mstring_decoder_data),
    .s_axis_tkeep(~0),
    .s_axis_tlast(0),
    .s_axis_tuser(mstring_decoder_user),
    .s_axis_tdest(0),
    .m_axis_aclk(aclk),
    .m_axis_arstn(arstn),
    .m_axis_tvalid(mfifo_encoder_valid),
    .m_axis_tready(mfifo_encoder_ready),
    .m_axis_tdata(mfifo_encoder_data),
    .m_axis_tkeep(),
    .m_axis_tlast(),
    .m_axis_tuser(mfifo_encoder_user),
    .m_axis_tdest(),
    .data_count_aclk(0),
    .data_count_arstn(0),
    .data_count()
  );
  
  axis_1553 #(
    .CLOCK_SPEED(CLOCK_SPEED),
    .RX_BAUD_DELAY(0),
    .TX_BAUD_DELAY(0)
  ) inst_axis_1553 (
    .aclk(aclk),
    .arstn(arstn),
    .parity_err(m1553_decoder_user[5]),
    .frame_err(),
    .s_axis_tdata(mfifo_encoder_data),
    .s_axis_tuser(mfifo_encoder_user[4:0]),
    .s_axis_tvalid(mfifo_encoder_valid),
    .s_axis_tready(mfifo_encoder_ready),
    .m_axis_tdata(m1553_decoder_data),
    .m_axis_tuser(m1553_decoder_user[4:0]),
    .m_axis_tvalid(m1553_decoder_valid),
    .m_axis_tready(m1553_decoder_ready),
    .tx_active(tx_active),
    .tx_diff(tx_diff),
    .rx_diff(rx_diff)
  );

  
endmodule
