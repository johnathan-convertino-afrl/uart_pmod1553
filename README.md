# UART pmod1553 FPGA Project
### Contains core files and scripts to generate a UART pmod1553 platform using fusesoc.
---

   author: Jay Convertino

   date: 2024.04.01

   details: Generate UART pmod1553 FPGA image for various targets. See fusesoc section for targets available.

   license: MIT

---

### Version
#### Current
  - none

#### Previous
  - none

### Dependencies
#### Build
  - AFRL:utility:digilent_nexys-a7-100t_board_base:1.0.0
  - AFRL:utility:digilent_cmod-s7-25_board_base:1.0.0
  - AFRL:utility:digilent_arty-a7-35_board_base:1.0.0
  - AFRL:project_ip:uart_1553_core:1.0.0
  - AFRL:utility:helper:1.0.0

#### Simulation
  - none, not implimented.

## USAGE
### General Usage

For xilinx fifo and uart the format is the same.
Data is received in the following ASCII string format:
>CMDS;D1;P1;I0;Hx5555\r
>DATA;D0;P1;I0;HxAAAA\r

The fields are seperated by ; .

  - The first is the sync type, Command/Status = CMDS, Data = DATA
  - The second is if there is a 4us delay, 1 = delay over 4us, 0 = no delay or less then 4us.
  - The third is parity, 1 = parity good, 0 = parity bad
  - The fourth is invert, 1 = core is inverting data, 0 = core is not inverting data
  - The fifth is the data in hex format, Hx???? where ? = 4 characters representing the data (16 bits in total).
  - The carrige return is the string terminator. This works well with serial consoles with local newline addition enabled.
      - tr '\r' '\n' is your friend for xilinx fifo applications.

Data is sent in the following ASCII string format:
>CMDS;D1;P1;I0;Hx5555\r
>DATA;D0;P1;I0;HxAAAA\r

The fields are seperated by ; .

  - The first is the sync type, Command/Status = CMDS, Data = DATA
  - The second is to enable a 4us delay, 1 = delay of at least 4us, 0 = no delay or less then 4us.
  - The third is parity, 1 = parity odd (default), 0 = parity even
  - The fourth is invert, 1 = invert data, 0 = don't invert data
  - The fifth is the data in hex format, Hx???? where ? = 4 characters representing the data (16 bits in total).
  - The carrige return is the string terminator.
      - echo -ne "DATA;D1;P1;I0;Hx5555\r" is your friend for xilinx fifo applications.

### COMPONENTS
#### arty-a7-35:
  - system_constr.xdc
  - system_wrapper.v

#### cmod-s7-25:
  - system_constr.xdc
  - system_wrapper.v

#### common/uart_1553_core:
  - fusesoc_info.core
  - README.md

#### common/uart_1553_core/src:
  - axis_1553_string_decoder.v
  - axis_1553_string_encoder.v
  - axis_char_to_string_converter.v
  - uart_1553_core.v

#### common/uart_1553_core/tb:
  - tb_converter.v
  - tb_core.v
  - tb_decoder.v
  - tb_encoder.v

#### common/xilinx:
  - system_gen.tcl

#### nexys-a7-100t:
  - system_constr.xdc
  - system_wrapper.v

### fusesoc

* fusesoc_info.core created.
* Simulation not available

#### TARGETS

* RUN WITH: (fusesoc run --target=nexys-a7-100t AFRL:project:uart_open1553:1.0.0)
* -- target can be one of the below.
  - arty-a7-35    : arty a7 35 dev board target.
  - cmod-s7-25    : cmod s7 25 dev board target.
  - default       : Default files, invalid gen target.
  - nexys-a7-100t : Nexyx a7 100t dev board target.


