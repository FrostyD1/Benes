module decoder2to4 (
    input [1:0] in,     // 3-bit input
    output reg [3:0] out // 8-bit output
);

always @(*) begin
    out = 4'b0000; // 初始化输出为全0
    case (in)
        2'b00: out[0] = 1;
        2'b01: out[1] = 1;
        2'b10: out[2] = 1;
        2'b11: out[3] = 1;
        default: out = 4'b0000; // 默认情况
    endcase
end

endmodule