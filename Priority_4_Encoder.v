`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/04 21:25:56
// Design Name: 
// Module Name: Priority_25_Encoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Priority_4_Encoder(input wire [3:0] in1, output wire [1:0] value);
    wire [1:0] data_2;

    assign value[1] = &(in1[1:0]);
    assign value[0] = data_2[0];

    assign data_2 = value[1] ? in1[3:2] : in1[1:0];
endmodule

