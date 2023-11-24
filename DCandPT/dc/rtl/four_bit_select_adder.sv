/////////////////////////////////////////////////
//
//   This is a pipelined, 4Bit carry select adder 
//   module.  This module uses three 2Bit Adders
//   to perform the addition.  The addtional adder
//   is used to calculate the carry out of the
//   upper 2 bits.  One adder for if the carry in
//   is 0 and the other for if the carry in is 1. 
//
//  Created by Alexander Maso
//
///////////////////////////////////////////////

module four_bit_select_adder (
    input logic clk, reset_n,
    input logic [3:0] A, B, 
    input logic Cin,
    output logic [3:0] output_sum,
    output logic output_Cout
);
    // Input flip-flops
    logic [3:0] A_reg, B_reg;

    // Cin does not need 
    // to be store in a flip flop
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            A_reg <= 4'b0;
            B_reg <= 4'b0;
        end else begin
            A_reg <= A;
            B_reg <= B;
        end
    end

    // Carry select adder logic
    logic [1:0] sum0, sum1, sum2;
    logic Cout0, Cout1, Cout2;
    logic [3:0] sum;
    logic Cout;

    // Lower 2 bits
    two_bit_adder lower_adder (
        .a(A_reg[1:0]),
        .b(B_reg[1:0]),
        .Cin(Cin),
        .sum(sum0),
        .Cout(Cout0)
    );

    // Upper 2 bits assuming carry-in is 0
    two_bit_adder upper_adder_0 (
        .a(A_reg[3:2]),
        .b(B_reg[3:2]),
        .Cin(1'b0),
        .sum(sum1),
        .Cout(Cout1)
    );

    // Upper 2 bits assuming carry-in is 1
    two_bit_adder upper_adder_1 (
        .a(A_reg[3:2]),
        .b(B_reg[3:2]),
        .Cin(1'b1),
        .sum(sum2),
        .Cout(Cout2)
    );

    // Carry select logic
    always_comb begin
        if (Cout0 == 1'b0) begin
            sum[3:2] = sum1;
            Cout = Cout1;
        end else begin
            sum[3:2] = sum2;
            Cout = Cout2;
        end
        sum[1:0] = sum0;
    end

    // Output flip-flops
    logic [3:0] sum_reg;
    logic Cout_reg;

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            sum_reg <= 4'b0;
            Cout_reg <= 1'b0;
        end else begin
            sum_reg <= sum;
            Cout_reg <= Cout;
        end
    end

    // Output assignment
    assign output_sum = sum_reg;
    assign output_Cout = Cout_reg;

endmodule

module two_bit_adder (
    input logic 	[1:0] 		a, b,  
    input logic 			Cin, 
    output logic 	[1:0] 		sum, 
    output logic 			Cout);

    
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
    
    assign sum= a ^ b ^ Cin;
    assign Cout = (a & b) | (a & Cin) | (b & Cin);

endmodule

