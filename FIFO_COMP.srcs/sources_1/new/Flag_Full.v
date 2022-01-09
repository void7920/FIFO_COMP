`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Seok Hoon Choi
// 
// Create Date: 2022/01/09 23:38:23
// Design Name: Full Flag Logic
// Module Name: Flag_Full
// Project Name: 
// Target Devices: 
// Tool Versions: Vivado 2021.2
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Flag_Full(
    full,
    clk,
    rst_n,
    a_full_n
    );
    
    output reg full;
    input clk;
    input rst_n;
    input a_full_n;
    
    reg full_tmp;
    
    always@(posedge clk, negedge rst_n)
    begin
        if(!rst_n)
        begin
            full <= 1'b0;
            full_tmp <= 1'b0;
        end
        
        else if(!a_full_n)
        begin
            full <= 1'b1;
            full_tmp <= 1'b1;
        end
        
        else
        begin
            full <= full_tmp;
            full_tmp <= ~a_full_n;
        end
    end
endmodule
