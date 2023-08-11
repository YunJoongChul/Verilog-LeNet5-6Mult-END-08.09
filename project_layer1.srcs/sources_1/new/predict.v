`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/08 17:59:12
// Design Name: 
// Module Name: predict
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


module predict(clk, start, rst, dout_layer7, addr_layer7, predict_dout, done);
input clk, rst,start;
input signed [53:0] dout_layer7;
output reg [3:0] addr_layer7;
output reg done;
output reg [7:0] predict_dout;
reg [3:0] state;
reg signed [53:0] zero, one, two, three, four, five, six, seven, eight, nine, predict;
reg [6:0] cnt_entire, cnt_predict;


localparam IDLE = 3'd0, PREDICT = 3'd1, DONE = 3'd2;
always@(posedge clk or posedge rst)
begin
    if(rst)
        state <= IDLE;
    else
       case(state)
        IDLE : if(start) state <= PREDICT ; else state <= IDLE;
        PREDICT : if(cnt_predict == 11) state <= DONE; else state <= PREDICT;
        //DONE : if(addr_layer7 == 9) state <= IDLE; else state <= DONE; //good write?  confirm
        DONE : state <= IDLE;
        default state <= IDLE;
        endcase
 end
        
always@(posedge clk or posedge rst)
begin
    if(rst)
        addr_layer7 <= 7'd0;
    else
        case(state)
            PREDICT : if(addr_layer7 >= 9) addr_layer7 <= addr_layer7; else addr_layer7 <= addr_layer7 + 1'd1 ;
            default : addr_layer7 <= 7'd0;
            endcase
end 
 
always@(posedge clk or posedge rst)
begin
    if(rst)
        cnt_entire <= 7'd0;
    else
        case(state)
            PREDICT : cnt_entire <= cnt_entire + 1'd1;
            default : cnt_entire <= 7'd0;
            endcase
end
                
always@(posedge clk or posedge rst)
begin
    if(rst)
        cnt_predict <= 7'd0;
     else
        if(cnt_entire > 1)
        case(state)
            PREDICT : if(cnt_predict== 11) cnt_predict <= 7'd0; else cnt_predict <= cnt_predict + 1'd1 ;
            default : cnt_predict<= 7'd0;
            endcase
        else
            cnt_predict <= 7'd0; 
end 

always@(posedge clk or posedge rst)
begin
    if(rst)
        zero <= 7'd0;
    else
        case(cnt_predict)
        0 : zero <= dout_layer7;
        default : zero <= zero;
        endcase
 end    
always@(posedge clk or posedge rst)
begin
    if(rst)
        one <= 7'd0;
    else
        case(cnt_predict)
        1 : one <=  dout_layer7;
        default : one <= one;
        endcase
 end    
always@(posedge clk or posedge rst)
begin
    if(rst)
        one <= 7'd0;
    else
        case(cnt_predict)
        1 : one <=  dout_layer7;
        default : one <= one;
        endcase
 end    
always@(posedge clk or posedge rst)
begin
    if(rst)
        two <= 7'd0;
    else
        case(cnt_predict)
        2 : two <=  dout_layer7;
        default : two <= two;
        endcase
 end    
always@(posedge clk or posedge rst)
begin
    if(rst)
        three <= 7'd0;
    else
        case(cnt_predict)
        3 : three <=  dout_layer7;
        default : three <= three;
        endcase
 end    
always@(posedge clk or posedge rst)
begin
    if(rst)
        four <= 7'd0;
    else
        case(cnt_predict)
        4 : four <=  dout_layer7;
        default : four <= four;
        endcase
 end    
always@(posedge clk or posedge rst)
begin
    if(rst)
        five <= 7'd0;
    else
        case(cnt_predict)
        5 : five <=  dout_layer7;
        default : five <= five;
        endcase
 end    
always@(posedge clk or posedge rst)
begin
    if(rst)
        six <= 7'd0;
    else
        case(cnt_predict)
        6 : six <=  dout_layer7;
        default : six <= six;
        endcase
 end    
always@(posedge clk or posedge rst) 
 begin
    if(rst)
        seven <= 7'd0;
    else
        case(cnt_predict)
        7 : seven <=  dout_layer7;
        default : seven <= seven;
        endcase
 end    
 always@(posedge clk or posedge rst)
 begin
    if(rst)
        eight <= 7'd0;
    else
        case(cnt_predict)
        8 : eight <=  dout_layer7;
        default : eight <= eight;
        endcase
 end    
 
 always@(posedge clk or posedge rst)
 begin
    if(rst)
        nine <= 7'd0;
    else
        case(cnt_predict)
        9 : nine <=  dout_layer7;
        default : nine <= nine;
        endcase
 end    
 
  always@(posedge clk or posedge rst)
 begin
    if(rst)
         predict <= 7'd0;
    else     
         case(cnt_predict)
            1 : predict <= predict;
            2 : predict <= (zero > one) ? zero : one;
            3 : predict <= (predict > two) ? predict : two;
            4 : predict <= (predict > three) ? predict : three;
            5 : predict <= (predict > four) ? predict : four;
            6 : predict <= (predict > five) ? predict : five;
            7 : predict <= (predict > six) ? predict : six; 
            8 : predict <= (predict > seven) ? predict : seven;
            9 : predict <= (predict > eight) ? predict : eight;
           10 : predict <= (predict > nine) ? predict : nine;
           default : predict <= predict;
           endcase
end  
  always@(posedge clk or posedge rst)
 begin
    if(rst)
         predict_dout <= 7'd0;
    else
        case(predict)
        zero : predict_dout <= 8'd48;
        one : predict_dout <= 8'd49;
        two : predict_dout <= 8'd50;
        three : predict_dout <= 8'd51;
        four : predict_dout <= 8'd52;
        five : predict_dout <= 8'd53;
        six : predict_dout <= 8'd54;
        seven : predict_dout <= 8'd55;
        eight : predict_dout <= 8'd56;
        nine : predict_dout <= 8'd57;
        default : predict_dout <= predict_dout;
        endcase
end  
always@(posedge clk or posedge rst)
begin
    if(rst)
        done <= 1'd0;
    else
        case(state)
        DONE : done <= 1'd1;
        default : done <= 1'd0;
        endcase
end
                
endmodule
