//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
//Date        : Fri May 23 17:17:13 2025
//Host        : DESKTOP-SF4M6F2 running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (bl_L0,
    bl_L1,
    bl_L2,
    bl_L3,
    bl_L4,
    fixed_200mhz_clk_n,
    fixed_200mhz_clk_p,
    iic_bendlab_L0_scl_io,
    iic_bendlab_L0_sda_io,
    iic_bendlab_L1_scl_io,
    iic_bendlab_L1_sda_io,
    iic_bendlab_L2_scl_io,
    iic_bendlab_L2_sda_io,
    iic_bendlab_L3_scl_io,
    iic_bendlab_L3_sda_io,
    iic_bendlab_L4_scl_io,
    iic_bendlab_L4_sda_io,
    status_LEDs,
    uart_rtl_rxd,
    uart_rtl_txd);
  input bl_L0;
  input bl_L1;
  input bl_L2;
  input bl_L3;
  input bl_L4;
  input fixed_200mhz_clk_n;
  input fixed_200mhz_clk_p;
  inout iic_bendlab_L0_scl_io;
  inout iic_bendlab_L0_sda_io;
  inout iic_bendlab_L1_scl_io;
  inout iic_bendlab_L1_sda_io;
  inout iic_bendlab_L2_scl_io;
  inout iic_bendlab_L2_sda_io;
  inout iic_bendlab_L3_scl_io;
  inout iic_bendlab_L3_sda_io;
  inout iic_bendlab_L4_scl_io;
  inout iic_bendlab_L4_sda_io;
  output [7:0]status_LEDs;
  input uart_rtl_rxd;
  output uart_rtl_txd;

  wire bl_L0;
  wire bl_L1;
  wire bl_L2;
  wire bl_L3;
  wire bl_L4;
  wire fixed_200mhz_clk_n;
  wire fixed_200mhz_clk_p;
  wire iic_bendlab_L0_scl_io;
  wire iic_bendlab_L0_sda_io;
  wire iic_bendlab_L1_scl_io;
  wire iic_bendlab_L1_sda_io;
  wire iic_bendlab_L2_scl_io;
  wire iic_bendlab_L2_sda_io;
  wire iic_bendlab_L3_scl_io;
  wire iic_bendlab_L3_sda_io;
  wire iic_bendlab_L4_scl_io;
  wire iic_bendlab_L4_sda_io;
  wire [7:0]status_LEDs;
  wire uart_rtl_rxd;
  wire uart_rtl_txd;

  design_1 design_1_i
       (.bl_L0(bl_L0),
        .bl_L1(bl_L1),
        .bl_L2(bl_L2),
        .bl_L3(bl_L3),
        .bl_L4(bl_L4),
        .fixed_200mhz_clk_n(fixed_200mhz_clk_n),
        .fixed_200mhz_clk_p(fixed_200mhz_clk_p),
        .iic_bendlab_L0_scl_io(iic_bendlab_L0_scl_io),
        .iic_bendlab_L0_sda_io(iic_bendlab_L0_sda_io),
        .iic_bendlab_L1_scl_io(iic_bendlab_L1_scl_io),
        .iic_bendlab_L1_sda_io(iic_bendlab_L1_sda_io),
        .iic_bendlab_L2_scl_io(iic_bendlab_L2_scl_io),
        .iic_bendlab_L2_sda_io(iic_bendlab_L2_sda_io),
        .iic_bendlab_L3_scl_io(iic_bendlab_L3_scl_io),
        .iic_bendlab_L3_sda_io(iic_bendlab_L3_sda_io),
        .iic_bendlab_L4_scl_io(iic_bendlab_L4_scl_io),
        .iic_bendlab_L4_sda_io(iic_bendlab_L4_sda_io),
        .status_LEDs(status_LEDs),
        .uart_rtl_rxd(uart_rtl_rxd),
        .uart_rtl_txd(uart_rtl_txd));
endmodule
