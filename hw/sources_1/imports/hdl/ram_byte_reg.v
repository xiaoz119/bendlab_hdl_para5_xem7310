module ram_byte_reg_3_i_4_o #(
    LOCAL_DATA_WR_ADDR = 0,
    DATA_IN_WIDTH = 32,
    ADDR_IN_WIDTH = 8
) (
    input clk,
    input rst_n,
    input en,
    input wen,
    input [DATA_IN_WIDTH-1:0] din,
    input [ADDR_IN_WIDTH-1:0] addr,
    output reg [32-1:0] dout = 0
);
    wire  [ADDR_IN_WIDTH-1:0] addr_local;
//    reg [ADDR_IN_WIDTH-1:0] addr_local_reg = 0;

    assign addr_local = (addr >= LOCAL_DATA_WR_ADDR) ? (addr - LOCAL_DATA_WR_ADDR) : 0;
//    always @(posedge clk or negedge rst_n) begin                                                     
//        if(!rst_n)                               
//            addr_local_reg <= 0;                    
//        else if(en && wen)                              
//            addr_local_reg <= (addr_local) ? addr_local : 0 ;                  
//    end

    always @(posedge clk or negedge rst_n) begin                                        
        if(!rst_n)                               
            dout <= 0;                    
        else if(en && wen)                              
            case (addr_local)                                 
                1: dout[7:0]   <= din[7:0];
                2: dout[15:8]  <= din[7:0];
                3: dout[23:16] <= din[7:0];
//                    4: dout[31:24] <= din[7:0];  reserve for future use
                default: dout <= dout; 
            endcase                                                                     
    end                                                                                    
endmodule