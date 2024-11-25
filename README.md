# UART pmod1553 FPGA Project
### Contains core files and scripts to generate a UART pmod1553 platform using fusesoc.

![image](docs/manual/img/AFRL.png)

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

### DOCUMENTATION
  For detailed usage information, please navigate to one of the following sources. They are the same, just in a different format.

  - [uart_pmod1553.pdf](docs/manual/uart_pmod1553.pdf)
  - [github page](https://johnathan-convertino-afrl.github.io/uart_pmod1553/)

### DEPENDENCIES
#### Build
  - AFRL:utility:digilent_nexys-a7-100t_board_base:1.0.0
  - AFRL:utility:digilent_cmod-s7-25_board_base:1.0.0
  - AFRL:utility:digilent_arty-a7-35_board_base:1.0.0
  - AFRL:project_ip:uart_1553_core:1.0.0
  - AFRL:utility:helper:1.0.0

#### Simulation
  - none, not implimented.

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

### FUSESOC

* fusesoc_info.core created.
* Simulation not available

#### Targets

* RUN WITH: (fusesoc run --target=nexys-a7-100t AFRL:project:uart_open1553:1.0.0)
* -- target can be one of the below.
  - arty-a7-35    : arty a7 35 dev board target.
  - cmod-s7-25    : cmod s7 25 dev board target.
  - default       : Default files, invalid gen target.
  - nexys-a7-100t : Nexyx a7 100t dev board target.


