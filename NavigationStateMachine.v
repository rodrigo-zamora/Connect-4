`timescale 1ns / 1ps
module NavigationStateMachine(
    input RESET,
    input CLOCK,
    input [3:0] PUSH_BUTTONS,
    output [1:0] STATE_OUT
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

always@(PUSH_BUTTONS or CurrState) begin
	case(CurrState)
		2'b00: begin //derecha
			if(PUSH_BUTTONS[1])
				NextState <= 2'b01; // abajo
			else if(PUSH_BUTTONS[2])
				NextState <= 2'b10;  //arriba	
			else
				NextState <= CurrState;			
		end
		3'b01: begin // abajo
			if(PUSH_BUTTONS[0])
				NextState <= 2'b00;//derecha 
			else if(PUSH_BUTTONS[3])
				NextState <= 2'b11;  // izquierda
			else
				NextState <= CurrState;	
		end
		2'b10: begin //arriba
		if(PUSH_BUTTONS[0])
				NextState <= 2'b00; //derecha
			else if(PUSH_BUTTONS[3])
				NextState <= 2'b11;  //izquierda	
			else
				NextState <= CurrState;		
		end
		2'b11: begin //izquierda	
			if(PUSH_BUTTONS[1])
				NextState <= 2'b01; // abajo
			else if(PUSH_BUTTONS[2])
				NextState <= 2'b10;  // arriba	
			else
				NextState <= CurrState;		
		end
	endcase
end

endmodule
