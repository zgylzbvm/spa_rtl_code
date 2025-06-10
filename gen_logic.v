module gen_logic(
    input [3:1]a,
    input [3:2]x,
    output out
);

wire w1;
wire w2;
wire w3;

assign w1 = x[3]|a[2];
assign w2 = x[2]?a[1]:0;
assign w3 = x[3]?w2:0;
assign out = (a[3]|w1)|w3; 

endmodule