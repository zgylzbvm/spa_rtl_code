module lca(
  input[7:0] a,
  input[7:0] b,
  input c_in,
  output[7:0] sum,
  output c_out
  );
  wire[7:0] g,p,c;
    assign c[0]=c_in;
    assign p=a^b;
    assign g=a&b;
    assign c[1]=g[0]|(p[0]&c[0]);
    assign c[2]=g[1]|(p[1]&(g[0]|(p[0]&c[0])));
    assign c[3]=g[2]|(p[2]&(g[1]|(p[1]&(g[0]|(p[0]&c[0])))));
    assign c[4]=g[3]|(p[3]&(g[2]|(p[2]&(g[1]|(p[1]&(g[0]|(p[0]&c[0])))))));
    assign c[5]=g[4]|(p[4]&(g[3]|(p[3]&(g[2]|(p[2]&(g[1]|(p[1]&(g[0]|(p[0]&c[0])))))))));
    assign c[6]=g[5]|(p[5]&(p[4]&(g[3]|(p[3]&(g[2]|(p[2]&(g[1]|(p[1]&(g[0]|(p[0]&c[0]))))))))));
    assign c[7]=g[6]|(p[6]&c[6]);
    assign sum=p^c[7:0];
    assign c_out=c[7];
endmodule
