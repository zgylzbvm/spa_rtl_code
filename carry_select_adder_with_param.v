module carry_select_adder #(parameter N=64) (
	input wire [N-1:0] a,
	input wire [N-1:0] b,
	output wire [N:0] sum_out
	);

wire sel;
wire [N:0] c;
wire [N/2-1:0] sum;
assign c[0] = 0;
assign sum[0] = a[0] ^ b[0] ^ c[0];
genvar i;
for(i=1; i<N/2; i=i+1) begin
	assign sum[i] = a[i] ^ b[i] ^ c[i];
	assign c[i+1] = a[i] & b[i] | (c[i] & a[i] ^ b[i]);
end
wire [N-1:N/2] sum_0, sum_1;
wire [N:N/2+1] c_0, c_1;
assign sum_1[N/2] = a[N/2] ^ b[N/2] ^ 1;
assign sum_0[N/2] = a[N/2] ^ b[N/2] ^ 0;
assign c_1[N/2+1] = a[N/2] ^ b[N/2] ^ 1;
assign c_0[N/2+1] = a[N/2] ^ b[N/2] ^ 0;
for(i=N/2+1; i<N; i=i+1) begin
	assign sum_1[i] = a[i] ^ b[i] ^ c_1[i];
	assign c_1[i+1] = a[i] & b[i] | (c_1[i] & a[i] ^ b[i]);
	assign sum_0[i] = a[i] ^ b[i] ^ c_0[i];
	assign c_0[i+1] = a[i] & b[i] | (c_0[i] & a[i] ^ b[i]);
end
assign sum_out[N:0] = c[N/2]?{c_1[N],sum_1[N-1:N/2],sum[N/2-1:0]}:{c_0[N],sum_0[N-1:N/2],sum[N/2-1:0]};
endmodule
