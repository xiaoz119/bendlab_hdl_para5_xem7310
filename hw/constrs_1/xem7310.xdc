############################################################################
# XEM7310 - Xilinx constraints file
#
# Pin mappings for the XEM7310.  Use this as a template and comment out
# the pins that are not used in your design.  (By default, map will fail
# if this file contains constraints for signals not in your design).
#
# Copyright (c) 2004-2016 Opal Kelly Incorporated
############################################################################

#set_property CFGBVS GND [current_design];
#set_property CONFIG_VOLTAGE 1.8 [current_design];
#set_property BITSTREAM.GENERAL.COMPRESS True [current_design];


############################################################################
## System Clock
############################################################################
set_property IOSTANDARD LVDS_25 [get_ports fixed_200mhz_clk_p];
set_property IOSTANDARD LVDS_25 [get_ports fixed_200mhz_clk_n];
set_property PACKAGE_PIN W11 [get_ports fixed_200mhz_clk_p];
set_property PACKAGE_PIN W12 [get_ports fixed_200mhz_clk_n];
set_property DIFF_TERM FALSE [get_ports fixed_200mhz_clk_p];

############################################################################
## User Reset
############################################################################
#set_property PACKAGE_PIN Y18 [get_ports {reset}]
#set_property IOSTANDARD LVCMOS18 [get_ports {reset}]
#set_property SLEW FAST [get_ports {reset}]

# LEDs #####################################################################
set_property PACKAGE_PIN A13 [get_ports {status_LEDs[0]}]
set_property PACKAGE_PIN B13 [get_ports {status_LEDs[1]}]
set_property PACKAGE_PIN A14 [get_ports {status_LEDs[2]}]
set_property PACKAGE_PIN A15 [get_ports {status_LEDs[3]}]
set_property PACKAGE_PIN B15 [get_ports {status_LEDs[4]}]
set_property PACKAGE_PIN A16 [get_ports {status_LEDs[5]}]
set_property PACKAGE_PIN B16 [get_ports {status_LEDs[6]}]
set_property PACKAGE_PIN B17 [get_ports {status_LEDs[7]}]
set_property IOSTANDARD LVCMOS15 [get_ports {status_LEDs[*]}]

# UART #####################################################################
#set_property PACKAGE_PIN AA15 [get_ports {uart_rtl_rxd}]
#set_property PACKAGE_PIN AB15 [get_ports {uart_rtl_txd}]
set_property PACKAGE_PIN Y11 [get_ports {uart_rtl_rxd}]
set_property PACKAGE_PIN Y12 [get_ports {uart_rtl_txd}]
set_property IOSTANDARD LVCMOS33 [get_ports {uart_rtl_rxd}]
set_property IOSTANDARD LVCMOS33 [get_ports {uart_rtl_txd}]
#set_property -dict { PACKAGE_PIN Y11   IOSTANDARD LVCMOS33 } [get_ports { uart_rtl_rxd }];
#set_property -dict { PACKAGE_PIN Y12   IOSTANDARD LVCMOS33 } [get_ports { uart_rtl_txd }];

#set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS33} [get_ports iic_rtl_scl_io]
#set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33} [get_ports iic_rtl_sda_io]
#set_property PULLUP true [get_ports iic_rtl_scl_io]
#set_property PULLUP true [get_ports iic_rtl_sda_io]

# Bank voltage #############################################################
#set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 34]];
#set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 35]];


# I2Cs-Left-Bendlab#########################################################
# set_property -dict {PACKAGE_PIN U3 IOSTANDARD LVCMOS33} [get_ports iic_bendlab_L0_scl_io]
# set_property -dict {PACKAGE_PIN V3 IOSTANDARD LVCMOS33} [get_ports iic_bendlab_L0_sda_io]
# set_property PULLUP true [get_ports iic_bendlab_L0_scl_io]
# set_property PULLUP true [get_ports iic_bendlab_L0_sda_io]

# set_property -dict {PACKAGE_PIN AA8 IOSTANDARD LVCMOS33} [get_ports iic_bendlab_L1_scl_io]
# set_property -dict {PACKAGE_PIN AB8 IOSTANDARD LVCMOS33} [get_ports iic_bendlab_L1_sda_io]
# set_property PULLUP true [get_ports iic_bendlab_L1_scl_io]
# set_property PULLUP true [get_ports iic_bendlab_L1_sda_io]

# set_property -dict {PACKAGE_PIN Y6 IOSTANDARD LVCMOS33} [get_ports iic_bendlab_L2_scl_io]
# set_property -dict {PACKAGE_PIN AA6 IOSTANDARD LVCMOS33} [get_ports iic_bendlab_L2_sda_io]
# set_property PULLUP true [get_ports iic_bendlab_L2_scl_io]
# set_property PULLUP true [get_ports iic_bendlab_L2_sda_io]

# set_property -dict {PACKAGE_PIN Y4 IOSTANDARD LVCMOS33} [get_ports iic_bendlab_L3_scl_io]
# set_property -dict {PACKAGE_PIN AA4 IOSTANDARD LVCMOS33} [get_ports iic_bendlab_L3_sda_io]
# set_property PULLUP true [get_ports iic_bendlab_L3_scl_io]
# set_property PULLUP true [get_ports iic_bendlab_L3_sda_io]

# set_property -dict {PACKAGE_PIN R4 IOSTANDARD LVCMOS33} [get_ports iic_bendlab_L4_scl_io]
# set_property -dict {PACKAGE_PIN T4 IOSTANDARD LVCMOS33} [get_ports iic_bendlab_L4_sda_io]
# set_property PULLUP true [get_ports iic_bendlab_L4_scl_io]
# set_property PULLUP true [get_ports iic_bendlab_L4_sda_io]

# set_property -dict {PACKAGE_PIN V2  IOSTANDARD LVCMOS33} [get_ports bl_L0]
# set_property -dict {PACKAGE_PIN AA3 IOSTANDARD LVCMOS33} [get_ports bl_L1]
# set_property -dict {PACKAGE_PIN R2  IOSTANDARD LVCMOS33} [get_ports bl_L2]
# set_property -dict {PACKAGE_PIN AB6 IOSTANDARD LVCMOS33} [get_ports bl_L3]
# set_property -dict {PACKAGE_PIN AB5 IOSTANDARD LVCMOS33} [get_ports bl_L4]

# I2Cs-Right-Bendlab########################################################
set_property -dict {PACKAGE_PIN G1 IOSTANDARD LVCMOS33} [get_ports iic_bendlab_R0_scl_io]
set_property -dict {PACKAGE_PIN F1 IOSTANDARD LVCMOS33} [get_ports iic_bendlab_R0_sda_io]
set_property PULLUP true [get_ports iic_bendlab_R0_scl_io]
set_property PULLUP true [get_ports iic_bendlab_R0_sda_io]

set_property -dict {PACKAGE_PIN H2 IOSTANDARD LVCMOS33} [get_ports iic_bendlab_R1_scl_io]
set_property -dict {PACKAGE_PIN G2 IOSTANDARD LVCMOS33} [get_ports iic_bendlab_R1_sda_io]
set_property PULLUP true [get_ports iic_bendlab_R1_scl_io]
set_property PULLUP true [get_ports iic_bendlab_R1_sda_io]

set_property -dict {PACKAGE_PIN J5 IOSTANDARD LVCMOS33} [get_ports iic_bendlab_R2_scl_io]
set_property -dict {PACKAGE_PIN H5 IOSTANDARD LVCMOS33} [get_ports iic_bendlab_R2_sda_io]
set_property PULLUP true [get_ports iic_bendlab_R2_scl_io]
set_property PULLUP true [get_ports iic_bendlab_R2_sda_io]

set_property -dict {PACKAGE_PIN L3 IOSTANDARD LVCMOS33} [get_ports iic_bendlab_R3_scl_io]
set_property -dict {PACKAGE_PIN K3 IOSTANDARD LVCMOS33} [get_ports iic_bendlab_R3_sda_io]
set_property PULLUP true [get_ports iic_bendlab_R3_scl_io]
set_property PULLUP true [get_ports iic_bendlab_R3_sda_io]

set_property -dict {PACKAGE_PIN K6 IOSTANDARD LVCMOS33} [get_ports iic_bendlab_R4_scl_io]
set_property -dict {PACKAGE_PIN J6 IOSTANDARD LVCMOS33} [get_ports iic_bendlab_R4_sda_io]
set_property PULLUP true [get_ports iic_bendlab_R4_scl_io]
set_property PULLUP true [get_ports iic_bendlab_R4_sda_io]


set_property -dict {PACKAGE_PIN D2 IOSTANDARD LVCMOS33} [get_ports bl_R0]
set_property -dict {PACKAGE_PIN G3 IOSTANDARD LVCMOS33} [get_ports bl_R1]
set_property -dict {PACKAGE_PIN J1 IOSTANDARD LVCMOS33} [get_ports bl_R2]
set_property -dict {PACKAGE_PIN J2 IOSTANDARD LVCMOS33} [get_ports bl_R3]
set_property -dict {PACKAGE_PIN L1 IOSTANDARD LVCMOS33} [get_ports bl_R4]

