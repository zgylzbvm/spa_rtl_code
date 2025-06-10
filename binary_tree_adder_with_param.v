module binary_tree_adder #(parameter N = 64)( //三级八个数
    input [N-1:0] op1,
    input [N-1:0] op2,
    input [N-1:0] op3,
    input [N-1:0] op4,
    input [N-1:0] op5,
    input [N-1:0] op6,
    input [N-1:0] op7,
    input [N-1:0] op8,
    output [N:0] sum,
    output cout
);
genvar i;
wire [N-1:0] sum1_level1;
wire [N-1:0] sum2_level1;
wire [N-1:0] sum3_level1;
wire [N-1:0] sum4_level1;
wire [N-1:0] c1_level1;
wire [N-1:0] c2_level1;
wire [N-1:0] c3_level1;
wire [N-1:0] c4_level1;
assign c1_level1[0] = 1'b0;
assign c2_level1[0] = 1'b0;
assign c3_level1[0] = 1'b0;
assign c4_level1[0] = 1'b0;
assign sum1_level1[0] = op1[0] ^ op2[0] ^ 1'b0;
assign sum2_level1[0] = op3[0] ^ op4[0] ^ 1'b0;
assign sum3_level1[0] = op5[0] ^ op6[0] ^ 1'b0;
assign sum4_level1[0] = op7[0] ^ op7[0] ^ 1'b0;
//level 1
for (i=1; i<N; i=i+1) begin
    assign sum1_level1[i] = op1[i] ^ op2[i] ^ c1_level1[i];
    assign c1_level1[i] = op1[i] ^ op2[i] & c1_level1[i-1] | op1[i] & op2[i];
    assign sum2_level1[i] = op3[i] ^ op4[i] ^ c2_level1[i];
    assign c2_level1[i] = op3[i] ^ op4[i] & c2_level1[i-1] | op3[i] & op4[i];
    assign sum3_level1[i] = op5[i] ^ op6[i] ^ c3_level1[i];
    assign c3_level1[i] = op5[i] ^ op6[i] & c3_level1[i-1] | op5[i] & op6[i];
    assign sum4_level1[i] = op7[i] ^ op8[i] ^ c4_level1[i];
    assign c4_level1[i] = op7[i] ^ op8[i] & c4_level1[i-1] | op7[i] & op8[i];
end

wire [N:0] sum1_level2;
wire [N:0] sum2_level2;
wire [N:0] c1_level2;
wire [N:0] c2_level2;
assign c1_level2[0] = 1'b0;
assign c2_level2[0] = 1'b0;
assign sum1_level2[0] = sum1_level1[0] ^ sum2_level1[0] ^ 1'b0;
assign sum2_level2[0] = sum3_level1[0] ^ sum4_level1[0] ^ 1'b0;
//level 2
for (i=1; i<N+1; i=i+1) begin
    assign sum1_level2[i] = sum1_level1[i] ^ sum2_level1[i] ^ c1_level1[i];
    assign c1_level2[i] = (sum1_level1[i] ^ sum2_level1[i] & c1_level2[i-1]) | (sum1_level1[i] & sum2_level1[i]);
    assign sum2_level2[i] = sum3_level1[i] ^ sum4_level1[i] ^ c2_level2[i];
    assign c2_level2[i] = sum3_level1[i] ^ sum4_level1[i] & c2_level2[i-1] | (sum3_level1[i] & sum4_level1[i]);
end
//level 3
wire [N+1:0] sum1_level3;
wire [N+1:0] c1_level3;
assign c1_level3[0] = 1'b0;
assign sum1_level3[0] = sum1_level2[0] ^ sum2_level2[0] ^ 1'b0;

for (i=1; i<N+2; i=i+1) begin
    assign sum1_level3[i] = sum1_level2[i] ^ sum2_level2[i] ^ c1_level2[i];
    assign c1_level3[i] = (sum1_level2[i] ^ sum2_level2[i] & c1_level3[i-1]) | (sum1_level2[i] & sum2_level2[i]);
end
assign sum = sum1_level3;
assign cout = c1_level3[N+1];
endmodule