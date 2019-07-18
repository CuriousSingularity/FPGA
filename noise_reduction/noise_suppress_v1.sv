module noise_suppress_v1(
	input logic clk, d, reset,
	output logic q
	);
	
	logic [1:0] state = 0;
	parameter state_0 = 2'b00, state_1 = 2'b01, state_2 =2'b10, state_3 =2'b11;
	
	always_ff@(posedge clk)
		if(reset) 
			begin
				state <= state_0;
			end 
		else 
			begin
				state <= {(d & state[0]) | (state[1] & (~state[0])), (~state[0]) & (d ^ state[1])};
			end

	assign q = state[1];

endmodule
