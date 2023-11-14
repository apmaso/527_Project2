`timescale 1ns / 1ps

module four_bit_select_adder_test();

    // Testbench signals
    logic clk, reset_n;
    logic [3:0] A, B;
    logic Cin;
    logic [3:0] sum;
    logic Cout;

    // Regs to hold value of a, b 
    // and c_in from previous cycle
    logic [3:0] a_reg, b_reg;
    logic c_in_reg;

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
                    if ({Cout,sum} != (a_reg + b_reg + c_in_reg)) begin
                        $display("ERROR: A: %b, B: %b, Cin: %b | Sum: %b, Cout: %b",
                                 a_reg, b_reg, c_in_reg, sum, Cout);
                    end
                    else begin
                        $display("A: %b, B: %b, Cin: %b | Sum: %b, Cout: %b",
                                 a_reg, b_reg, c_in_reg, sum, Cout);
                    end
                end
            end
        end

        // End simulation
        $finish;
    end

    always_ff @(posedge clk or negedge reset_n) begin

        if (!reset_n) begin
            // Reset the system
            a_reg <= '0;
            b_reg <= '0;
            c_in_reg <= '0;
        end
        else begin
            // Store the values of a, b and c_in
            // from previous cycle
            a_reg <= A;
            b_reg <= B;
            c_in_reg <= Cin;
        end

    end



endmodule
