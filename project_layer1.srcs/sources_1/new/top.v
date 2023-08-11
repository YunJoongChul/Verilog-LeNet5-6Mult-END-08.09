`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/04 14:24:26
// Design Name: 
// Module Name: top
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


module top(clk, rst, start, TXD);

input clk, rst, start;
output TXD;

wire signed [263:0] dout_layer1;
wire layer1_done, layer2_done, layer3_done, layer4_done, layer5_done, layer6_done, layer7_done, predict_done;
wire [11:0] addr_layer1;
wire [10:0] addr_layer2;
wire [9:0]  addr_layer3; 
wire [8:0] addr_layer4;
wire [6:0] addr_layer5;
wire [6:0] addr_layer6;
wire [3:0] addr_layer7;
wire signed [21:0] dout_layer2;
wire done;
wire signed [59:0] dout_layer3;
wire signed [29:0] dout_layer4;
wire signed [37:0] dout_layer5;
wire signed [45:0] dout_layer6;
wire signed [53:0] dout_layer7;
wire [7:0] dout_predict;
wire clk_out;
clk_divider DUT(.clk(clk), .clk_out(clk_out));
layer1 u0(.clk(clk), .rst(rst), .start(start), .addr_layer1(addr_layer1), .dout(dout_layer1), .done(layer1_done)); 
layer2 u1(.clk(clk), .rst(rst), .start(layer1_done), .dout_layer1(dout_layer1), .addr_layer1(addr_layer1), .addr_layer2(addr_layer2),.dout(dout_layer2), .done(layer2_done));
layer3 u2(.clk(clk), .rst(rst), .start(layer2_done), .dout_layer2(dout_layer2), .addr_layer2(addr_layer2), .addr_layer3(addr_layer3),.dout(dout_layer3), .done(layer3_done));
layer4 u3(.clk(clk), .rst(rst), .start(layer3_done), .dout_layer3(dout_layer3), .addr_layer3(addr_layer3), .addr_layer4(addr_layer4), .dout(dout_layer4), .done(layer4_done));
layer5 u4(.clk(clk), .rst(rst), .start(layer4_done), .dout_layer4(dout_layer4), .addr_layer4(addr_layer4), .addr_layer5(addr_layer5), .dout(dout_layer5), .done(layer5_done));
layer6 u5(.clk(clk), .rst(rst), .start(layer5_done), .dout_layer5(dout_layer5), .addr_layer5(addr_layer5), .addr_layer6(addr_layer6), .dout(dout_layer6), .done(layer6_done));
//layer7 u6(.clk(clk), .rst(rst), .start(layer6_done), .dout_layer6(dout_layer6), .addr_layer6(addr_layer6), .dout(dout), .done(done));
layer7 u6(.clk(clk), .rst(rst), .start(layer6_done), .dout_layer6(dout_layer6), .addr_layer6(addr_layer6), .addr_layer7(addr_layer7), .dout(dout_layer7), .done(layer7_done));
predict u7(.clk(clk), .start(layer7_done), .rst(rst), .dout_layer7(dout_layer7), .addr_layer7(addr_layer7), .predict_dout(dout_predict), .done(predict_done));
TX u8(.clk(clk_out), .start(predict_done), .rst(rst), .din(dout_predict), .tx_data(TXD));
endmodule
