`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/16 20:56:00
// Design Name: 
// Module Name: addAndSub
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
    output reg Si,
    output reg Ciout
);
    wire S = Ci ^ Ai ^ Bi;
    wire C = Ai & Bi | (Ai ^ Bi) & Ci;

    always @ (*) begin
        Si = S;
        Ciout = C;
    end  
endmodule

module add(
    input wire [7:0] A,
    input wire [7:0] B,
    input wire C0,
    output wire [7:0] S,
    output wire C8
);
    wire C1, C2, C3, C4, C5, C6, C7;

    full_add f0(
        .Ai(A[0]),
        .Bi(B[0]),
        .Ci(C0),
        .Si(S[0]),
        .Ciout(C1)
    );

    full_add f1(
        .Ai(A[1]),
        .Bi(B[1]),
        .Ci(C1),
        .Si(S[1]),
        .Ciout(C2)
    );

    full_add f2(
        .Ai(A[2]),
        .Bi(B[2]),
        .Ci(C2),
        .Si(S[2]),
        .Ciout(C3)
    );

    full_add f3(
        .Ai(A[3]),
        .Bi(B[3]),
        .Ci(C3),
        .Si(S[3]),
        .Ciout(C4)
    );

    full_add f4(
        .Ai(A[4]),
        .Bi(B[4]),
        .Ci(C4),
        .Si(S[4]),
        .Ciout(C5)
    );

    full_add f5(
        .Ai(A[5]),
        .Bi(B[5]),
        .Ci(C5),
        .Si(S[5]),
        .Ciout(C6)
    );

    full_add f6(
        .Ai(A[6]),
        .Bi(B[6]),
        .Ci(C6),
        .Si(S[6]),
        .Ciout(C7)
    );

    full_add f7(
        .Ai(A[7]),
        .Bi(B[7]),
        .Ci(C7),
        .Si(S[7]),
        .Ciout(C8)
    );
endmodule

module full_sub(
    input wire A,
    input wire B,
    input wire Cin,
    output reg D,
    output reg Co
);

    always @ (*) begin
        D = A ^ (B ^ Cin);
        Co = ~A & (B ^ Cin) | Cin & B;
    end  
endmodule

module sub(
    input wire [7:0] A,
    input wire [7:0] B,
    input wire C0,
    output wire [7:0] D,
    output wire B8
);
    wire B1, B2, B3, B4, B5, B6, B7;

    full_sub s0(
        .A(A[0]),
        .B(B[0]),
        .Cin(C0),
        .D(D[0]),
        .Co(B1)
    );

    full_sub s1(
        .A(A[1]),
        .B(B[1]),
        .Cin(B1),
        .D(D[1]),
        .Co(B2)
    );

    full_sub s2(
        .A(A[2]),
        .B(B[2]),
        .Cin(B2),
        .D(D[2]),
        .Co(B3)
    );

    full_sub s3(
        .A(A[3]),
        .B(B[3]),
        .Cin(B3),
        .D(D[3]),
        .Co(B4)
    );

    full_sub s4(
        .A(A[4]),
        .B(B[4]),
        .Cin(B4),
        .D(D[4]),
        .Co(B5)
    );

    full_sub s5(
        .A(A[5]),
        .B(B[5]),
        .Cin(B5),
        .D(D[5]),
        .Co(B6)
    );

    full_sub s6(
        .A(A[6]),
        .B(B[6]),
        .Cin(B6),
        .D(D[6]),
        .Co(B7)
    );

    full_sub s7(
        .A(A[7]),
        .B(B[7]),
        .Cin(B7),
        .D(D[7]),
        .Co(B8)
    );
endmodule



module addAndSub(
    input wire [7:0] A,
    input wire [7:0] B,
    input wire E,  // 控制信号，1表示加法，0表示减法
    input wire C0,
    output wire [7:0] Result,
    output wire C
);
    wire [7:0] sum;
    wire [7:0] diff;
    wire sum_carry;
    wire borrow;

    add adder(
        .A(A),
        .B(B),
        .C0(C0),
        .S(sum),
        .C8(sum_carry)
    );

    sub subtractor(
        .A(A),
        .B(B),
        .C0(C0),
        .D(diff),
        .B8(borrow)
    );

    assign Result = (E) ? sum : diff;
    assign C = (E) ? sum_carry : borrow;

endmodule

