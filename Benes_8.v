module Benes_8 (input wire [2:0] mp0, mp1, mp2, mp3, mp4, mp5, mp6, mp7,
    input clk,
    input areset,
    input start,
    output reg [19:0] state
);
    wire [2:0] mn0,mn1,mn2,mn3,mn4,mn5,mn6,mn7,nb0, nb1, nb2, nb3, nb4, nb5, nb6, nb7;

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
    reg [7:0] ci, co;
    wire [1:0] ump0, ump1, ump2, ump3, dmp0, dmp1, dmp2, dmp3;
 // upper sub-mp sequence and lower sub-mp sequence
    reg [1:0] min_port;                 // current, last bit always 0 and hidden
    wire [1:0] min_port_w;              // wire type

    wire [2:0] mt [0:7];
    wire [2:0] mp [0:7];
    wire [2:0] nb [0:7];
    reg [1:0] ump [0:3];
    reg [1:0] dmp [0:3];
    wire [2:0] p_next_w,p_next_w1;
    reg [2:0] p_current;
    reg [3:0] cover_tbl;    

    assign ump0 = ump[0];
    assign ump1 = ump[1];
    assign ump2 = ump[2];
    assign ump3 = ump[3];

    assign dmp0 = dmp[0];
    assign dmp1 = dmp[1];
    assign dmp2 = dmp[2];
    assign dmp3 = dmp[3];

    assign mt[0] = 3'd1;
    assign mt[1] = 3'd0;
    assign mt[2] = 3'd3;
    assign mt[3] = 3'd2;
    assign mt[4] = 3'd5;
    assign mt[5] = 3'd4;
    assign mt[6] = 3'd7;
    assign mt[7] = 3'd6;
    
    assign mp[0] = mp0;
    assign mp[1] = mp1;
    assign mp[2] = mp2;
    assign mp[3] = mp3;
    assign mp[4] = mp4;
    assign mp[5] = mp5;
    assign mp[6] = mp6;
    assign mp[7] = mp7;
    

    assign nb[0] = nb0;
    assign nb[1] = nb1;
    assign nb[2] = nb2;
    assign nb[3] = nb3;
    assign nb[4] = nb4;
    assign nb[5] = nb5;
    assign nb[6] = nb6;
    assign nb[7] = nb7;

    assign p_next_w = nb[mt[p_current]];
    assign p_next_w1 = (cover_tbl[p_next_w[2:1]] == 0) ? p_next_w : {min_port_w,1'b0};

    integer i, j;

    reg[2:0] current_state, next_state;
    reg END_flag;                         // One cycle ended, 1 when ended.
              // covering table used for detecting vistied elements, 1 stands for covered.

    parameter IDLE = 3'b000, S1 = 3'b001, S2 = 3'b011, S3 = 3'b010, S4 = 3'b110, CO = 3'b111, SUB = 3'b101, ENDING = 3'b100;

    Priority_4_Encoder m4(.in1(cover_tbl),
    .value(min_port_w)
    );

always@(posedge clk or posedge areset)begin
        if(areset)begin
            current_state <= IDLE;
        end
        else begin
            current_state <= next_state;
        end
    end
 
always@(*)begin
    case(current_state)
        IDLE:begin
            if(start == 1'b1)begin
                next_state = S1;
            end
            else begin
                next_state = IDLE;
            end
        end
        S1:begin
            next_state = S2;
        end
        S2: next_state = S3;
        S3: next_state = S4;
        S4: next_state = CO;
        CO: next_state = ENDING;
        ENDING: next_state = IDLE;
        default: next_state = IDLE;
    endcase
end


always@(posedge clk or posedge areset)begin
    if (areset) begin
            ci <= 8'b000_0000;
            END_flag <= 1'b0;
            p_current <= 3'b000;
            min_port <=3'b000;             // Xdelete First Round 0, 1 are colored, so minimum port number is 3'b010
            cover_tbl <= 4'b0000;    
            co <= 8'b0000_0000;     
            END_flag <= 1'b0;  
    end

    else
        begin
        

            case (next_state)
                IDLE: begin
                    ci <= ci;
                    p_current <= p_current;
                    min_port <= min_port_w;             // wrong, but no affect 
                    cover_tbl <= cover_tbl;    
                    co <= co;     
                    END_flag <= 1'b0;   
                end
                S1:begin
                    p_current <= 3'b000;
                    ci[0] <= 1'b1;
                    ci[1] <= 1'b0;
                    cover_tbl[0] <= 1'b1;
                    cover_tbl[3:1] = 1'b0;
                    min_port <= 3'b001;  
                    co <= co;
                    END_flag <= 1'b0;
                end

                S2, S3, S4: begin
                    p_current <= p_next_w1;
                    ci[p_next_w1] <= 1'b1;
                    ci[mt[p_next_w1]] <= 1'b0;
                    cover_tbl[p_next_w1[2:1]] <= 1'b1;
                    min_port <= min_port_w;
                    co <= co;
                    END_flag <= 1'b0;
                end

                CO: begin
                        for (i=0; i<8; i=i+1) begin
                            co[mp[i]] <= ci[i];
                        end
                        for (j=0; j<4; j=j+1) begin
                            ump[j] <= (ci[2*j]== 1'b1) ? mp[2*j][2:1] : mp[2*j+1][2:1];
                            dmp[j] <= (ci[2*j]== 1'b1) ? mp[2*j+1][2:1] : mp[2*j][2:1];
                        end
                        
                        ci <= ci;
                        p_current <= p_current;
                        min_port <= min_port;
                        cover_tbl <= cover_tbl;
                        END_flag <= 1'b0;
                        
                end
                
                ENDING: begin
                            ci <= ci;
                            p_current <= p_current;
                            min_port <= min_port;
                            cover_tbl <= cover_tbl;
                            END_flag <= 1'b1;
                            co <= co;
                end
                default:begin
                            ci <= ci;
                            p_current <= p_current;
                            min_port <= min_port;
                            cover_tbl <= cover_tbl;
                            END_flag <= END_flag;
                            co <= co;
                end
            endcase
        end
end

wire state_0_0, state_0_1, state_0_2, state_1_0, state_1_1, state_1_2;
wire state_0_0d, state_0_1d, state_0_2d, state_1_0d, state_1_1d, state_1_2d;
    benes_4 m5(.in0(ump0),
        .in1(ump1),
        .in2(ump2),
        .in3(ump3),
        .state_0_0(state_0_0),
        .state_0_1(state_0_1),
        .state_0_2(state_0_2),
        .state_1_0(state_1_0),
        .state_1_1(state_1_1),
        .state_1_2(state_1_2)
    );

    benes_4 M6(.in0(dmp0),
        .in1(dmp1),
        .in2(dmp2),
        .in3(dmp3),
        .state_0_0(state_0_0d),
        .state_0_1(state_0_1d),
        .state_0_2(state_0_2d),
        .state_1_0(state_1_0d),
        .state_1_1(state_1_1d),
        .state_1_2(state_1_2d)
    );
    integer m;
    always @(*) begin
        for (m=0; m<4; m=m+1) begin
            state[5*m] = ci[2*m];
            state[5*m+4] = co[2*m];
        end
        state[1] = state_0_0;
        state[2] = state_0_1;
        state[3] = state_0_2;
        state[6] = state_1_0;
        state[7] = state_1_1;
        state[8] = state_1_2;
        state[11] = state_0_0d;
        state[12] = state_0_1d;
        state[13] = state_0_2d;
        state[16] = state_1_0d;
        state[17] = state_1_1d;
        state[18] = state_1_2d;
    end
endmodule
