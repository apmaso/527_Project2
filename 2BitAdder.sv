/////////////////////////////////////////////////
//
//   This is a 2Bit full adder module that is 
//   written in the "dataflow" style.  
//   
//  
//
//
//  Created by Alexander Maso
//
//
///////////////////////////////////////////////



module 2BitAdder(
	input logic     [1:0]		a, b,
	input logic 	        	c_in,
	output logic 	[1:0]       s,
	output logic 	            c_out);



	assign s = a ^ b ^ c_in;
	assign c_out = (a & b) | (a & c_in) | (b & c_in);

endmodule


