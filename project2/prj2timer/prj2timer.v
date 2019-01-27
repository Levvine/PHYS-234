`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:32:57 12/11/2018 
// Design Name: 
// Module Name:    prj2timer 
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
module prj2timer(
    input sclk,
    output reg TxD,
	 input reset,
    input switch
    );
	 
	reg [3:0] state;
	 // get to 19200 Hz
	reg clk;
	reg [31:0] counter;
	always @(posedge sclk) begin
		if (counter == 1302) begin
			counter <= 0;
			clk <= ~clk;
		end
		else begin
			counter <= counter + 1;
		end
	end
	
	reg [31:0] recounter;
	reg done;
	reg [7:0] timer;
	// state machine implementation
	always @(posedge clk) begin
		if (reset == 1) begin
			timer <= 0;
		end
		if (switch == 1) begin
			recounter <= recounter + 1;
			if (recounter == 1920) begin
				timer <= timer + 1;
				recounter <= 0;
			end
			TxD <= 1;
			state <= 0;
			done <= 0;
		end
		else if (state == 0 & done == 0) begin
			//timer <= (timer - (timer % 19200)) / 19200;
			TxD <= 0; //start transmitting
			state <= 1;
		end
		else if (state > 0 & state < 9) begin
			TxD <= timer[state - 1];
			state <= state + 1;
		end
		else if (state == 9) begin
			TxD <= 1; //stop transmitting
			done <= 1;
			state <= 0;
		end
	end


endmodule
