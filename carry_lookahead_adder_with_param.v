module CarryLookaheadAdder_NoInstantiation #(parameter N = 64) (input [N-1:0] A, 
    input [N-1:0] B, output [N:0] Sum, output Cout);
    wire [N:0] cin;
    wire [N-1:0] gen, pro;
    for(i=0;i<N;i=i+1) begin
        assign gen[i] = A[i] & B[i];
        assign pro[i] = A[i] ^ B[i];
    end

    assign cin[0] = 0;
    genvar i;
    for(i=1;i<N+1;i=i+1) begin
        assign cin[i] = gen[i-1] | (pro[i-1] & cin[i-1]);
    end

    for(i=0;i<N+1;i=i+1) begin
        assign Sum[i] = A[i] ^ B[i] ^ cin[i];
    end
    assign Cout = cin[N];
    assign Sum = {Cout, Sum[N-1:0]};

endmodule