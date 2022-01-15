`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/11 21:55:09
// Design Name: First Input First Out Register with comparsion
// Module Name: FIFO
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


module FIFO #(parameter MSB = 8, parameter addrsize = 8)(
    rd,
    full,
    empty,
    rclk,
    wclk,
    rrst_n,
    wrst_n,
    ra,
    wd,
    wa,
    rinc,
    winc,
    
    rptr,
    wptr,
    a_emp_n,
    a_full_n
    );
    
    output [MSB-1:0]rd;
    output full;
    output empty;
    input rclk;
    input wclk;
    input rrst_n;
    input wrst_n;
    input [addrsize-1:0]ra;
    input [MSB-1:0]wd;
    input [addrsize-1:0]wa;
    input rinc;
    input winc;
    
    output [addrsize-1:0]rptr;
    output [addrsize-1:0]wptr;
    output a_emp_n;
    output a_full_n;
    
    Dual_Port_Ram #(MSB, addrsize) Ram(.rd(rd), .clk(wclk), .wd(wd), .ra(ra), .wa(wa), .we(winc));
    
    //Write pointer & Full flag logic
    Address_Pointer #(addrsize) Write_ptr(.addr(wa), . ptr(wptr), .clk(wclk), .rst_n(wrst_n), .state(full), .c(winc));
    Flag_Full FF(.full(full), .clk(wclk), .rst_n(wrst_n), .a_full_n(a_full_n));
    
    //Read pointer & Empty flag logic
    Address_Pointer #(addrsize) Read_ptr(.addr(ra), . ptr(rptr), .clk(wclk), .rst_n(rrst_n), .state(full), .c(rinc));
    Flag_Empty FE(.empty(empty), .clk(rclk), .a_empty_n(a_empty_n));
    
    //Comparsion logic
    Comp #(addrsize) Comparsion(.a_emp_n(a_empty_n), .a_full_n(a_full_n), .rptr(rptr), .wptr(wptr), .wrst_n(wrst_n));
    
endmodule