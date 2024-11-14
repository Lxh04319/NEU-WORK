module adder8(
    input wire C0,
    input wire [7:0] A,
    input wire [7:0] B,
    output wire [7:0] S,
    output wire C8);
    wire C4,C8;
    adder4 u0(
    .C0(C0),
    .A(A[3:0]),
    .B(B[3:0]),
    .S(S[3:0]),
    .C4(C4));
    adder4 u1(
    .C0(C4),
    .A(A[7:4]),
    .B(B[7:4]),
    .S(S[7:4]),
    .C4(C8));
endmodule