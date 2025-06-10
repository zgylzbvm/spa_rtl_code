module basic_compute_block(
    input anded,
    input nored,
    input clk,
    input carry_in,
    output sum_out,
    output carry_out,
    output write_back_bit,
    output wire xored,
    input [1:0] wbsel, //写回选择信号
    input shift_EN, //写到下一级的信号选择
    input dff_q
);
wire red_out;
wire green_out;
wire carrybit;
wire inv;
wire others;
reg d;
reg write_back_reg;
assign red_out = anded?1'b0:nored;


assign sum_out = xored ^ carry_in;

assign green_out = red_out?carry_in:1'b0;

assign carrybit = anded | green_out;

assign carry_out = shift_EN?anded:carrybit;

assign inv = !anded;

assign others = d;

always@(posedge clk) begin
    d <= dff_q;
end

always @(*) begin
    case(wbsel)
    2'b00 : begin
        write_back_reg = inv;
    end
    2'b01 : begin
        write_back_reg = anded;
    end
    2'b10 : begin
        write_back_reg = sum_out;
    end
    2'b11 : begin
        write_back_reg = others;
    end
    endcase
end

assign write_back_bit = write_back_reg;


endmodule





