`timescale 1ns / 1ps
module ScoreCounter(
		input RESET,
		input GAMECLOCK,
		input REACHED_TARGET,
		output reg [3:0] CURRENT_SCORE
    );
	
reg enable = 1;
	
always@(posedge REACHED_TARGET or posedge RESET) begin
	if(RESET) 
		CURRENT_SCORE <= 0;
	else if(enable) begin
		CURRENT_SCORE <= CURRENT_SCORE+1;
	end
end

always@(posedge GAMECLOCK or posedge REACHED_TARGET or posedge RESET) begin
	if(RESET)
		enable <= 1;
	else if(REACHED_TARGET)
		enable <= 0;
	else
		enable <= 1;
end

endmodule
