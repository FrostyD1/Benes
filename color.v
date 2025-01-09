// File Version--1.0
// 2025/01/03
// Author: DONG TIANHAO
// Color.v
// Used For Coloring Peripherial Switching Units
`timescale 1ns / 1ps

module color (
    input wire [2:0] mp0, mp1, mp2, mp3, mp4, mp5, mp6, mp7,mn0, mn1, mn2, mn3, mn4, mn5, mn6, mn7, nb0, nb1, nb2, nb3, nb4, nb5, nb6, nb7,
    input clk,
    input areset,
    input start,
    output reg [7:0] ci, co            // color table in & out, "U" -> 1, "L" -> 0
);
    reg [1:0] min_port;                 // current, last bit always 0 and hidden
    wire [1:0] min_port_w;              // wire type

    wire [2:0] mt [0:7];
    wire [2:0] mp [0:7];
    wire [2:0] nb [0:7];
    wire [2:0] p_next_w,p_next_w1;
    reg [2:0] p_current;
    reg [3:0] cover_tbl;    
//    reg [2:0] cnt;

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
    assign p_next_w1 = (cover_tbl[p_next_w[2:1]] == 0) ? p_next_w : {min_port,1'b0};
    integer i;
    reg[2:0] current_state, next_state;
    reg END_flag;                         // One cycle ended, 1 when ended.
              // covering table used for detecting vistied elements, 1 stands for covered.

    parameter IDLE = 3'b000, S1 = 3'b001, S2 = 3'b011, S3 = 3'b010, S4 = 3'b110, CO = 3'b111, ENDING = 3'b101;

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
                    ci[nb[1]] <= 1'b0;
                    cover_tbl[0] <= 1'b1;
                    cover_tbl[3:1] = 1'b0;
                    min_port <= min_port_w;  // wrong, but no affect to S2, because S1 won't generate contradiction
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
        
endmodule


/* The most time consuming bug was that, I defined p_next as a register who samples the real-time p_next_w, but using p_next to perform operations each cycle, which delays one cycle
*/