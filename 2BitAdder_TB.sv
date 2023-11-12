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

	// Instantiate our module, connect our TB signals to the inputs/outputs of the adder
    module 2bit_full_adder (
            .a(a),
            .b(b),  
            .Cin(Cin), 
            .sum(sum), 
            .Cout(Cout));

	// For Cin of 0, cycle through all 2 bit values for a & b 
	initial
	begin
		c_in = 0;
		for(int i=0; i<4; i++) begin
			for(int j=0; j<4; j++) begin
				a = i;
				b = j;
				#1;
				$display("a = %b, b= %b, c_in = %b   |->   Adder:  s = %b, c_out = %b", a, b, c_in, s, c_out);
				#1;
			end
        c_in = 1;
		for(int k=0; k<8; k++) begin
			for(int l=0; l<8; l++) begin
				a = k;
				b = l;
				#1;
				$display("a = %b, b= %b, c_in = %b   |->   Adder:  s = %b, c_out = %b", a, b, c_in, s, c_out);
				#1;
			end

		end
	end

endmodule

