/////////////////////////////////////////////////////////////
// CLA_Adder_dat.sv - 
//
// Author:		    		Alexander Maso
// Created:			
// Last Modified:		   	
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

module CLA_Adder_dat(
	
	input logic	[15:0]			A, B, 
	input logic				C_In,
	output logic	[15:0]			Sum,
	output logic				C_Out
);

// internal variables
logic 		[16:0]				Carry;


assign Carry[0] = C_In;
assign Carry[1] = (A[0]&B[0])|(Carry[0]&(A[0]|B[0]));
assign Carry[2] = (A[1]&B[1])|(Carry[1]&(A[1]|B[1]));
assign Carry[3] = (A[2]&B[2])|(Carry[2]&(A[2]|B[2]));
assign Carry[4] = (A[3]&B[3])|(Carry[3]&(A[3]|B[3]));
assign Carry[5] = (A[4]&B[4])|(Carry[4]&(A[4]|B[4]));
assign Carry[6] = (A[5]&B[5])|(Carry[5]&(A[5]|B[5]));
assign Carry[7] = (A[6]&B[6])|(Carry[6]&(A[6]|B[6]));
assign Carry[8] = (A[7]&B[7])|(Carry[7]&(A[7]|B[7]));
assign Carry[9] = (A[8]&B[8])|(Carry[8]&(A[8]|B[8]));
assign Carry[10] = (A[9]&B[9])|(Carry[9]&(A[9]|B[9]));
assign Carry[11] = (A[10]&B[10])|(Carry[10]&(A[10]|B[10]));
assign Carry[12] = (A[11]&B[11])|(Carry[11]&(A[11]|B[11]));
assign Carry[13] = (A[12]&B[12])|(Carry[12]&(A[12]|B[12]));
assign Carry[14] = (A[13]&B[13])|(Carry[13]&(A[13]|B[13]));
assign Carry[15] = (A[14]&B[14])|(Carry[14]&(A[14]|B[14]));
assign Carry[16] = (A[15]&B[15])|(Carry[15]&(A[15]|B[15]));

assign C_Out = Carry[16];

assign Sum[0] = (A[0]^B[0])^Carry[0];
assign Sum[1] = (A[1]^B[1])^Carry[1];
assign Sum[2] = (A[2]^B[2])^Carry[2];
assign Sum[3] = (A[3]^B[3])^Carry[3];
assign Sum[4] = (A[4]^B[4])^Carry[4];
assign Sum[5] = (A[5]^B[5])^Carry[5];
assign Sum[6] = (A[6]^B[6])^Carry[6];
assign Sum[7] = (A[7]^B[7])^Carry[7];
assign Sum[8] = (A[8]^B[8])^Carry[8];
assign Sum[9] = (A[9]^B[9])^Carry[9];
assign Sum[10] = (A[10]^B[10])^Carry[10];
assign Sum[11] = (A[11]^B[11])^Carry[11];
assign Sum[12] = (A[12]^B[12])^Carry[12];
assign Sum[13] = (A[13]^B[13])^Carry[13];
assign Sum[14] = (A[14]^B[14])^Carry[14];
assign Sum[15] = (A[15]^B[15])^Carry[15];

endmodule