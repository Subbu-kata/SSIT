`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2025 06:58:29 PM
// Design Name: 
// Module Name: tb_topmodule
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


module tb_topmodule( );
reg clk,reset,ir_pin;
wire relay_out;

touchless_water_tap uut (.clk(clk),.reset(reset),.ir_pin(ir_pin),.relay_out(relay_out));

initial clk = 0;

always #10 clk = ~clk; 


initial begin 
reset = 1;#100;
reset = 0;
ir_pin = 0;#200;
ir_pin = 1;#200;
ir_pin = 0;#50;
ir_pin = 1;#200;
ir_pin = 0;#200

$finish;


end

endmodule
