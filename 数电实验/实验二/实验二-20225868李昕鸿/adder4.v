module adder4(
    input wire C0,
    input wire [3:0] A,
    input wire [3:0] B,
    output wire C4,
    output wire [3:0] S);
    wire C1,C2,C3;
    wire G0,G1,G2,G3;
    wire P0,P1,P2,P3;
    assign P0=A[0]|B[0];
    assign P1=A[1]|B[1];
    assign P2=A[2]|B[2];
    assign P3=A[3]|B[3];
    assign G0=A[0]&B[0];
    assign G1=A[1]&B[1];
    assign G2=A[2]&B[2];
    assign G3=A[3]&B[3];
    assign C1=G0|(C0&P0);
    assign C2=G1|(C1&P1);
    assign C3=G2|(C2&P2);
    assign C4=G3|(C3&P3);
    assign S[0]=A[0]^B[0]^C0;
    assign S[1]=A[1]^B[1]^C1;
    assign S[2]=A[2]^B[2]^C2;
    assign S[3]=A[3]^B[3]^C3;   
endmodule