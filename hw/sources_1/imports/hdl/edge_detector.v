`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/12/2025 04:47:28 PM
// Design Name: 
// Module Name: edge_detector
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


module edge_detector(
        input sig,
        input clk,
        input rst_n,
        output pose_edge, 
        output neg_edge
    );
    reg [1:0] sig_dd = 2'b00;
    
    always @ (posedge clk, negedge rst_n) begin
        if (!rst_n)
            sig_dd[1:0] <= 2'b00;
         else begin 
             sig_dd[0] <= sig;
             sig_dd[1] <= sig_dd[0]; 
         end
    end
    
    assign pose_edge = (sig_dd[1] == 1'b0 && sig_dd[0] == 1'b1);
    assign neg_edge =  (sig_dd[1] == 1'b1 && sig_dd[0] == 1'b0);
endmodule
