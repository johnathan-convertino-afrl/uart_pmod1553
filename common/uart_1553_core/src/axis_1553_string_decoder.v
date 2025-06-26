//******************************************************************************
//  file:     axis_1553_string_decoder.v
//
//  author:   JAY CONVERTINO
//
//  date:     2021/06/21
//
//  about:    Brief
//  Carrige return terminated string converted to 1553 data.
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
 * Module: axis_1553_string_decoder
 *
 * Carrige return terminated string converted to 1553 data.
 *
 * Parameters:
 *
 * byte_swap        - swap input byte order.
 *
 * Ports:
 *
 * aclk             - Master Clock
 * arstn            - Negative Reset
 * s_axis_tdata     - Input raw data
 * s_axis_tvalid    - Input raw data is valid
 * s_axis_tuser     - Input raw user field
 * s_axis_tready    - Input ready for characters
 * m_axis_tdata     - Output string.
 * m_axis_tvalid    - Output string is valid
 * m_axis_tlast     - Indicates output string termination
 * m_axis_tkeep     - What bytes are valid characters in the string.
 * m_axis_tready    - Is the next device ready for output?
 */
module axis_1553_string_decoder #(
    parameter byte_swap = 0
  )
  (
    input               aclk,
    input               arstn,
    input   [167:0]     s_axis_tdata,
    input               s_axis_tvalid,
    input   [20:0]      s_axis_tkeep,
    input               s_axis_tlast,
    output              s_axis_tready,
    output  [15:0]      m_axis_tdata,
    output              m_axis_tvalid,
    output  [ 5:0]      m_axis_tuser,
    input               m_axis_tready
  );
  
  wire [167:0] w_s_axis_tdata;

  reg p_m_axis_tready;
  reg force_s_axis_tready;

  reg [15:0] r_m_axis_tdata;
  reg        r_m_axis_tvalid;
  reg [ 5:0] r_m_axis_tuser;

  assign m_axis_tdata   = r_m_axis_tdata;
  assign m_axis_tvalid  = r_m_axis_tvalid;
  assign m_axis_tuser   = r_m_axis_tuser;
  
  genvar byte_swap_index;
  //generate wires for byte swapping
  generate
    if(byte_swap > 0) begin
      for(byte_swap_index = 0; byte_swap_index < 21; byte_swap_index = byte_swap_index + 1) begin
        assign w_s_axis_tdata[(8*(byte_swap_index+1))-1:8*byte_swap_index] = s_axis_tdata[167-(8*byte_swap_index):168-(8*(byte_swap_index+1))];
      end
    end else begin
      assign w_s_axis_tdata = s_axis_tdata;
    end
  endgenerate
  
  //core does its conversion in a single clock cycle, tready needs to be sent to
  //the block before it since no blocking is done here.
  assign s_axis_tready = m_axis_tready | force_s_axis_tready;
  
  always @(posedge aclk) begin
    if(arstn == 1'b0) begin
      r_m_axis_tdata    <= 0;
      r_m_axis_tvalid   <= 0;
      r_m_axis_tuser    <= 0;
      p_m_axis_tready <= 0;
      force_s_axis_tready <= 0;
    end else begin
        
        force_s_axis_tready <= 0;
        
        //when ready, 0 out data so we don't send out the same thing over and over.
        if(m_axis_tready == 1'b1) begin
          r_m_axis_tdata    <= 0;
          r_m_axis_tvalid   <= 0;
          r_m_axis_tuser    <= 0;
          //no valid data, so lets 0 out previous to allow a valid assert of data without ready to happen.
          p_m_axis_tready <= 0;
        end
        
        //decode data into bits, wait for the ready signel to be correct.
        if((s_axis_tvalid == 1'b1) && (~p_m_axis_tready || m_axis_tready)) begin
        
          //only update tready previous when tready is 1 or 0 0 (inital or no valid data for a while).
          p_m_axis_tready <= m_axis_tready;
          //data will be valid if string is terminated at the correct position.
          r_m_axis_tvalid <= 1'b1;
          //check return
          //CR(D)
          if(w_s_axis_tdata[7:0] != 8'h0D) begin
            r_m_axis_tvalid       <= 1'b0;
            force_s_axis_tready <= 1'b1;
          end
          
          //decode sync signal type
          case(w_s_axis_tdata[167:136])
            "DATA": begin
              r_m_axis_tuser[2:0] <= 3'b010;
            end
            "CMDS": begin
              r_m_axis_tuser[2:0] <= 3'b100;
            end
            default: begin
              r_m_axis_tuser[2:0] <= 3'b000;
            end
          endcase

          //insert default value for encode delay
          r_m_axis_tuser[3] <= 0;
          
          //check for delay enable
          if(w_s_axis_tdata[127:112] == "D1") begin
            r_m_axis_tuser[3] <= 1;
          end

          //default parity value
          r_m_axis_tuser[5] <= 0;
          
          //check if odd parity requested
          if(w_s_axis_tdata[103:88] == "P1") begin
            r_m_axis_tuser[5] <= 1;
          end

          //default sync only
          r_m_axis_tuser[1] <= 0;
          
          //check if inversion requested
          if(w_s_axis_tdata[79:64] == "S1") begin
            r_m_axis_tuser[4] <= 1;
          end

          //offset conversion for hex to decimal
          // 48 is for 0 to 9, 55 is for 10 to 15 (A to F)
          r_m_axis_tdata[15:12] <= ((w_s_axis_tdata[39:32] - 48) < 10 ? (w_s_axis_tdata[39:32] - 48) : (w_s_axis_tdata[39:32] - 55));
          r_m_axis_tdata[11: 8] <= ((w_s_axis_tdata[31:24] - 48) < 10 ? (w_s_axis_tdata[31:24] - 48) : (w_s_axis_tdata[31:24] - 55));
          r_m_axis_tdata[ 7: 4] <= ((w_s_axis_tdata[23:16] - 48) < 10 ? (w_s_axis_tdata[23:16] - 48) : (w_s_axis_tdata[23:16] - 55));
          r_m_axis_tdata[ 3: 0] <= ((w_s_axis_tdata[15: 8] - 48) < 10 ? (w_s_axis_tdata[15: 8] - 48) : (w_s_axis_tdata[15: 8] - 55));

        end
    end
  end
  
endmodule
