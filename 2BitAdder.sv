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



module two_bit_full_adder (
    input logic 	[1:0] 		a, b,  
    input logic 				Cin, 
    output logic 	[1:0] 		sum, 
    output logic 				Cout);

    // Internal carry signal
    logic carry;

    // First 1bit adder
    full_adder fa0 (
        .a(a[0]),
        .b(b[0]),
        .Cin(Cin),
        .sum(sum[0]),
        .Cout(carry)
    );

    // Second 1bit adder
    full_adder fa1 (
        .a(a[1]),
        .b(b[1]),
        .Cin(carry),
        .sum(sum[1]),
        .Cout(Cout)
    );

endmodule

// Full adder module for a single bit
module full_adder (
    input logic 		a, b, Cin,
    output logic 		sum, Cout);

    assign {Cout, sum} = a + b + Cin;

endmodule

