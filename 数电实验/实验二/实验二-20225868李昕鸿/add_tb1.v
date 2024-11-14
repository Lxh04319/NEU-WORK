`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/16 19:29:13
// Design Name: 
// Module Name: add_tb
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


module add_tb;
    reg [7:0] A, B;
    reg C0;
    reg E;
    wire [7:0] S;
    wire C8;

    add uut (
        .A(A),
        .B(B),
        .C0(C0),
        .E(E),
        .S(S),
        .C8(C8)
    );

    initial begin
        E = 1;
        A = 0;
        B = 0;
        C0 = 0;

        #10 A = 8'd50; B = 8'd70;
        #10 A = 8'd255; B = 8'd1;
        #10 E = 1'b0;
        #10 A = 8'd150; B = 8'd100;
        #10 A = 8'd200; B = 8'd55; C0 = 1'b1;
        #10 A = 8'd0; B = 8'd0;
        #10 A = 8'd128; B = 8'd128;
        #10 A = 8'd127; B = 8'd1; 
        #10 A = 8'd255; B = 8'd255;

        #30 A = 1'd0; B = 1'd0;
    end

endmodule

