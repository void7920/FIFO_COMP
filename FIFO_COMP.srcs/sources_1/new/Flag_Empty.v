`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Seok Hoon Choi 
// 
// Create Date: 2022/01/09 23:38:23
// Design Name: Empty Flag Logic
// Module Name: Flag_Empty
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


module Flag_Empty(
    empty,
    clk,
    a_empty_n
    );
    
    output reg empty;
    input clk;
    input a_empty_n;
    
    reg  empty_tmp;
    
    always@(posedge clk)
    begin
        if(!a_empty_n)
        begin
            empty <= 1'b1;
            empty_tmp <= 1'b1;
        end
        
        else
        begin
            empty <= empty_tmp;
            empty_tmp <= ~a_empty_n;
        end
    end
endmodule
