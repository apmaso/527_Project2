`timescale 1ns / 1ps

module four_bit_select_adder_test();

    // Testbench signals
    logic clk, reset_n;
    logic [3:0] A, B;
    logic Cin;
    logic [3:0] sum;
    logic Cout;

    // Registers for use in 2-stage shift register
    // Shift reg needed to store the values of 
    // a, b and c_in from last cycle
    logic [3:0] a_reg, b_reg;
    logic c_in_reg;
    logic [3:0] a_last, b_last;
    logic c_in_last;

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
        
        // Reset the system
        #5 reset_n = 0;
        #20 reset_n = 1;

        

        // Fully exhaustive test of inputs 
        for (int c = 0; c < 2; c++) begin
            for (int i = 0; i < 16; i++) begin
                for (int j=0; j < 16; j++) begin
                    A = i;
                    B = j;
                    Cin = c;
                    #10;
                    // Compare against value saved in last cycle since adder is pipelined
                    if ({Cout,sum} != (a_last + b_last + c_in_reg)) begin
                        $display("ERROR: A: %b, B: %b, Cin: %b | Sum: %b, Cout: %b",
                                 a_last, b_last, c_in_reg, sum, Cout);
                    end
                    else begin
                        $display("PASS:  A: %b, B: %b, Cin: %b | Sum: %b, Cout: %b",
                                 a_last, b_last, c_in_reg, sum, Cout);
                    end
                    #10;
                end
            end
        end

        // Fully randomized stimulus to cover additional state transitions
        // Primary area of concern: state transitions as Cin changes
        $display("####################################################");
        $display("Exhaustive Test Complete....");
        $display("####################################################");
        $display("Switching to randomized stimulus....");
        $display("####################################################");
        for (int count = 0; count < (512*8); count++) begin
            A = $random;
            B = $random;
            Cin = $random;
                #10;
                // Compare against value saved in last cycle since adder is pipelined
                if ({Cout,sum} != (a_last + b_last + c_in_reg)) begin
                    $display("ERROR: A: %b, B: %b, Cin: %b | Sum: %b, Cout: %b", a_last, b_last, c_in_reg, sum, Cout);
                end
                else begin
                    $display("PASS:  A: %b, B: %b, Cin: %b | Sum: %b, Cout: %b", a_last, b_last, c_in_reg, sum, Cout);
                end
                #10;
        end


        // End simulation
        $finish;
    end
    
    // Two-stage shift register to hold the output from last cycle
    always_ff @(posedge clk or negedge reset_n) begin

        if (!reset_n) begin
            // Reset the system
            a_reg <= '0;
            b_reg <= '0;
            c_in_reg <= '0;
            a_last <= '0;
            b_last <= '0;
            c_in_last <= '0;
        end
        else begin
            // Store the values of a, b and c_in
            // from previous cycle
            a_reg <= A;
            b_reg <= B;
            c_in_reg <= Cin;
    	    a_last <= a_reg;
	        b_last <= b_reg;
	        c_in_last <= c_in_reg;
        end

    end



endmodule
