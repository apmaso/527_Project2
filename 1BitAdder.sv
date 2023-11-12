/////////////////////////////////////////////////
//
//   This is a full_adder module that is 
//   written in the "dataflow" style.  This
//   means that it only uses assign statements
//   just like real wires
//
//
//  Created by Alexander Maso
//
//
///////////////////////////////////////////////



module dataflow_adder(
	input logic 		a, b, c_in,
	output logic 		s, c_out);



	assign s = a ^ b ^ c_in;
	assign c_out = (a & b) | (a & c_in) | (b & c_in);

endmodule


