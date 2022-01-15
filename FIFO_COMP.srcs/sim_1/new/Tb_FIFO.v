`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Seok Hoon Choi
// 
// Create Date: 2022/01/12 20:28:28
// Design Name: Testbench First Input First Output Register
// Module Name: Tb_FIFO
// Project Name: 
// Target Devices: 
// Tool Versions: Vivado 2021.2.1
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Tb_FIFO();
    parameter msb = 4;
    parameter addr = 4;
    
    reg rclk;
    reg wclk;
    reg rrst_n;
    reg wrst_n;
    reg [addr-1:0]raddr;
    reg [msb-1:0]wdata;
    reg [addr-1:0]waddr;
    reg rinc;
    reg winc;
    
    wire [msb-1:0]rdata;
    wire full;
    wire empty;
    
    wire [addr-1:0]rptr;
    wire [addr-1:0]wptr;
    wire a_emp_n;
    wire a_full_n;
    
    integer i;
    
    FIFO #(msb, addr) sim(.rd(rdata), .full(full), .empty(empty), .rclk(rclk), .wclk(wclk), .rrst_n(rrst_n), .wrst_n(wrst_n), .ra(raddr), .wd(wdata), .wa(waddr), .rinc(rinc), .winc(winc), .rptr(rptr), .wptr(wptr), .a_emp_n(a_emp_n), .a_full_n(a_full_n));

    initial
    begin
        wrst_n = 1'b0;
        rrst_n = 1'b0;
        
        winc = 1'b0;
        rinc = 1'b0;
        
        wdata = 0;
        
        wclk = 1'b0;
        rclk = 1'b0;
    end
    
    initial
    begin
        main;
    end
    
    task main;
        fork
            clk_gen1;
            clk_gen2;
            rst_gen;
            op_proc;
        join
    endtask
    
    task clk_gen1;
        begin
            forever
            begin
                #10
                    wclk = ~wclk;
            end
        end
    endtask
    
    task clk_gen2;
        begin
            forever
            begin
                #25
                    rclk = ~rclk;
            end
        end
    endtask
    
    task rst_gen;
        begin
           # 7
                wrst_n = 1'b1;
           # 298
                rrst_n = 1'b1;
        end
    endtask
    
    task op_proc;
        begin
            for(i=0; i<2**addr; i=i+1)
            begin : WRE
                #(10)
                    winc = 1'b1;
                    wdata = wdata + 1;
                #(10)
                    winc = 1'b0;
            end
            
            #25
            for(i=0; i<2**addr; i=i+1)
            begin : RDE
                #(25)
                    rinc = 1'b1;
                #(25)
                    rinc = 1'b0;
            end
        end
    endtask
endmodule
