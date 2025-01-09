`timescale 1ns / 1ps
module benes_8_tb;
    reg clk, rst, start;
    reg [2:0] mp0, mp1, mp2, mp3, mp4, mp5, mp6, mp7;
    /*
    wire [1:0] ump0, ump1, ump2, ump3,dmp0, dmp1, dmp2, dmp3;
    wire [7:0] ci, co;
    */
    wire [19:0] state;
    Benes_8 m2(.mp0(mp0),
    .mp1(mp1),
    .mp2(mp2),
    .mp3(mp3),
    .mp4(mp4),
    .mp5(mp5),
    .mp6(mp6),
    .mp7(mp7),
    /*
    .ump0(ump0),
    .ump1(ump1),
    .ump2(ump2),
    .ump3(ump3),
    .dmp0(dmp0),
    .dmp1(dmp1),
    .dmp2(dmp2),
    .dmp3(dmp3),
    .ci(ci),
    .co(co),
    */
    .state(state),
    .clk(clk),
    .areset(rst),
    .start(start)
    );

    initial begin
        clk = 0;
        rst = 0;
        #10 rst = 1;
        #50 rst = 0;
        forever #50 clk = ~clk;
    end

    initial begin
        #10 mp0 = 3'd0;
        mp1 = 3'd1;
        mp2 = 3'd4;
        mp3 = 3'd5;
        mp4 = 3'd7;
        mp5 = 3'd6;
        mp6 = 3'd3;
        mp7 = 3'd2;
        #10 start = 1;
        #100 start = 0;
        #1000 rst = 1;
        #200 $stop;
    end
endmodule