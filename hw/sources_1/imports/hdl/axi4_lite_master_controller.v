`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2025 01:07:43 PM
// Design Name: 
// Module Name: axi4_lite_master_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module axi4_lite_master_controller
  #(parameter AXI_ADDR_WIDTH = 9,
    parameter AXI_DATA_WIDTH = 32, 
    parameter PC_CONFIG = 0)
  (
    input ACLK,
    input ARESETN,
    output MEM_en,
    output MEM_we,
    output [8-1:0] MEM_addr,
    output [AXI_DATA_WIDTH-1:0] MEM_wdata,
    input [AXI_DATA_WIDTH-1:0] MEM_rdata,
    input M_ACLK,
    input M_ARESETN,
    output [AXI_ADDR_WIDTH-1:0] M_AXI_awaddr,
    input M_AXI_awready,
    output M_AXI_awvalid,
    output [AXI_DATA_WIDTH-1:0] M_AXI_wdata,
    input M_AXI_wready,
    output [(AXI_DATA_WIDTH/8)-1:0] M_AXI_wstrb,
    output M_AXI_wvalid,
    output M_AXI_bready,
    input [1:0] M_AXI_bresp,
    input M_AXI_bvalid,
    output [AXI_ADDR_WIDTH-1:0] M_AXI_araddr,
    input M_AXI_arready,
    output M_AXI_arvalid,
    input [AXI_DATA_WIDTH-1:0] M_AXI_rdata,
    output M_AXI_rready,
    input [1:0] M_AXI_rresp,
    input M_AXI_rvalid,
    input [31:0] instr, // Instruction input from external instruction_rom
    input intr_bl_negedge, // Synchronized Interrupt signal negative edge pose from external source
    output [7:0] pc     // Program counter output to instruction_rom
  );
  

  // Internal signals
  wire wr_start_flag, wr_done_flag;
  wire rd_start_flag, rd_done_flag;
  wire wr_awvalid, wr_wvalid, wr_bready;
  wire rd_arvalid, rd_rready;
  wire rd_en_read;

  wire [AXI_ADDR_WIDTH-1:0] axi_r_w_addr;
  reg [AXI_ADDR_WIDTH-1:0] axi_wr_addr = 0;
  reg [AXI_ADDR_WIDTH-1:0] axi_rd_addr = 0;

  wire [AXI_DATA_WIDTH-1:0] axi_wr_data;
  wire [AXI_DATA_WIDTH-1:0] axi_rd_data;

  reg [7:0] pc_reg = 0;
  wire [7:0] pc_next = pc_reg + 1;

  wire [3-1:0] opcode;
  wire [7-1:0] mem_r_w_addr;
  wire [7-1:0] axi_count;
  wire [7-1:0] axi_exec_count;
  wire [20-1:0] axi_wri_data;
  wire [29-1:0] local_delay_count;
  // wire [19-1:0] axi_compare_value;
  wire [2-1:0] axi_compare_op;
  wire  [32-1:0]axi_compare_value;

//  reg true_axi_compare;
  reg pass_axi_compare_flag = 0;

  wire en_pc;
  wire [7:0] axi_counter;
  wire en_mem;
  wire valid_axi_rd;
  wire en_mem_rd;
  wire instr_done_flag;

  reg [32-1:0] mem_rdata = 0;

  // AXI IO Control
  assign M_AXI_wstrb = 4'b1111; // Hardcoded to enable writing to all byte lanes
  assign M_AXI_araddr = axi_rd_addr;
  assign M_AXI_awaddr = axi_wr_addr;
  assign axi_rd_data = M_AXI_rdata;
  // assign M_AXI_wdata = mem_rdata; 
  assign M_AXI_wdata = axi_wr_data;
  assign axi_wr_data = (opcode == 3'b011) ? {12'b0, axi_wri_data} : mem_rdata; // AXI write data from instruction or memory read data

  // Program Counter
  always @ (posedge ACLK, negedge ARESETN) begin
    if (!ARESETN)
      pc_reg <= 8'b00000000;
    else
      if (pc_reg == 8'b11111111) // MAX
        pc_reg <= PC_CONFIG; // Reset to initial value
//        pc_reg <= 8'b11111111; // Reset to initial value
      else
        pc_reg <= (en_pc)? pc_next : pc_reg;
  end

  assign pc = pc_reg; // Output program counter to external instruction_rom

  // Decoder 
  assign opcode = instr[2:0];
  assign axi_r_w_addr = instr[11:3];
  // assign mem_r_w_addr = instr[19:12];
  assign axi_count = instr[26:20];
  assign axi_counter = (opcode == 3'b001 || opcode == 3'b010)?  axi_count - axi_exec_count : 0;
  assign axi_wri_data = instr[31:12];
  // assign MEM_addr = mem_r_w_addr; 
  assign local_delay_count = (opcode == 3'b100 ) ? instr[31:3] : 32'b0;
  assign MEM_addr = instr[19:12];

  assign axi_compare_value = {14'b0, instr[31:14]};

  assign axi_compare_op = instr[13:12];

  // Address calculation
  always @(*) begin
    axi_wr_addr = axi_r_w_addr  + (axi_counter << 2);
    axi_rd_addr = axi_r_w_addr  + (axi_counter << 2);
  end

  // Connect FSM outputs to AXI signals
  assign M_AXI_awvalid = wr_awvalid;
  assign M_AXI_wvalid = wr_wvalid;
  assign M_AXI_bready = wr_bready;

  assign M_AXI_arvalid = rd_arvalid;
  assign M_AXI_rready = rd_rready;

  // Memory control signals
  // assign en_mem = en_mem_rd | valid_axi_rd;
  // assign MEM_en = en_mem;

  assign MEM_we = ( (opcode == 3'b001) && valid_axi_rd ) ? 1'b1 : 1'b0;
  assign MEM_en = en_mem_rd | MEM_we;
  assign MEM_wdata = axi_rd_data;

  always @(posedge ACLK, negedge ARESETN) begin
    if (!ARESETN) 
      mem_rdata <= 0;
    else 
      mem_rdata <= (en_mem_rd) ? MEM_rdata : mem_rdata;
      // if (en_mem_rd) 
      //   mem_rdata <= MEM_rdata;
      // else
      //   mem_rdata <= mem_rdata
  end

  // Compare Check Unit
  always @(posedge ACLK) begin
  if (!ARESETN)
        pass_axi_compare_flag <= 0;
    else if (rd_start_flag || instr_done_flag)
        pass_axi_compare_flag <= 0;
    else if (valid_axi_rd && (opcode == 3'b101)) begin 
        case (axi_compare_op)
          2'b00: pass_axi_compare_flag  <= (axi_rd_data & axi_compare_value) ? 1'b1 : 1'b0; // And -> True pass 
          2'b01: pass_axi_compare_flag  <= (axi_rd_data & axi_compare_value) ? 1'b0 : 1'b1; // And -> False pass
          default: pass_axi_compare_flag  <= 1'b0;
        endcase
    end
  end

//  always @(posedge ACLK) begin
//    if (!ARESETN)
//      pass_axi_compare_flag <= 0;
//      else if (rd_start_flag || instr_done_flag)
//      pass_axi_compare_flag <= 0;
//      else if (valid_axi_rd && (opcode == 3'b101))
//      pass_axi_compare_flag <= true_axi_compare;
//  end


  
  // Delay Counter
  wire done_delay_count;
  wire en_delay_count;
  always  @(posedge ACLK, negedge ARESETN) begin
    
  end
  reg  [29-1:0] delay_counter; 
  always  @(posedge ACLK, negedge ARESETN) begin
    if (!ARESETN)
        delay_counter = 0;
    else if (en_delay_count)
        if (delay_counter < local_delay_count)
            delay_counter <= delay_counter + 1;
        else
            delay_counter <= 0;
  end
  assign done_delay_count = ((delay_counter == local_delay_count) && (local_delay_count != 0)) ? 1'b1 : 1'b0;
  
  

  // FSM TOP instantiations
  fsm_top_level u_fsm_top_level (
    .clk(ACLK),
    .rst_n(ARESETN),
    .opcode(opcode),
    .count(axi_count),
    .done_wr(wr_done_flag),
    .done_rd(rd_done_flag),
    .done_delay_count(done_delay_count),
    .start_rd(rd_start_flag),
    .start_wr(wr_start_flag),
    .en_mem_rd(en_mem_rd),
    .en_pc(en_pc),
    .en_delay_count(en_delay_count),
    .axi_exec_count(axi_exec_count),
    .done_instr(instr_done_flag),
    .pass_axi_compare(pass_axi_compare_flag),
    .intr_bl_negedge(intr_bl_negedge)
  );
  
  // FSM AXI write
  fsm_axi_lite_wr u_fsm_axi_lite_wr (
    .clk(ACLK),
    .rst_n(ARESETN),
    .start(wr_start_flag),
    .done_flag(wr_done_flag),
    .awvalid(wr_awvalid),
    .awready(M_AXI_awready),
    .wvalid(wr_wvalid),
    .wready(M_AXI_wready),
    .bvalid(M_AXI_bvalid),
    .bready(wr_bready),
    .bresp(M_AXI_bresp)
  );
  
  // FSM AXI Read
  fsm_axi_lite_rd u_fsm_axi_lite_rd (
    .clk(ACLK),
    .rst_n(ARESETN),
    .start(rd_start_flag),
    .done_flag(rd_done_flag),
    .en_mem_wr(valid_axi_rd),
    .arready(M_AXI_arready),
    .arvalid(rd_arvalid),
    .rvalid(M_AXI_rvalid),
    .rready(rd_rready),
    .rresp(M_AXI_rresp)
  );

endmodule
