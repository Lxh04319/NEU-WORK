`timescale 1ns / 10ps
/////////////////////////////////////
// Description: 
///////////////////////////////////////
module voter(A,B,C,F);
    //端口定义
    input A,B,C;
    output F;
    //信号类型
    wire h1,h2,h3;
    //逻辑功能
    assign h1=~(A&B);
    assign h2=~(A&C);
    assign h3=~(B&C);
    assign F=~(h1&h2&h3);
endmodule
