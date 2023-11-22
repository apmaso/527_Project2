module eight_bit_select_adder (
    input logic clk, reset_n,
    input logic [7:0] A, B,
    input logic Cin,
    output logic [7:0] output_sum,
    output logic output_Cout
);

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
    four_bit_select_adder lower_adder (
        .clk(clk),
        .reset_n(reset_n),
        .A(lower_A),
        .B(lower_B),
        .Cin(Cin),
        .output_sum(lower_sum),
        .output_Cout(lower_Cout)
    );

    four_bit_select_adder upper_adder_cin_0 (
        .clk(clk),
        .reset_n(reset_n),
        .A(upper_A),
        .B(upper_B),
        .Cin(1'b0), // Carry from lower adder
        .output_sum(upper_sum_0),
        .output_Cout(upper_Cout_0)
    );

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

    // Assigning output
    assign output_sum = sum_reg;
    assign output_Cout = Cout_reg;

endmodule
