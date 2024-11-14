`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/16 19:01:37
// Design Name: 
// Module Name: add
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


module full_add(
    input wire Ai,
    input wire Bi,
    input wire Ci,
    input wire E,
    output reg Si,
    output reg Ciout
);
    wire S = Ci ^ Ai ^ Bi;
    wire C = Ai & Bi | (Ai ^ Bi) & Ci;

    always @ (*) begin
        if (E == 1'b0) begin
            Si = S;
            Ciout = C;
        end else begin
            Si = 1'bz;
            Ciout = 1'bz;
        end
    end  
endmodule

module add(
    input wire [7:0] A,
    input wire [7:0] B,
    input wire E,
    input wire C0,
    output wire [7:0] S,
    output wire C8
);
    wire C1, C2, C3, C4, C5, C6, C7;

    full_add f0(
        .Ai(A[0]),
        .Bi(B[0]),
        .Ci(C0),
        .E(E),
        .Si(S[0]),
        .Ciout(C1)
    );

    full_add f1(
        .Ai(A[1]),
        .Bi(B[1]),
        .Ci(C1),
        .E(E),
        .Si(S[1]),
        .Ciout(C2)
    );

    full_add f2(
        .Ai(A[2]),
        .Bi(B[2]),
        .Ci(C2),
        .E(E),
        .Si(S[2]),
        .Ciout(C3)
    );

    full_add f3(
        .Ai(A[3]),
        .Bi(B[3]),
        .Ci(C3),
        .E(E),
        .Si(S[3]),
        .Ciout(C4)
    );

    full_add f4(
        .Ai(A[4]),
        .Bi(B[4]),
        .Ci(C4),
        .E(E),
        .Si(S[4]),
        .Ciout(C5)
    );

    full_add f5(
        .Ai(A[5]),
        .Bi(B[5]),
        .Ci(C5),
        .E(E),
        .Si(S[5]),
        .Ciout(C6)
    );

    full_add f6(
        .Ai(A[6]),
        .Bi(B[6]),
        .Ci(C6),
        .E(E),
        .Si(S[6]),
        .Ciout(C7)
    );

    full_add f7(
        .Ai(A[7]),
        .Bi(B[7]),
        .Ci(C7),
        .E(E),
        .Si(S[7]),
        .Ciout(C8)
    );
endmodule




