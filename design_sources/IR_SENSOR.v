`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2025 11:19:44 AM
// Design Name: 
// Module Name: IR_SENSOR
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


module IR_SENSOR(ir_pin,led_out);
input wire ir_pin;
output reg led_out;
always @ *
begin
if(ir_pin==0)
led_out=1;
else 
led_out=0;
end
endmodule
