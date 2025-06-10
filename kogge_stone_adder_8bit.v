module kos_adder_8 (
    input [7:0] a,b,
    input ci,
    output [7:0] s,
    output co
);

wire [8:0] g[0:3];
wire [7:0] p[0:3];

assign g[0]={a&b,ci};
assign p[0]=a^b;
assign p[1]={p[0][7:7],p[0][6:0]&p[0][7:1]};
assign g[1]={(p[0][7:0]&g[0][7:0])|g[0][8:1],g[0][0:0]};
assign p[2]={p[1][7:5],p[1][4:0]&p[1][6:2]};
assign g[2]={(p[1][6:0]&g[1][6:0])|g[1][8:2],g[1][1:0]};
assign p[3]={p[2][7:1],p[2][0:0]&p[2][4:4]};
assign g[3]={(p[2][4:0]&g[2][4:0])|g[2][8:4],g[2][3:0]};
assign {co,s}={g[3][8]|g[3][0]&p[3][0],p[0]^g[3][7:0]};

endmodule

