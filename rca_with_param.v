module RippleCarryAdder #(parameter N = 64) (input[N-1:0] A, input[N-1:0] B, output[N:0] Sum, output[N-1:0] Cout);
    wire Cin;
    assign Cin = 1'b0;
    assign Sum[0] = A[0] ^ B[0] ^ Cin;
    assign Cout [0] = (A[0] & B[0]) | (A[0] & Cin) | (B[0] & Cin );
    genvar i;
    for(i=1;i<N;i=i+1) begin
        assign Sum[i] = A[i] ^ B[i] ^ Cout[i-1];
        assign Cout[i] = (A[i] & B[i]) | (A[i] & Cout [i-1] ) | (B[i] & Cout [i-1] );
    end
endmodule
