`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2025 11:37:37 PM
// Design Name: 
// Module Name: top_axi_iic
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
//////////////////////////////////////////////////////////////////////////////////
module axi_i2c_ctrl_bendlab(
    input clk,
    input rst,
    inout iic_bl_scl_io,
    inout iic_bl_sda_io,
    input intr_bl,
    output [7:0] led,
    output [31:0] bl_data_o
);
    // Parameters
    parameter CONFIG_LENGTH = 50;
    parameter LOCAL_DATA_WR_ADDR = 8'h05;

    // Internal signals
    wire [31:0] instruction;
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) wire [7:0] pc;
    wire [31:0] data_ram_dout;
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) wire [31:0] data_ram_din;
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) wire [7:0] data_ram_addr;
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) wire data_ram_en;
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) wire data_ram_wen;
    
    wire rst_n = ~rst;
    wire s_axi_aclk = clk;
    wire s_axi_aresetn = rst_n;

    (* dont_touch="true" *)(* MARK_DEBUG="true" *) wire iic2intc_irpt;
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) wire [8:0] s_axi_awaddr;
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) wire s_axi_awvalid;
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) wire s_axi_awready;
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) wire [31:0] s_axi_wdata;
    wire [3:0] s_axi_wstrb;
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) wire s_axi_wvalid;
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) wire s_axi_wready;
    wire [1:0] s_axi_bresp;
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) wire s_axi_bvalid;
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) wire s_axi_bready;
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) wire [8:0] s_axi_araddr;
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) wire s_axi_arvalid;
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) wire s_axi_arready;
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) wire [31:0] s_axi_rdata;
    wire [1:0] s_axi_rresp;
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) wire s_axi_rvalid;
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) wire s_axi_rready;   
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) wire sda_i, sda_o, sda_t;
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) wire scl_i, scl_o, scl_t;
    
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) wire intr_bl_negedge;
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) wire [32-1:0] data_reg_4_byte;  

    // Bidirectional I2C signals
    IOBUF iic_rtl_scl_iobuf (
        .I(scl_o),
        .IO(iic_bl_scl_io),
        .O(scl_i),
        .T(scl_t)
    );

    IOBUF iic_rtl_sda_iobuf (
        .I(sda_o),
        .IO(iic_bl_sda_io),
        .O(sda_i),
        .T(sda_t)
    );

    // Instantiate instruction ROM
    instruction_rom_rd u_instruction_rom_rd (
        .clk(clk),
        .addr(pc),
        .data(instruction)
    );

    
//    // Instantiate Data RAM 
//    blk_mem_gen_0 u_bram (
//        .clka(clk),
//        .ena(data_ram_en),
//        .wea(data_ram_wen),
//        .addra(data_ram_addr),
//        .dina(data_ram_din),
//        .douta(data_ram_dout)
//   );
   
   assign data_ram_dout = 0;
   
   // Instantiate Data Register 
   ram_byte_reg_3_i_4_o #(
        .LOCAL_DATA_WR_ADDR(LOCAL_DATA_WR_ADDR),
        .DATA_IN_WIDTH(32),
        .ADDR_IN_WIDTH(8)
   ) u_ram_byte_reg(
        .clk(clk),
        .rst_n(rst_n),
        .en(data_ram_en),
        .wen(data_ram_wen),
        .addr(data_ram_addr),
        .din(data_ram_din),
        .dout(data_reg_4_byte)
    );
    
   assign bl_data_o = data_reg_4_byte;

    // Instantiate AXI4-Lite Master Controller
    axi4_lite_master_controller #(
        .AXI_ADDR_WIDTH(9),
        .AXI_DATA_WIDTH(32),
        .PC_CONFIG(CONFIG_LENGTH)
    ) u_axi4_lite_master_controller (
        .ACLK(clk),
        .ARESETN(rst_n),
        .MEM_en(data_ram_en),
        .MEM_we(data_ram_wen),
        .MEM_addr(data_ram_addr),
        .MEM_wdata(data_ram_din),
        .MEM_rdata(data_ram_dout),
        .M_ACLK(clk),
        .M_ARESETN(rst_n),
        .M_AXI_awaddr(s_axi_awaddr),
        .M_AXI_awready(s_axi_awready),
        .M_AXI_awvalid(s_axi_awvalid),
        .M_AXI_wdata(s_axi_wdata),
        .M_AXI_wready(s_axi_wready),
        .M_AXI_wstrb(s_axi_wstrb),
        .M_AXI_wvalid(s_axi_wvalid),
        .M_AXI_bready(s_axi_bready),
        .M_AXI_bresp(s_axi_bresp),
        .M_AXI_bvalid(s_axi_bvalid),
        .M_AXI_araddr(s_axi_araddr),
        .M_AXI_arready(s_axi_arready),
        .M_AXI_arvalid(s_axi_arvalid),
        .M_AXI_rdata(s_axi_rdata),
        .M_AXI_rready(s_axi_rready),
        .M_AXI_rresp(s_axi_rresp),
        .M_AXI_rvalid(s_axi_rvalid),
        .instr(instruction),
        .intr_bl_negedge(intr_bl_negedge),
        .pc(pc)
    );
    

    // Instantiate AXI IIC
    axi_iic_1 u_axi_iic_0 (
        .s_axi_aclk(s_axi_aclk),
        .s_axi_aresetn(s_axi_aresetn),
        .iic2intc_irpt(iic2intc_irpt),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_awready(s_axi_awready),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wstrb(s_axi_wstrb),
        .s_axi_wvalid(s_axi_wvalid),
        .s_axi_wready(s_axi_wready),
        .s_axi_bresp(s_axi_bresp),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_arready(s_axi_arready),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rresp(s_axi_rresp),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_rready(s_axi_rready),
        .sda_i(sda_i),
        .sda_o(sda_o),
        .sda_t(sda_t),
        .scl_i(scl_i),
        .scl_o(scl_o),
        .scl_t(scl_t),
        .gpo()
    );
    
    // Instantiate Edge Detector
    edge_detector u_edge_detector (
        .clk(clk),
        .rst_n(rst_n),
        .sig(intr_bl),
        .neg_edge(intr_bl_negedge)
    );
    
    // Debug logic using LEDs
    reg device_type_config_flag = 0 ;
    reg device_model_config_flag = 0;
    
    reg data1_change_flag = 0;
    reg data2_change_flag = 0;
    reg data3_change_flag = 0;
    
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) reg [31:0] debug_counter;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            debug_counter <= 0;
        else if (debug_counter < 32'hFFFFFFFF)
            debug_counter <= debug_counter + 1;
        else
            debug_counter <= 0;
    end
   
    (* dont_touch="true" *)(* MARK_DEBUG="true" *) reg interupt_flag = 0;
    
    // Interupt signal check
    always @(posedge clk or negedge  rst_n) begin
        if (!rst_n) 
           interupt_flag <= 0;
        else begin
           interupt_flag <= intr_bl;
        end
    end
    
    // FF for data_ram
    reg [31:0] data_d;
    reg [31:0] data_dd;
    
//    always @ (posedge clk or negedge rst_n) begin
//        if (!rst_n)begin 
//            data_d <= 32'b0;
//            data_dd <= 32'b0;
//        end else begin 
//            if (data_ram_en) 
//                case (data_ram_addr)
//                    LOCAL_DATA_WR_ADDR+1: data_d <= data_ram_din;
//                    LOCAL_DATA_WR_ADDR+3: data_dd <= data_ram_din;
//                    default: begin
//                        data_d <= data_d;
//                        data_dd <= data_dd;
//                    end
//                endcase
//        end
//    end
    always @ (posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_d <= 32'b0;
            data_dd <= 32'b0;
        end else begin
            data_d <= data_reg_4_byte;
            data_dd <= data_d;
        end
    end
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            device_type_config_flag <= 1'b0;
            device_model_config_flag <= 1'b0;
            data1_change_flag <= 1'b0;
            data2_change_flag <= 1'b0;
            data3_change_flag <= 1'b0;
        end 
        else if (data_d[7:0] != data_dd[7:0]) 
                data1_change_flag <= ~data1_change_flag;
        else if (data_d[15:8] != data_dd[15:8]) 
                data2_change_flag <= ~data2_change_flag;
        else if (data_d[23:16] != data_dd[23:16]) 
                data3_change_flag <= ~data3_change_flag;
        else begin
            if (data_ram_wen)
                case (data_ram_addr)
                    8'h00: begin
                        if (data_ram_din == 32'h00000002)
                            device_type_config_flag <= 1'b1;
                        else
                            device_type_config_flag <= 1'b0;
                    end
                    8'h01: begin
                        if (data_ram_din == 32'h00000016)
                            device_model_config_flag <= 1'b1;
                        else
                            device_model_config_flag <= 1'b0;
                    end              
                    default: begin
                        device_type_config_flag <= device_type_config_flag;
                        device_model_config_flag <= device_model_config_flag;
                    end
                endcase
        end
    end
                                       
    // Assign remaining LEDs to display the program counter
    assign led[0] = (rst_n) ? device_type_config_flag && device_model_config_flag: 1'b0;
//    assign led[1] = (rst_n) ? device_model_config_flag: 1'b0;
    assign led[1] = (rst_n) ? data1_change_flag: 1'b0;
    assign led[2] = (rst_n) ? data2_change_flag: 1'b0;
    assign led[3] = (rst_n) ? data3_change_flag: 1'b0;

    assign led[7] = (rst_n) ? interupt_flag: 1'b0;
    
    assign led[6:4] = 1'b0;
endmodule
