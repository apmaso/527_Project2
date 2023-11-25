/////////////////////////////////////////////////////////////
// CLA_AdderTB.sv - 
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

module top();

// internal variables
logic	[15:0]			A_dat, B_dat; 
logic				C_In_dat;
logic	[15:0]			Sum_dat;
logic				C_Out_dat;
integer				i, j;

// instantiation 
CLA_Adder_dat instA(.A(A_dat), .B(B_dat), .C_In(C_In_dat), .Sum(Sum_dat), .C_Out(C_Out_dat));


initial begin
$display("Testing dataflow model with all  combinations for 16 bit inputs");


for (j = 0; j < 2^16; j++)
	begin
	for (i = 0; i < 2^16; i = i + 1)
		begin
		A_dat=i;
		B_dat=j;
		#10
		if ((A_dat + B_dat)!= {C_Out_dat, Sum_dat})
			begin 
			#10
			$display("Error! A = %4h and Y = %4h. These input should return %5h but instead returns %5h", A_dat, B_dat, (A_dat+B_dat), {C_Out_dat, Sum_dat});
			end
		end
	end
end
endmodule