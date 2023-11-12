`timescale 1ns / 1ps

module four_bit_select_adder_test();

    // Testbench signals
    logic clk, reset_n;
    logic [3:0] A, B;
    logic Cin;
    logic [3:0] sum;
    logic Cout;

    // Instantiate the 4-bit pipelined carry select adder
    four_bit_select_adder dut (
        .clk(clk),
        .reset_n(reset_n),
        .A(A),
        .B(B),
        .Cin(Cin),
        .output_sum(sum),
        .output_Cout(Cout)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = !clk;  // Generate a clock with 20ns period
    end

    // Test stimulus
    initial begin
        // Initialize
        reset_n = 1;
        A = 0;
        B = 0;
        Cin = 0;

        // reset_n the system
        #5 reset_n = 0;
        #20 reset_n = 1;

        // Apply test vectors
        #20 {A, B, Cin} = 7'b0000_000;
        #20 {A, B, Cin} = 7'b0101_001;
        #20 {A, B, Cin} = 7'b1010_110;
        #20 {A, B, Cin} = 7'b1111_111;
        #20;

        // End simulation
        $finish;
    end

    // Monitor and check results
    initial begin
        $monitor($time, " ns -- A: %b, B: %b, Cin: %b | Sum: %b, Cout: %b",
                 A, B, Cin, sum, Cout);
    end

endmodule
