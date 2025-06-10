module carry_skip_adder(
    input [7:0] op1,
    input [7:0] op2,
    output [8:0] sum,
    input cin
);

wire [7:0] p;
wire [7:0] g;
wire [7:0] cout;
genvar i;
for (i=0; i<8; i=i+1) begin
    assign g[i] = op1[i] ^ op2[i];
    assign p[i] = op1[i] & op2[i];
end
assign sum[0] = g[0] ^ 0;
assign cout[0] = p[0] | 0;
genvar j;
for(j=1; j<4; j=i+1) begin
    assign sum[i] = op1[i] ^ op2[i] ^ cout[i-1];
    assign cout[i] = p[i] & cout[i-1] | g[i];
end
