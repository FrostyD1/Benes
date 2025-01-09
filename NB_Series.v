module NB_Series (
    input wire [2:0] mp0, mp1, mp2, mp3, mp4, mp5, mp6, mp7,mn0, mn1, mn2, mn3, mn4, mn5, mn6, mn7,
    output wire [2:0]  nb0, nb1, nb2, nb3, nb4, nb5, nb6, nb7
);
    //wire [2:0] mp0, mp1, mp2, mp3, mp4, mp5, mp6, mp7;
    //reg [2:0] nb0,nb1, nb2, nb3, nb4, nb5, nb6, nb7;
    wire [2:0] mp [0:7];
    reg [2:0] nb [0:7];
    wire [2:0] mt [0:7];
    wire [2:0] mn [0:7];
    

    assign mp[0] = mp0;
    assign mp[1] = mp1;
    assign mp[2] = mp2;
    assign mp[3] = mp3;
    assign mp[4] = mp4;
    assign mp[5] = mp5;
    assign mp[6] = mp6;
    assign mp[7] = mp7;

    assign mn[0] = mn0;
    assign mn[1] = mn1;
    assign mn[2] = mn2;
    assign mn[3] = mn3;
    assign mn[4] = mn4;
    assign mn[5] = mn5;
    assign mn[6] = mn6;
    assign mn[7] = mn7;


    assign nb0 = nb[0];
    assign nb1 = nb[1];
    assign nb2 = nb[2];
    assign nb3 = nb[3];
    assign nb4 = nb[4];
    assign nb5 = nb[5];
    assign nb6 = nb[6];
    assign nb7 = nb[7];


    assign mt[0] = 3'd1;
    assign mt[1] = 3'd0;
    assign mt[2] = 3'd3;
    assign mt[3] = 3'd2;
    assign mt[4] = 3'd5;
    assign mt[5] = 3'd4;
    assign mt[6] = 3'd7;
    assign mt[7] = 3'd6;


    integer i;
    always @(*) begin
        for (i=0; i<8; i=i+1) begin
            nb[i] = mn[mt[mp[i]]];
        end
    end
    
endmodule