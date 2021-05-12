`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:04:46 05/16/2014 
// Design Name: 
// Module Name:    VGAWrapper 
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
module VGAWrapper(
    input CLK,
	 input [1:0] MASTER_STATE,
    output [9:0] ADDRH,
    output [8:0] ADDRV,
    input [7:0] CIN,
    output[7:0] COUT,
    output HS,
    output VS,
	 output reg [7:0] COLOUR
    );
	 
	 	 reg [6:0] ApplePositionH;
	reg [5:0] ApplePositionV;
	reg [7:0] Colour;
	
	//División del clock 
	reg CLK25;
	always@(posedge CLK)
		CLK25 <= ~CLK25;
	 
	VGAControl VGACtl (
//					.CLK(CLK),
					.CLK(CLK25),
					.ADDRH(ADDRH),
					.ADDRV(ADDRV),
					.CIN(Colour),
					.COUT(COUT),
					.HS(HS),
					.VS(VS)
					);
					
	always@(posedge CLK) begin 
	 //ApplePositionH <= b'0011000;
	 //ApplePositionV <= b'0011000;

		if(MASTER_STATE == 1) // Jugando 
			Colour = CIN;
		else if(MASTER_STATE == 2) // Verde
		//if(ADDRH > {ApplePositionH, 3'b000} && ADDRV > {ApplePositionV, 3'b000}
		//&& ADDRH <= {ApplePositionH, 3'b111} &&  ADDRV <= {ApplePositionV, 3'b111})
		Colour = 8'b00010000;
		else if(MASTER_STATE == 3) // Rojo
			Colour = 8'b00000111;			
		else // Si no pasa nada la pantalla se pone negra. 
			Colour = 8'b00000000<<1;
	end

endmodule
