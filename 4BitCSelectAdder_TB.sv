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

        // Fully exhaustive test of inputs 
        for (int c = 0; c < 2; c++) begin
            for (int i = 0; i < 16; i++) begin
                for (int j=0; j < 16; j++) begin
                    A = i;
                    B = j;
                    Cin = c;
                    #20;
                    if (sum !== (i + j + c)) begin
                        $display("ERROR: A: %b, B: %b, Cin: %b | Sum: %b, Cout: %b",
                                 A, B, Cin, sum, Cout);
                    end
                    else begin
                        $display("A: %b, B: %b, Cin: %b | Sum: %b, Cout: %b",
                                 A, B, Cin, sum, Cout);
                    end
                end
            end
        end

        // End simulation
        $finish;
    end


endmodule
