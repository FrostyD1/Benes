module MN_Serials (
    input wire [2:0] mp0, mp1, mp2, mp3, mp4, mp5, mp6, mp7,
    output wire [2:0]  mn0, mn1, mn2, mn3, mn4, mn5, mn6, mn7
);
    //wire [2:0] mp0, mp1, mp2, mp3, mp4, mp5, mp6, mp7;
    //reg [2:0] mn0,mn1, mn2, mn3, mn4, mn5, mn6, mn7;
    wire [2:0] mp [0:7];
    reg [2:0] mn [0:7];


    assign mp[0] = mp0;
    assign mp[1] = mp1;
    assign mp[2] = mp2;
    assign mp[3] = mp3;
    assign mp[4] = mp4;
    assign mp[5] = mp5;
    assign mp[6] = mp6;
    assign mp[7] = mp7;


    assign mn0 = mn[0];
    assign mn1 = mn[1];
    assign mn2 = mn[2];
    assign mn3 = mn[3];
    assign mn4 = mn[4];
    assign mn5 = mn[5];
    assign mn6 = mn[6];
    assign mn7 = mn[7];

    integer i;
    always @(*) begin
        for (i=0; i<8; i=i+1) begin
            mn[mp[i]] = i;
        end
    end
    
endmodule