module time_base_generator_v1 (
	input logic clk, input logic reset_n,
	output logic q
	);
	
	// ### time base generation ... ####
	logic [1:0] time_base = 0;

	always_ff@(posedge clk)
		if(reset_n == 1'b0)
			time_base <= 0;
		else
			time_base <= time_base + 1'b1;

	logic local_clk; assign local_clk = &time_base;
	// ### application process ... ###
	always_ff@(posedge local_clk)
		if(reset_n == 1'b0)
			q <= 0;
		else
			q <= ~q;
endmodule
