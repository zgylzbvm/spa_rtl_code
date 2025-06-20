module kos_adder_64 (
    input [63:0] a,b,
    input ci,
    output [63:0] s,
    output co
);

wire [64:0] g[0:6];
wire [63:0] p[0:6];

assign g[0]={a&b,ci};
assign p[0]=a^b;
assign p[1]={p[0][63:63],p[0][62:0]&p[0][63:1]};
assign g[1]={(p[0][63:0]&g[0][63:0])|g[0][64:1],g[0][0:0]};
assign p[2]={p[1][63:61],p[1][60:0]&p[1][62:2]};
assign g[2]={(p[1][62:0]&g[1][62:0])|g[1][64:2],g[1][1:0]};
assign p[3]={p[2][63:57],p[2][56:0]&p[2][60:4]};
assign g[3]={(p[2][60:0]&g[2][60:0])|g[2][64:4],g[2][3:0]};
assign p[4]={p[3][63:49],p[3][48:0]&p[3][56:8]};
assign g[4]={(p[3][56:0]&g[3][56:0])|g[3][64:8],g[3][7:0]};
assign p[5]={p[4][63:33],p[4][32:0]&p[4][48:16]};
assign g[5]={(p[4][48:0]&g[4][48:0])|g[4][64:16],g[4][15:0]};
assign p[6]={p[5][63:1],p[5][0:0]&p[5][32:32]};
assign g[6]={(p[5][32:0]&g[5][32:0])|g[5][64:32],g[5][31:0]};
assign {co,s}={g[6][64]|g[6][0]&p[6][0],p[0]^g[6][63:0]};

endmodule