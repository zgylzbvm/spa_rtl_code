module carry_save_adder #(parameter N = 64)(
    input [N-1:0] op1,
    input [N-1:0] op2,
    input [N-1:0] op3,
    output [N-1:0] sum,
    output [N:0] carry
);
wire [N-1:0] carry_out;
genvar i;
for(i=0; i<N; i=i+1) begin
    assign sum[i] = op1[i] ^ op2[i] ^ op3[i];
    assign carry_out[i] = ((op1[i] & op2[i]) | (op1[i] & op3[i])| (op2[i] & op3[i]));
end
assign carry[N:0] = {carry_out[N-1:0], 1'b0};
endmodule
