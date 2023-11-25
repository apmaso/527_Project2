/////////////////////////////////////////////////////////////
// CLA_Adder_alg.sv - 
//
// Author:		    		Alexander Maso
// Created:				10/21/22	
// Last Modified:		   	10/26/22
//
// Description:
// ------------
// 
//
// Notes:
// ------------
// 
//
//////////////////////////////////////////////////////////////

module CLA_Adder_alg(

	input logic	[15:0]			A, B, 
	input logic				C_In,
	input logic				clock,
	output logic	[15:0]			Sum,
	output logic				C_Out
);

// internal variables

integer i, j;
logic		[16:0]				Carry;

// Bit 0 is the initial carry in (as input)
// Bit 16 is therefore the final Carry out
Carry[0] = C_In;

// combinational block to calculate the carry values
always_comb begin
for (i=1; i<17; i++) begin
	if (Carry[i-1] == 0) begin
		Carry[i] = (A[i-1]*B[i-1]);
	end
	if (Carry[i-1] == 1) begin
		if ((A[i-1]+B[i-1]>0) begin
			Carry[i] = 1;
		end
		else begin
			Carry[i] = 0;
		end
	end
end

for (j=0; j<16; j++) begin
	if (A[j]+B[j]+Carry[j]<3) begin
		if (A[j]*B[j]+A[j]*Carry[j]+B[j]*Carry[j] == 1) begin
			Sum[j] = 0;
		end
		if (A[j]+B[j]+Carry[j] == 0) begin
			Sum[j] = 0;
		end
		else begin
			Sum[j] = 1;
		end
	end
	else begin
		Sum[j] = 1;
	end
end
end

endmodule
 



endmodule