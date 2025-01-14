module Benes_8p (input wire [2:0] mp0, mp1, mp2, mp3, mp4, mp5, mp6, mp7,
    input clk,
    output reg [19:0] state
);
    wire [2:0] nb0, nb1, nb2, nb3, nb4, nb5, nb6, nb7;
    wire [2:0]  mn0, mn1, mn2, mn3, mn4, mn5, mn6, mn7;
    
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

    NB_Series m2(.mp0(MP_1[0]),
    .mp1(MP_1[1]),
    .mp2(MP_1[2]),
    .mp3(MP_1[3]),
    .mp4(MP_1[4]),
    .mp5(MP_1[5]),
    .mp6(MP_1[6]),
    .mp7(MP_1[7]),
    .mn0(MN_1[0]),
    .mn1(MN_1[1]),
    .mn2(MN_1[2]),
    .mn3(MN_1[3]),
    .mn4(MN_1[4]),
    .mn5(MN_1[5]),
    .mn6(MN_1[6]),
    .mn7(MN_1[7]),
    .nb0(nb0),
    .nb1(nb1),
    .nb2(nb2),
    .nb3(nb3),
    .nb4(nb4),
    .nb5(nb5),
    .nb6(nb6),
    .nb7(nb7)
    );


    wire [2:0] mp [0:7];

    integer i, j, m;

// First Stage
    reg [2:0] MP_1 [0:7];
    reg [2:0] MN_1 [0:7];

// Second Stage
    reg [2:0] MP_2 [0:7];
    reg [2:0] NB_2 [0:7];
    reg [3:0] CI_2;

// Third Stage
    reg [2:0] MP_3 [0:7];
    reg [2:0] NB_3 [0:7];
    reg [3:0] CI_3;
    wire [2:0] P_NEXT_3_W;
    reg [2:0] P_NEXT_3;
    reg [3:0] COVER_TBL_3;

    assign P_NEXT_3_W = (NB_2[1] == 3'b000) ? 3'b010 : NB_2[1];

    wire [3:0] MASK_3_2, MASK_3;
    wire [1:0] MIN_PORT_3_W; 
    assign MASK_3_2 = 4'b0001;

    decoder2to4 d3(.in(P_NEXT_3_W[2:1]),
    .out(MASK_3)
    );

    Priority_4_Encoder p3(.in1(COVER_TBL_3),
    .value(MIN_PORT_3_W)
    );

// Fourth Stage
    reg [2:0] MP_4 [0:7];
    reg [2:0] NB_4 [0:7];
    reg [3:0] CI_4;
    wire [2:0] P_NEXT_4_W, P_NEXT_4_W1;
    reg [2:0] P_NEXT_4;
    reg [3:0] COVER_TBL_4;

    assign P_NEXT_4_W = NB_3[{P_NEXT_3[2:1], ~P_NEXT_3[0]}];
    assign P_NEXT_4_W1 = (COVER_TBL_3[P_NEXT_4_W[2:1]] == 0) ? P_NEXT_4_W: {MIN_PORT_3_W,1'b0} ;

    wire [3:0] MASK_4;
    wire [1:0] MIN_PORT_4_W;


    decoder2to4 d4(.in(P_NEXT_4_W1[2:1]),
    .out(MASK_4)
    );

    Priority_4_Encoder p4(.in1(COVER_TBL_4),
    .value(MIN_PORT_4_W)
    );


// Fifth Stage
    reg [2:0] P_NEXT_5;
    reg [3:0] CI_5;
    reg [2:0] MP_5 [0:7];
    wire [2:0] P_NEXT_5_W, P_NEXT_5_W1;
    assign P_NEXT_5_W = NB_4[{P_NEXT_4[2:1], ~P_NEXT_4[0]}];
    assign P_NEXT_5_W1 = (COVER_TBL_4[P_NEXT_5_W[2:1]] == 0) ? P_NEXT_5_W: {MIN_PORT_4_W,1'b0} ;

    wire [3:0] MASK_5;


    decoder2to4 d5(.in(P_NEXT_5_W1[2:1]),
    .out(MASK_5)
    );

// Sixth Stage
    reg [7:0] CO;
    reg [3:0] CI_6;
    reg [1:0] ump [0:3];
    reg [1:0] dmp [0:3];
    wire state_0_0, state_0_1, state_0_2, state_1_0, state_1_1, state_1_2;
    wire state_0_0d, state_0_1d, state_0_2d, state_1_0d, state_1_1d, state_1_2d;
    benes_4 B6_U(.in0(ump[0]),
        .in1(ump[1]),
        .in2(ump[2]),
        .in3(ump[3]),
        .state_0_0(state_0_0),
        .state_0_1(state_0_1),
        .state_0_2(state_0_2),
        .state_1_0(state_1_0),
        .state_1_1(state_1_1),
        .state_1_2(state_1_2)
    );

    benes_4 B6_D(.in0(dmp[0]),
        .in1(dmp[1]),
        .in2(dmp[2]),
        .in3(dmp[3]),
        .state_0_0(state_0_0d),
        .state_0_1(state_0_1d),
        .state_0_2(state_0_2d),
        .state_1_0(state_1_0d),
        .state_1_1(state_1_1d),
        .state_1_2(state_1_2d)
    );

    always@(posedge clk)begin

        // First Stage
        MN_1[0] <= mn0;
        MN_1[1] <= mn1;
        MN_1[2] <= mn2;
        MN_1[3] <= mn3;
        MN_1[4] <= mn4;
        MN_1[5] <= mn5;
        MN_1[6] <= mn6;
        MN_1[7] <= mn7;

        MP_1[0] <= mp0;
        MP_1[1] <= mp1;
        MP_1[2] <= mp2;
        MP_1[3] <= mp3;
        MP_1[4] <= mp4;
        MP_1[5] <= mp5;
        MP_1[6] <= mp6;
        MP_1[7] <= mp7;


        // Second Stage
        NB_2[0] <= nb0;
        NB_2[1] <= nb1;
        NB_2[2] <= nb2;
        NB_2[3] <= nb3;
        NB_2[4] <= nb4;
        NB_2[5] <= nb5;
        NB_2[6] <= nb6;
        NB_2[7] <= nb7;


        MP_2[0] <= MP_1[0];
        MP_2[1] <= MP_1[1];
        MP_2[2] <= MP_1[2];
        MP_2[3] <= MP_1[3];
        MP_2[4] <= MP_1[4];
        MP_2[5] <= MP_1[5];
        MP_2[6] <= MP_1[6];
        MP_2[7] <= MP_1[7];

        CI_2[0] <= 1'b1;
        CI_2[1] <= 1'b0;
        CI_2[2] <= 1'b0;
        CI_2[3] <= 1'b0;

        // Third Stage
        P_NEXT_3 <= P_NEXT_3_W; 
        CI_3 <= CI_2 | (MASK_3 & {4{~P_NEXT_3_W[0]}});

        MP_3[0] <= MP_2[0];
        MP_3[1] <= MP_2[1];
        MP_3[2] <= MP_2[2];
        MP_3[3] <= MP_2[3];
        MP_3[4] <= MP_2[4];
        MP_3[5] <= MP_2[5];
        MP_3[6] <= MP_2[6];
        MP_3[7] <= MP_2[7];

        NB_3[0] <= NB_2[0];
        NB_3[1] <= NB_2[1];
        NB_3[2] <= NB_2[2];
        NB_3[3] <= NB_2[3];
        NB_3[4] <= NB_2[4];
        NB_3[5] <= NB_2[5];
        NB_3[6] <= NB_2[6];
        NB_3[7] <= NB_2[7];
        COVER_TBL_3 <= MASK_3 | MASK_3_2;

        // Fourth Stage
        P_NEXT_4 <= P_NEXT_4_W1; 
        CI_4 <= CI_3 | (MASK_4 & {4{~P_NEXT_4_W1[0]}});

        MP_4[0] <= MP_3[0];
        MP_4[1] <= MP_3[1];
        MP_4[2] <= MP_3[2];
        MP_4[3] <= MP_3[3];
        MP_4[4] <= MP_3[4];
        MP_4[5] <= MP_3[5];
        MP_4[6] <= MP_3[6];
        MP_4[7] <= MP_3[7];

        NB_4[0] <= NB_3[0];
        NB_4[1] <= NB_3[1];
        NB_4[2] <= NB_3[2];
        NB_4[3] <= NB_3[3];
        NB_4[4] <= NB_3[4];
        NB_4[5] <= NB_3[5];
        NB_4[6] <= NB_3[6];
        NB_4[7] <= NB_3[7];
        COVER_TBL_4 <= MASK_4 | COVER_TBL_3;

        // Fifth Stage
        MP_5[0] <= MP_4[0];
        MP_5[1] <= MP_4[1];
        MP_5[2] <= MP_4[2];
        MP_5[3] <= MP_4[3];
        MP_5[4] <= MP_4[4];
        MP_5[5] <= MP_4[5];
        MP_5[6] <= MP_4[6];
        MP_5[7] <= MP_4[7];

        P_NEXT_5 <= P_NEXT_5_W1; 
        CI_5 <= CI_4 | (MASK_5 & {4{~P_NEXT_5_W1[0]}});

        // Sixth Stage 
        for (i=0; i<8; i=i+1) begin
            CO[MP_5[i]] <= CI_5[i[2:1]] ^ i[0] ;
        end

        for (j=0; j<4; j=j+1) begin
            ump[j] <= (CI_5[j]== 1'b1) ? MP_5[2*j][2:1] : MP_5[2*j+1][2:1];
            dmp[j] <= (CI_5[j]== 1'b1) ? MP_5[2*j+1][2:1] : MP_5[2*j][2:1];
        end

        CI_6 <= CI_5;
        //  Sixth Stage
        for (m=0; m<4; m=m+1) begin
            state[5*m] <= CI_6[m];
            state[5*m+4] <= CO[2*m];
        end
        state[1] <= state_0_0;
        state[2] <= state_0_1;
        state[3] <= state_0_2;
        state[6] <= state_1_0;
        state[7] <= state_1_1;
        state[8] <= state_1_2;
        state[11] <= state_0_0d;

        state[12] <= state_0_1d;
        state[13] <= state_0_2d;
        state[16] <= state_1_0d;
        state[17] <= state_1_1d;
        state[18] <= state_1_2d;
                    
    end

endmodule
