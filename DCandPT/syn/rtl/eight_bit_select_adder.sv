/////////////////////////////////////////////////
//
//   This is a pipelined, 8Bit carry select adder 
//   module.  This module uses three pipelined 
//   4Bit Adders to perform the addition.  The 
//   addtional adder is used to calculate the 
//   carry out of the upper 4 bits.  One adder 
//   for if the carry in is 0 and the other 
//   for if the carry in is 1. 
//
//   Created by Alexander Maso
//
///////////////////////////////////////////////


module eight_bit_select_adder (
    input logic clk, reset_n,
    input logic [7:0] A, B,
    input logic Cin,
    output logic [7:0] output_sum,
    output logic output_Cout
);

    // Uncomment to tie reset high and disable it
    // reset_n = 1'b1;

    // Input flip-flops
    logic [7:0] A_reg, B_reg;

    // Cin does not need to 
    // be stored in a flip flop
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            A_reg <= 8'b0;
            B_reg <= 8'b0;
        end else begin
            A_reg <= A;
            B_reg <= B;
        end
    end

    // Splitting the 8-bit inputs into two 4-bit parts
    logic [3:0] lower_A, lower_B, upper_A, upper_B;
    assign lower_A = A[3:0];
    assign lower_B = B[3:0];
    assign upper_A = A[7:4];
    assign upper_B = B[7:4];
    
    // Carry Select Logic
    logic [3:0] lower_sum, upper_sum, upper_sum_0, upper_sum_1;
    logic lower_Cout, upper_Cout, upper_Cout_0, upper_Cout_1;

    // Instantiate three 4-bit carry-select adders
    // Adder for the lower 4 bits
    four_bit_select_adder lower_adder (
        .clk(clk),
        .reset_n(reset_n),
        .A(lower_A),
        .B(lower_B),
        .Cin(Cin),
        .output_sum(lower_sum),
        .output_Cout(lower_Cout)
    );

    // Adder for upper for bits when lower_Cout = 0
    four_bit_select_adder upper_adder_cin_0 (
        .clk(clk),
        .reset_n(reset_n),
        .A(upper_A),
        .B(upper_B),
        .Cin(1'b0), // Carry from lower adder
        .output_sum(upper_sum_0),
        .output_Cout(upper_Cout_0)
    );

    // Adder for upper for bits when lower_Cout = 1
    four_bit_select_adder upper_adder_cin_1 (
        .clk(clk),
        .reset_n(reset_n),
        .A(upper_A),
        .B(upper_B),
        .Cin(1'b1), // Carry from lower adder
        .output_sum(upper_sum_1),
        .output_Cout(upper_Cout_1)
    );

    // Carry select logic
    always_comb begin
        if (lower_Cout == 1'b0) begin
            upper_sum = upper_sum_0;
            upper_Cout = upper_Cout_0;
        end 
        else begin
            upper_sum = upper_sum_1;
            upper_Cout = upper_Cout_1;
        end
    end

    // Output flip-flops
    logic [7:0] sum_reg;
    logic Cout_reg;

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            sum_reg <= 8'b0;
            Cout_reg <= 1'b0;
        end else begin
            sum_reg[3:0] <= lower_sum;
            sum_reg[7:4] <= upper_sum;
            Cout_reg <= upper_Cout;
        end
    end

    // Assign output
    assign output_sum = sum_reg;
    assign output_Cout = Cout_reg;

endmodule


module four_bit_select_adder (
    input logic clk, reset_n,
    input logic [3:0] A, B, 
    input logic Cin,
    output logic [3:0] output_sum,
    output logic output_Cout
);

    // Uncomment to tie reset high and disable it
    // reset_n = 1'b1;

    // Input flip-flops
    logic [3:0] A_reg, B_reg;
   

    // Cin does not need to 
    // be stored in a flip flop
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

    // Uncomment to tie reset high and disable it
    // reset_n = 1'b1;
    
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

    // Uncomment to tie reset high and disable it
    // reset_n = 1'b1;
    
    assign sum= a ^ b ^ Cin;
    assign Cout = (a & b) | (a & Cin) | (b & Cin);

endmodule

