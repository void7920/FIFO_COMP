`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Seok Hoon Choi
// 
// Create Date: 2022/01/09 22:31:04
// Design Name: Comparsion Logic Empty and Full
// Module Name: Comp
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


module Comp #(parameter addrsize = 8)(
    a_emp_n,
    a_full_n,
    rptr,
    wptr,
    wrst_n
    );
    
    output a_emp_n;
    output a_full_n;
    input [addrsize:0]rptr;
    input [addrsize:0]wptr;
    input wrst_n;
    
    reg dir;
    wire dirset_n = ~( (wptr[addrsize] ^ rptr[addrsize-1]) & ~(wptr[addrsize-1] ^ rptr[addrsize]) );
    wire dirrst_n = ~( ~(wptr[addrsize] ^ rptr[addrsize-1]) & (wptr[addrsize-1] ^ rptr[addrsize]) ) | ~wrst_n;
    
    assign  a_emp_n = ~((wptr == rptr) && !dir);
    assign  a_full_n = ~((wptr == rptr) && dir);
    
    always@(negedge dirset_n , negedge dirrst_n)
    begin
        if(!dirrst_n)
            dir <= 0;
        
        else if(!dirset_n)
            dir <= 1;
        
        else
            dir <= 1;
    end
endmodule
