module multiplierbinary(ldA,ldQ,clrA,ldM,clrQ,clrff,sftA,sftQ,addsub,decr,ldcnt,data_in,clk,qm1,eqz);
input ldA,ldQ,ldM,clrA,clrQ,clrff,ldcnt,addsub,clk,sftA,sftQ,decr;
input [15:0] data_in;
output qm1,eqz;
wire [15:0] A,M,Q,Z;
wire [4:0] count;

assign eq=~|count;

   shiftreg Ar (A,Z,A[15],clk,ldA,clrA,sftA );

    // Shift Register for Q
    shiftreg Qr (Q,data_in,A[0],clk,ldQ,clrQ,sftQ );
    PIPO mr(data_in,M,clk,clrff);
    ALU AS (Z,A,M,addsub);
    dff q1(Q[0],qm1,clk,clrff);
    

    // Counter for the number of iterations
   counter u(count ,decr,ldcnt,clk);
endmodule


module shiftreg(data_out,data_in,s_in,clk,ld,clr,sft);
input s_in,clk,ld,clr,sft;
input [15:0] data_in;
output reg [15:0] data_out;

always @(posedge clk)
begin 
if (clr) data_out<=0;
else if (ld) 
    data_out<=data_in;
else if (sft)
data_out<={s_in,data_in[15:1]};
end
endmodule


// pipo module
module PIPO(data_out,data_in,clk,load);
input [15:0] data_in;
input load,clk;
output reg [15:0] data_out;

always @(posedge clk)
if (load)
data_out<=data_in;
endmodule

// d flipflop
module  dff(d,q,clk,clr);
input d,clk,clr;
output reg q;
always @(posedge clk)
if(clr)
q<=0;
else 
q<=d;
endmodule


// ALU module 
module ALU (out,in1,in2,addsub);
input [15:0] in1,in2;
input addsub;
output reg [15:0]out;
always @(*)
begin 
if(addsub==0)
out=in1-in2;
else
out=in1+in2;
end
endmodule

module counter(data_out,decr,ldcnt,clk);
input decr,clk,ldcnt;
output reg [4:0] data_out;

always @ (posedge clk)
begin 
if (ldcnt) data_out<=5'b10000;
else if(decr)
data_out<=data_out-1;
end
endmodule
// module controller

module controller (
    output reg clrA, ldA, sftA, clrQ, ldQ, sftQ, ldM, clrff, addsub, decr, ldcnt, done,
    input clk, q0, qm1, eqz, start
);
    reg [2:0] state;
    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101, S6 = 3'b110;

    always @(posedge clk) begin
        case (state)
            S0: if (start) state <= S1;
            S1: state <= S2;
            S2: if (eqz) state <= S6;
                else if ({q0, qm1} == 2'b01) state <= S3;
                else if ({q0, qm1} == 2'b10) state <= S4;
                else state <= S5;
            S3: state <= S5;
            S4: state <= S5;
            S5: state <= S2;
            S6: state <= S6;
            default: state <= S0;
        endcase
    end

    always @(*) begin
        {clrA, ldA, sftA, clrQ, ldQ, sftQ, ldM, clrff, addsub, decr, ldcnt, done} = 12'b0;
        case (state)
            S0: done = 0;
            S1: begin ldM = 1; clrA = 1; clrQ = 1; clrff = 1; ldcnt = 1; end
            S2: begin clrA=0;clrff=0;ldcnt=0;ldM=0;ldQ=1;end
            S3: begin ldA = 1; addsub = 1;ldQ=0;sftA=0;sftQ=0;decr=0; end
            S4: begin ldA = 1; addsub = 0;ldQ=0;sftA=0;sftQ=0;decr=0; end
            S5: begin sftA = 1; sftQ = 1;decr=1; end
            S6: done = 1;
            default : begin clrA=1;sftA=0;ldQ=0;sftQ=0;end
        endcase
    end
endmodule



 
