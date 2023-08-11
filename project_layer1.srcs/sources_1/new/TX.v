`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/08 17:54:19
// Design Name: 
// Module Name: TX
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


module TX(clk, start, rst, din, tx_data);
input clk, rst,start;
input [7:0] din;
output reg tx_data;

reg [3:0] state;

localparam IDLE = 4'd0, START_BIT = 4'd1, TX0 = 4'd2, TX1 = 4'd3, TX2 = 4'd4, TX3 = 4'd5, TX4 = 4'd6, TX5 = 4'd7, TX6= 4'd8, TX7 = 4'd9, STOP_BIT = 4'd10; 

always@(posedge clk)
begin

    case(state)
        IDLE :if(start) state <= START_BIT; else state <= IDLE;
        START_BIT : state <= TX0; 
        TX0 : state <= TX1;
        TX1 : state <= TX2;
        TX2 : state <= TX3;
        TX3 : state <= TX4;
        TX4 : state <= TX5;
        TX5 : state <= TX6;
        TX6 : state <= TX7;
        TX7 : state <= STOP_BIT;
        STOP_BIT : state <= IDLE;
        default : state <= IDLE;
        endcase
end

always@(posedge clk)
begin

    case(state)
        IDLE : tx_data <= 1'b1;
        START_BIT : tx_data <= 1'b0;
        TX0 : tx_data <= din[0];
        TX1 :tx_data <= din[1];
        TX2 : tx_data <= din[2];
        TX3 : tx_data <= din[3];
        TX4 : tx_data <= din[4];
        TX5 : tx_data <= din[5];
        TX6 : tx_data <= din[6];
        TX7 : tx_data <= din[7];
        STOP_BIT : tx_data <= 1'b1;
        default : tx_data <= 1'b1;
        endcase
end

endmodule
