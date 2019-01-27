`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:16:23 10/11/2018 
// Design Name: 
// Module Name:    waves 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module waves(input[3:0] button, input switch, input clk, output reg speaker);
// code from fpga5fun

// first create a 16bit binary counter
	reg [31:0] counter;
	always @(posedge clk) begin
		counter <= counter+1+switch;
// and use the most significant bit (MSB) of the counter to drive the speaker
		case(button)
			0: speaker = 0;
			1: speaker = counter[14];
			2: speaker = counter[15];
			4: speaker = counter[16];
			8: speaker = counter[17];
		endcase
	end
	
endmodule