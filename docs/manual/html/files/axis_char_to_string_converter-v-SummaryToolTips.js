﻿NDSummary.OnToolTipsLoaded("File:axis_char_to_string_converter.v",{85:"<div class=\"NDToolTip TInformation LSystemVerilog\"><div class=\"TTSummary\">Convert characters to a string. Output valid on carrige return or full.</div></div>",86:"<div class=\"NDToolTip TInformation LSystemVerilog\"><div class=\"TTSummary\">Copyright 2021 Jay Convertino</div></div>",87:"<div class=\"NDToolTip TModule LSystemVerilog\"><div id=\"NDPrototype87\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection CStyle\"><div class=\"PParameterCells\" data-WideColumnCount=\"6\" data-NarrowColumnCount=\"5\"><div class=\"PBeforeParameters\" data-WideGridArea=\"1/1/2/2\" data-NarrowGridArea=\"1/1/2/6\" style=\"grid-area:1/1/2/2\"><span class=\"SHKeyword\">module</span> axis_char_to_string_converter #(</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"1/2/2/3\" data-NarrowGridArea=\"2/1/3/2\" style=\"grid-area:1/2/2/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"1/3/2/4\" data-NarrowGridArea=\"2/2/3/3\" style=\"grid-area:1/3/2/4\">master_width</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"1/4/2/5\" data-NarrowGridArea=\"2/3/3/4\" style=\"grid-area:1/4/2/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"1/5/2/6\" data-NarrowGridArea=\"2/4/3/5\" style=\"grid-area:1/5/2/6\"><span class=\"SHNumber\">1</span></div><div class=\"PAfterParameters\" data-WideGridArea=\"1/6/2/7\" data-NarrowGridArea=\"3/1/4/6\" style=\"grid-area:1/6/2/7\">) ( <span class=\"SHKeyword\">input</span> aclk, <span class=\"SHKeyword\">input</span> arstn, <span class=\"SHKeyword\">input</span> [ <span class=\"SHNumber\">7</span>:<span class=\"SHNumber\">0</span>] s_axis_tdata, <span class=\"SHKeyword\">input</span> s_axis_tvalid, <span class=\"SHKeyword\">output</span> s_axis_tready, <span class=\"SHKeyword\">output</span> [(master_width*<span class=\"SHNumber\">8</span>)<span class=\"SHNumber\">-1</span>:<span class=\"SHNumber\">0</span>] m_axis_tdata, <span class=\"SHKeyword\">output</span> m_axis_tvalid, <span class=\"SHKeyword\">input</span> m_axis_tready )</div></div></div></div><div class=\"TTSummary\">Convert characters to a string. Output valid on carrige return or full.</div></div>"});