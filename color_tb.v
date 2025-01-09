`timescale 1ns / 1ps
module color_tb;
    reg clk, rst, start;
    reg [2:0] mp0, mp1, mp2, mp3, mp4, mp5, mp6, mp7;
    wire [2:0] mn0,mn1,mn2,mn3,mn4,mn5,mn6,mn7,nb0, nb1, nb2, nb3, nb4, nb5, nb6, nb7;
    wire [7:0] ci, co;
    MN_Serials m1(.mp0(mp0),
    .mp1(mp1),
    .mp2(mp2),
    .mp3(mp3),
    .mp4(mp4),
    .mp5(mp5),
    .mp6(mp6),
    .mp7(mp7),
    .mn0(mn0),
    .mn1(mn1),
    .mn2(mn2),
    .mn3(mn3),
    .mn4(mn4),
    .mn5(mn5),
    .mn6(mn6),
    .mn7(mn7)
    );

    NB_Series m2(.mp0(mp0),
    .mp1(mp1),
    .mp2(mp2),
    .mp3(mp3),
    .mp4(mp4),
    .mp5(mp5),
    .mp6(mp6),
    .mp7(mp7),
    .mn0(mn0),
    .mn1(mn1),
    .mn2(mn2),
    .mn3(mn3),
    .mn4(mn4),
    .mn5(mn5),
    .mn6(mn6),
    .mn7(mn7),
    .nb0(nb0),
    .nb1(nb1),
    .nb2(nb2),
    .nb3(nb3),
    .nb4(nb4),
    .nb5(nb5),
    .nb6(nb6),
    .nb7(nb7)
    );

    color m3(.mp0(mp0),
    .mp1(mp1),
    .mp2(mp2),
    .mp3(mp3),
    .mp4(mp4),
    .mp5(mp5),
    .mp6(mp6),
    .mp7(mp7),
    .mn0(mn0),
    .mn1(mn1),
    .mn2(mn2),
    .mn3(mn3),
    .mn4(mn4),
    .mn5(mn5),
    .mn6(mn6),
    .mn7(mn7),
    .nb0(nb0),
    .nb1(nb1),
    .nb2(nb2),
    .nb3(nb3),
    .nb4(nb4),
    .nb5(nb5),
    .nb6(nb6),
    .nb7(nb7),
    .clk(clk),
    .areset(rst),
    .start(start),
    .ci(ci),
    .co(co)
    );


    initial begin
        clk = 0;
        rst = 0;
        #10 rst = 1;
        #50 rst = 0;
        forever #50 clk = ~clk;
    end

    initial begin
        #10 mp0 = 3'd6;
        mp1 = 3'd2;
        mp2 = 3'd5;
        mp3 = 3'd4;
        mp4 = 3'd0;
        mp5 = 3'd7;
        mp6 = 3'd1;
        mp7 = 3'd3;
        #10 start = 1;
        #100 start = 0;
        #1000 rst = 1;
        #200 $stop;
    end
endmodule