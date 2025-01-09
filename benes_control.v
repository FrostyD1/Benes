module benes_control(
    input [1:0] in0,
    input [1:0] in1,
    input [1:0] in2,
    input [1:0] in3,
    output reg state_0_0,
    output reg state_0_1,
    output reg state_0_2,
    output reg state_0_3,
    output reg state_1_0,
    output reg state_1_1,
    output reg state_1_2,
    output reg state_1_3
);

always @(*) begin
    case({in0, in1, in2, in3})
        {2'd0, 2'd1, 2'd3, 2'd2}: begin
            state_0_0 = 1'b1;
            state_0_1 = 1'b1;
            state_0_2 = 1'b1;
            state_1_0 = 1'b1;
            state_1_1 = 1'b1;
            state_1_2 = 1'b0;
        end
        {2'd0, 2'd2, 2'd1, 2'd3}: begin
            state_0_0 = 1'b1;
            state_0_1 = 1'b1;
            state_0_2 = 1'b1;
            state_1_0 = 1'b0;
            state_1_1 = 1'b0;
            state_1_2 = 1'b0;
        end
        {2'd0, 2'd2, 2'd3, 2'd1}: begin
            state_0_0 = 1'b1;
            state_0_1 = 1'b1;
            state_0_2 = 1'b1;
            state_1_0 = 1'b1;
            state_1_1 = 1'b0;
            state_1_2 = 1'b0;
        end
        {2'd0, 2'd3, 2'd1, 2'd2}: begin
            state_0_0 = 1'b1;
            state_0_1 = 1'b1;
            state_0_2 = 1'b1;
            state_1_0 = 1'b0;
            state_1_1 = 1'b0;
            state_1_2 = 1'b1;
        end
        {2'd0, 2'd3, 2'd2, 2'd1}: begin
            state_0_0 = 1'b1;
            state_0_1 = 1'b1;
            state_0_2 = 1'b1;
            state_1_0 = 1'b1;
            state_1_1 = 1'b0;
            state_1_2 = 1'b1;
        end
        {2'd1, 2'd0, 2'd2, 2'd3}: begin
            state_0_0 = 1'b1;
            state_0_1 = 1'b1;
            state_0_2 = 1'b0;
            state_1_0 = 1'b1;
            state_1_1 = 1'b1;
            state_1_2 = 1'b1;
        end
        {2'd1, 2'd0, 2'd3, 2'd2}: begin
            state_0_0 = 1'b1;
            state_0_1 = 1'b1;
            state_0_2 = 1'b0;
            state_1_0 = 1'b1;
            state_1_1 = 1'b1;
            state_1_2 = 1'b0;
        end
        {2'd1, 2'd2, 2'd0, 2'd3}: begin
            state_0_0 = 1'b1;
            state_0_1 = 1'b1;
            state_0_2 = 1'b0;
            state_1_0 = 1'b0;
            state_1_1 = 1'b0;
            state_1_2 = 1'b0;
        end
        {2'd1, 2'd2, 2'd3, 2'd0}: begin
            state_0_0 = 1'b1;
            state_0_1 = 1'b1;
            state_0_2 = 1'b0;
            state_1_0 = 1'b1;
            state_1_1 = 1'b0;
            state_1_2 = 1'b0;
        end
        {2'd1, 2'd3, 2'd0, 2'd2}: begin
            state_0_0 = 1'b1;
            state_0_1 = 1'b1;
            state_0_2 = 1'b0;
            state_1_0 = 1'b0;
            state_1_1 = 1'b0;
            state_1_2 = 1'b1;
        end
        {2'd1, 2'd3, 2'd2, 2'd0}: begin
            state_0_0 = 1'b1;
            state_0_1 = 1'b1;
            state_0_2 = 1'b0;
            state_1_0 = 1'b1;
            state_1_1 = 1'b0;
            state_1_2 = 1'b1;
        end
        {2'd2, 2'd0, 2'd1, 2'd3}: begin
            state_0_0 = 1'b1;
            state_0_1 = 1'b0;
            state_0_2 = 1'b0;
            state_1_0 = 1'b1;
            state_1_1 = 1'b1;
            state_1_2 = 1'b1;
        end
        {2'd2, 2'd0, 2'd3, 2'd1}: begin
            state_0_0 = 1'b1;
            state_0_1 = 1'b0;
            state_0_2 = 1'b0;
            state_1_0 = 1'b0;
            state_1_1 = 1'b1;
            state_1_2 = 1'b1;
        end
        {2'd2, 2'd1, 2'd0, 2'd3}: begin
            state_0_0 = 1'b1;
            state_0_1 = 1'b0;
            state_0_2 = 1'b1;
            state_1_0 = 1'b1;
            state_1_1 = 1'b1;
            state_1_2 = 1'b1;
        end
        {2'd2, 2'd1, 2'd3, 2'd0}: begin
            state_0_0 = 1'b1;
            state_0_1 = 1'b0;
            state_0_2 = 1'b1;
            state_1_0 = 1'b0;
            state_1_1 = 1'b1;
            state_1_2 = 1'b1;
        end
        {2'd2, 2'd3, 2'd0, 2'd1}: begin
            state_0_0 = 1'b1;
            state_0_1 = 1'b0;
            state_0_2 = 1'b1;
            state_1_0 = 1'b1;
            state_1_1 = 1'b0;
            state_1_2 = 1'b1;
        end
        {2'd2, 2'd3, 2'd1, 2'd0}: begin
            state_0_0 = 1'b1;
            state_0_1 = 1'b0;
            state_0_2 = 1'b0;
            state_1_0 = 1'b1;
            state_1_1 = 1'b0;
            state_1_2 = 1'b1;
        end
        {2'd3, 2'd0, 2'd1, 2'd2}: begin
            state_0_0 = 1'b1;
            state_0_1 = 1'b0;
            state_0_2 = 1'b0;
            state_1_0 = 1'b1;
            state_1_1 = 1'b1;
            state_1_2 = 1'b0;
        end
        {2'd3, 2'd0, 2'd2, 2'd1}: begin
            state_0_0 = 1'b1;
            state_0_1 = 1'b0;
            state_0_2 = 1'b0;
            state_1_0 = 1'b0;
            state_1_1 = 1'b1;
            state_1_2 = 1'b0;
        end
        {2'd3, 2'd1, 2'd0, 2'd2}: begin
            state_0_0 = 1'b1;
            state_0_1 = 1'b0;
            state_0_2 = 1'b1;
            state_1_0 = 1'b1;
            state_1_1 = 1'b1;
            state_1_2 = 1'b0;
        end
        {2'd3, 2'd1, 2'd2, 2'd0}: begin
            state_0_0 = 1'b1;
            state_0_1 = 1'b0;
            state_0_2 = 1'b1;
            state_1_0 = 1'b0;
            state_1_1 = 1'b1;
            state_1_2 = 1'b0;
        end
        {2'd3, 2'd2, 2'd0, 2'd1}: begin
            state_0_0 = 1'b1;
            state_0_1 = 1'b0;
            state_0_2 = 1'b1;
            state_1_0 = 1'b1;
            state_1_1 = 1'b0;
            state_1_2 = 1'b0;
        end
        {2'd3, 2'd2, 2'd1, 2'd0}: begin
            state_0_0 = 1'b1;
            state_0_1 = 1'b0;
            state_0_2 = 1'b0;
            state_1_0 = 1'b1;
            state_1_1 = 1'b0;
            state_1_2 = 1'b0;
        end
        default: begin
            state_0_0 = 1'b0;
            state_0_1 = 1'b0;
            state_0_2 = 1'b0;
            state_1_0 = 1'b0;
            state_1_1 = 1'b0;
            state_1_2 = 1'b0;
        end
    endcase
end

endmodule