﻿NDSummary.OnToolTipsLoaded("File3:system_wrapper.v",{50:"<div class=\"NDToolTip TInformation LSystemVerilog\"><div class=\"TTSummary\">System wrapper for pl</div></div>",51:"<div class=\"NDToolTip TInformation LSystemVerilog\"><div class=\"TTSummary\">Copyright 2024 Jay Convertino</div></div>",52:"<div class=\"NDToolTip TModule LSystemVerilog\"><div id=\"NDPrototype52\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection CStyle\"><div class=\"PParameterCells\" data-WideColumnCount=\"6\" data-NarrowColumnCount=\"5\"><div class=\"PBeforeParameters\" data-WideGridArea=\"1/1/4/2\" data-NarrowGridArea=\"1/1/2/6\" style=\"grid-area:1/1/4/2\"><span class=\"SHKeyword\">module</span> system_wrapper #(</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"1/2/2/3\" data-NarrowGridArea=\"2/1/3/2\" style=\"grid-area:1/2/2/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"1/3/2/4\" data-NarrowGridArea=\"2/2/3/3\" style=\"grid-area:1/3/2/4\">clock_speed</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"1/4/2/5\" data-NarrowGridArea=\"2/3/3/4\" style=\"grid-area:1/4/2/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"1/5/2/6\" data-NarrowGridArea=\"2/4/3/5\" style=\"grid-area:1/5/2/6\"><span class=\"SHNumber\">2000000</span>,</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"2/2/3/3\" data-NarrowGridArea=\"3/1/4/2\" style=\"grid-area:2/2/3/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"2/3/3/4\" data-NarrowGridArea=\"3/2/4/3\" style=\"grid-area:2/3/3/4\">baud_rate</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"2/4/3/5\" data-NarrowGridArea=\"3/3/4/4\" style=\"grid-area:2/4/3/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"2/5/3/6\" data-NarrowGridArea=\"3/4/4/5\" style=\"grid-area:2/5/3/6\"><span class=\"SHNumber\">1000000</span>,</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"3/2/4/3\" data-NarrowGridArea=\"4/1/5/2\" style=\"grid-area:3/2/4/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"3/3/4/4\" data-NarrowGridArea=\"4/2/5/3\" style=\"grid-area:3/3/4/4\">mil1553_sample_rate</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"3/4/4/5\" data-NarrowGridArea=\"4/3/5/4\" style=\"grid-area:3/4/4/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"3/5/4/6\" data-NarrowGridArea=\"4/4/5/5\" style=\"grid-area:3/5/4/6\"><span class=\"SHNumber\">2000000</span></div><div class=\"PAfterParameters NegativeLeftSpaceOnWide\" data-WideGridArea=\"3/6/4/7\" data-NarrowGridArea=\"5/1/6/6\" style=\"grid-area:3/6/4/7\">) ( <span class=\"SHKeyword\">input</span> clk, <span class=\"SHKeyword\">input</span> [<span class=\"SHNumber\">1</span>:<span class=\"SHNumber\">0</span>] push_buttons, <span class=\"SHKeyword\">inout</span> [<span class=\"SHNumber\">7</span>:<span class=\"SHNumber\">0</span>] pmod_ja, <span class=\"SHKeyword\">input</span> ftdi_tx, <span class=\"SHKeyword\">output</span> ftdi_rx )</div></div></div></div><div class=\"TTSummary\">System wrapper for pl</div></div>",54:"<div class=\"NDToolTip TModule LSystemVerilog\"><div id=\"NDPrototype54\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection CStyle\"><div class=\"PParameterCells\" data-WideColumnCount=\"4\" data-NarrowColumnCount=\"3\"><div class=\"PBeforeParameters\" data-WideGridArea=\"1/1/4/2\" data-NarrowGridArea=\"1/1/2/4\" style=\"grid-area:1/1/4/2\">clk_wiz_1 inst_clk_wiz_1 (</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"1/2/2/3\" data-NarrowGridArea=\"2/1/3/2\" style=\"grid-area:1/2/2/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"1/3/2/4\" data-NarrowGridArea=\"2/2/3/3\" style=\"grid-area:1/3/2/4\">clk_out1(sys_clk),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"2/2/3/3\" data-NarrowGridArea=\"3/1/4/2\" style=\"grid-area:2/2/3/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"2/3/3/4\" data-NarrowGridArea=\"3/2/4/3\" style=\"grid-area:2/3/3/4\">reset(push_buttons[<span class=\"SHNumber\">0</span>]),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"3/2/4/3\" data-NarrowGridArea=\"4/1/5/2\" style=\"grid-area:3/2/4/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"3/3/4/4\" data-NarrowGridArea=\"4/2/5/3\" style=\"grid-area:3/3/4/4\">clk_in1(clk)</div><div class=\"PAfterParameters NegativeLeftSpaceOnWide\" data-WideGridArea=\"3/4/4/5\" data-NarrowGridArea=\"5/1/6/4\" style=\"grid-area:3/4/4/5\">)</div></div></div></div><div class=\"TTSummary\">Module instance of clock wizard to change input clock to requested clock speed.</div></div>",55:"<div class=\"NDToolTip TModule LSystemVerilog\"><div id=\"NDPrototype55\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection CStyle\"><div class=\"PParameterCells\" data-WideColumnCount=\"4\" data-NarrowColumnCount=\"3\"><div class=\"PBeforeParameters\" data-WideGridArea=\"1/1/11/2\" data-NarrowGridArea=\"1/1/2/4\" style=\"grid-area:1/1/11/2\">sys_rstgen inst_sys_rstgen (</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"1/2/2/3\" data-NarrowGridArea=\"2/1/3/2\" style=\"grid-area:1/2/2/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"1/3/2/4\" data-NarrowGridArea=\"2/2/3/3\" style=\"grid-area:1/3/2/4\">slowest_sync_clk(sys_clk),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"2/2/3/3\" data-NarrowGridArea=\"3/1/4/2\" style=\"grid-area:2/2/3/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"2/3/3/4\" data-NarrowGridArea=\"3/2/4/3\" style=\"grid-area:2/3/3/4\">ext_reset_in(<span class=\"SHNumber\">1\'b1</span>),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"3/2/4/3\" data-NarrowGridArea=\"4/1/5/2\" style=\"grid-area:3/2/4/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"3/3/4/4\" data-NarrowGridArea=\"4/2/5/3\" style=\"grid-area:3/3/4/4\">aux_reset_in(push_buttons[<span class=\"SHNumber\">0</span>]),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"4/2/5/3\" data-NarrowGridArea=\"5/1/6/2\" style=\"grid-area:4/2/5/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"4/3/5/4\" data-NarrowGridArea=\"5/2/6/3\" style=\"grid-area:4/3/5/4\">mb_debug_sys_rst(<span class=\"SHNumber\">1\'b0</span>),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"5/2/6/3\" data-NarrowGridArea=\"6/1/7/2\" style=\"grid-area:5/2/6/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"5/3/6/4\" data-NarrowGridArea=\"6/2/7/3\" style=\"grid-area:5/3/6/4\">dcm_locked(<span class=\"SHNumber\">1\'b1</span>),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"6/2/7/3\" data-NarrowGridArea=\"7/1/8/2\" style=\"grid-area:6/2/7/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"6/3/7/4\" data-NarrowGridArea=\"7/2/8/3\" style=\"grid-area:6/3/7/4\">mb_reset(),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"7/2/8/3\" data-NarrowGridArea=\"8/1/9/2\" style=\"grid-area:7/2/8/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"7/3/8/4\" data-NarrowGridArea=\"8/2/9/3\" style=\"grid-area:7/3/8/4\">bus_struct_reset(),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"8/2/9/3\" data-NarrowGridArea=\"9/1/10/2\" style=\"grid-area:8/2/9/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"8/3/9/4\" data-NarrowGridArea=\"9/2/10/3\" style=\"grid-area:8/3/9/4\">peripheral_reset(reset),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"9/2/10/3\" data-NarrowGridArea=\"10/1/11/2\" style=\"grid-area:9/2/10/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"9/3/10/4\" data-NarrowGridArea=\"10/2/11/3\" style=\"grid-area:9/3/10/4\">interconnect_aresetn(),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"10/2/11/3\" data-NarrowGridArea=\"11/1/12/2\" style=\"grid-area:10/2/11/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"10/3/11/4\" data-NarrowGridArea=\"11/2/12/3\" style=\"grid-area:10/3/11/4\">peripheral_aresetn(resetn)</div><div class=\"PAfterParameters NegativeLeftSpaceOnWide\" data-WideGridArea=\"10/4/11/5\" data-NarrowGridArea=\"12/1/13/4\" style=\"grid-area:10/4/11/5\">)</div></div></div></div><div class=\"TTSummary\">Module instance of reset gen to create system reset.</div></div>",56:"<div class=\"NDToolTip TModule LSystemVerilog\"><div id=\"NDPrototype56\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection CStyle\"><div class=\"PParameterCells\" data-WideColumnCount=\"4\" data-NarrowColumnCount=\"3\"><div class=\"PBeforeParameters\" data-WideGridArea=\"1/1/14/2\" data-NarrowGridArea=\"1/1/2/4\" style=\"grid-area:1/1/14/2\">uart_1553_core #(</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"1/2/2/3\" data-NarrowGridArea=\"2/1/3/2\" style=\"grid-area:1/2/2/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"1/3/2/4\" data-NarrowGridArea=\"2/2/3/3\" style=\"grid-area:1/3/2/4\">clock_speed(clock_speed),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"2/2/3/3\" data-NarrowGridArea=\"3/1/4/2\" style=\"grid-area:2/2/3/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"2/3/3/4\" data-NarrowGridArea=\"3/2/4/3\" style=\"grid-area:2/3/3/4\">uart_baud_clock_speed(clock_speed),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"3/2/4/3\" data-NarrowGridArea=\"4/1/5/2\" style=\"grid-area:3/2/4/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"3/3/4/4\" data-NarrowGridArea=\"4/2/5/3\" style=\"grid-area:3/3/4/4\">uart_baud_rate(baud_rate),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"4/2/5/3\" data-NarrowGridArea=\"5/1/6/2\" style=\"grid-area:4/2/5/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"4/3/5/4\" data-NarrowGridArea=\"5/2/6/3\" style=\"grid-area:4/3/5/4\">uart_parity_ena(<span class=\"SHNumber\">0</span>),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"5/2/6/3\" data-NarrowGridArea=\"6/1/7/2\" style=\"grid-area:5/2/6/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"5/3/6/4\" data-NarrowGridArea=\"6/2/7/3\" style=\"grid-area:5/3/6/4\">uart_parity_type(<span class=\"SHNumber\">0</span>),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"6/2/7/3\" data-NarrowGridArea=\"7/1/8/2\" style=\"grid-area:6/2/7/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"6/3/7/4\" data-NarrowGridArea=\"7/2/8/3\" style=\"grid-area:6/3/7/4\">uart_stop_bits(<span class=\"SHNumber\">1</span>),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"7/2/8/3\" data-NarrowGridArea=\"8/1/9/2\" style=\"grid-area:7/2/8/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"7/3/8/4\" data-NarrowGridArea=\"8/2/9/3\" style=\"grid-area:7/3/8/4\">uart_data_bits(<span class=\"SHNumber\">8</span>),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"8/2/9/3\" data-NarrowGridArea=\"9/1/10/2\" style=\"grid-area:8/2/9/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"8/3/9/4\" data-NarrowGridArea=\"9/2/10/3\" style=\"grid-area:8/3/9/4\">uart_rx_delay(<span class=\"SHNumber\">0</span>),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"9/2/10/3\" data-NarrowGridArea=\"10/1/11/2\" style=\"grid-area:9/2/10/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"9/3/10/4\" data-NarrowGridArea=\"10/2/11/3\" style=\"grid-area:9/3/10/4\">uart_tx_delay(<span class=\"SHNumber\">0</span>),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"10/2/11/3\" data-NarrowGridArea=\"11/1/12/2\" style=\"grid-area:10/2/11/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"10/3/11/4\" data-NarrowGridArea=\"11/2/12/3\" style=\"grid-area:10/3/11/4\">mil1553_sample_rate(mil1553_sample_rate),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"11/2/12/3\" data-NarrowGridArea=\"12/1/13/2\" style=\"grid-area:11/2/12/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"11/3/12/4\" data-NarrowGridArea=\"12/2/13/3\" style=\"grid-area:11/3/12/4\">mil1553_rx_bit_slice_offset(<span class=\"SHNumber\">0</span>),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"12/2/13/3\" data-NarrowGridArea=\"13/1/14/2\" style=\"grid-area:12/2/13/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"12/3/13/4\" data-NarrowGridArea=\"13/2/14/3\" style=\"grid-area:12/3/13/4\">mil1553_rx_invert_data(<span class=\"SHNumber\">0</span>),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"13/2/14/3\" data-NarrowGridArea=\"14/1/15/2\" style=\"grid-area:13/2/14/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"13/3/14/4\" data-NarrowGridArea=\"14/2/15/3\" style=\"grid-area:13/3/14/4\">mil1553_rx_sample_select(<span class=\"SHNumber\">0</span>)</div><div class=\"PAfterParameters NegativeLeftSpaceOnWide\" data-WideGridArea=\"13/4/14/5\" data-NarrowGridArea=\"15/1/16/4\" style=\"grid-area:13/4/14/5\">) inst_uart_1553_core ( .aclk(sys_clk), .arstn(resetn), .uart_clk(sys_clk), .uart_rstn(resetn), .rx_UART(ftdi_tx), .tx_UART(ftdi_rx), .rts_UART(), .cts_UART(<span class=\"SHNumber\">1\'b1</span>), .rx0_1553(pmod_ja[<span class=\"SHNumber\">0</span>]), .rx1_1553(pmod_ja[<span class=\"SHNumber\">1</span>]), .tx0_1553(pmod_ja[<span class=\"SHNumber\">2</span>]), .tx1_1553(pmod_ja[<span class=\"SHNumber\">3</span>]), .en_tx_1553(pmod_ja[<span class=\"SHNumber\">4</span>]) )</div></div></div></div><div class=\"TTSummary\">Module instance of the 1553 UART with all cores tied together as a common device.</div></div>"});