/////////////////////////////////////////////////
//
//   This is a testbench for a full adder.
//   Created for ECE171 QuestaSim/SysVerilog
//   in-class demo
//
//  Created by Alexander Maso
//
//
///////////////////////////////////////////////



module test_2bit();

	// Internal Signals 
	logic 			[1:0]		a, b, s;
	logic				        c_in, c_out;
	logic			[2:0]		TB_sum;

	// Instantiate our module, connect our TB signals to the inputs/outputs of the adder
	two_bit_adder inst(
            .a(a),
            .b(b),  
            .Cin(c_in), 
            .sum(s), 
            .Cout(c_out));

	// For Cin of 0, cycle through all 2 bit values for a & b 
	initial
	begin
		c_in = 0;
		for(int i=0; i<4; i++) begin
			for(int j=0; j<4; j++) begin
				a = i;
				b = j;
				TB_sum = i + j;
				#1;
				if({c_out,s}==TB_sum) begin
					$display("PASS |   a = %b, b= %b, c_in = %b  |->  Adder:  s = %b, c_out = %b", a, b, c_in, s, c_out);
				end
				else begin
					$display("FAIL |   a = %b, b= %b, c_in = %b  |->  Adder:  s = %b, c_out = %b", a, b, c_in, s, c_out);
				end
				#1;
			end
		end
	        c_in = 1;
		for(int k=0; k<4; k++) begin
			for(int l=0; l<4; l++) begin
				a = k;
				b = l;
				TB_sum = k + l + 1;
				#1;
				if({c_out,s}==TB_sum) begin
					$display("PASS |   a = %b, b= %b, c_in = %b  |->  Adder:  s = %b, c_out = %b", a, b, c_in, s, c_out);
				end
				else begin
					$display("FAIL |   a = %b, b= %b, c_in = %b  |->  Adder:  s = %b, c_out = %b", a, b, c_in, s, c_out);
				end
				#1;
			end

		end
	end

endmodule

