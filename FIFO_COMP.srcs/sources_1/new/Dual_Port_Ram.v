`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Seok Hoon Choi
// 
// Create Date: 2021/12/30 22:07:45
// Design Name: Dual Port Ram
// Module Name: Dual_Port_Ram
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


module Dual_Port_Ram #(parameter MSB = 8, parameter addrsize = 8)(
    rd,
    clk,
    wd,
    ra,
    wa,
    we,
    );
    
    localparam depth = 1 << addrsize;
    
    output reg [MSB-1:0]rd;
    input clk;
    input [MSB-1:0]wd;
    input [addrsize-1:0]ra;
    input [addrsize-1:0]wa;
    input we;
    
    reg [MSB-1:0] ram [0:depth-1];
    
    always@(posedge clk)
    begin
        if(we)
            ram[wa] <= wd;
    end
endmodule
