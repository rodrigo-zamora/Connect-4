`timescale 1ns / 1ps
module MasterStateMachine(
    input RESET,
    input CLOCK,
    input [3:0] PUSH_BUTTONS,
    input [3:0] SCORE_IN, 
    output [1:0] STATE_OUT,
	 input SUICIDE_IN
    );

	 reg [1:0] CurrState;
	 reg [1:0] NextState;

	assign STATE_OUT = CurrState; 
	
always@(posedge CLOCK) begin
	if(RESET) begin
		CurrState <= 2'b00; 
	end 
	else begin
		CurrState <= NextState;
	end
end

always@(PUSH_BUTTONS or SCORE_IN or SUICIDE_IN or CurrState) begin
	case(CurrState)
		2'b00: begin 
			if(PUSH_BUTTONS)
				NextState <= 2'b01; // jugando			
			else
				NextState <= CurrState;			
		end
		2'b01: begin
			if(SCORE_IN == 10)
				NextState <= 2'b10;						
			else if(SUICIDE_IN)
				NextState <= 2'b11;
			else
				NextState <= CurrState;	
		end
		2'b10: //ganaste
			NextState <= CurrState;		
		2'b11: //perdiste
			NextState <= CurrState;
	endcase
end

endmodule
