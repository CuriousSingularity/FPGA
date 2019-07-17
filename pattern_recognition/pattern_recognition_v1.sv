module pattern_recognition_v1(
	input wire clk, d, reset,
	output reg q
	);
	
	reg [1:0] state;
	parameter state_0 = 2'b00, state_1 = 2'b01, state_2 =2'b10;
	
	always@(posedge clk)
		if(reset) begin
			state <= state_0; q <= 0;
		end else begin
			case(state)
			state_0:
				if(d) begin
					state <= state_1; q <= 1'b0; end
				else begin
					state <= state_0; q <= 1'b0; end
			state_1:
				if(d) begin
					state <= state_2; q <= 1'b0; end
				else begin
					state <= state_0; q <= 1'b0; end
			state_2:
				if(d) begin
					state <= state_2; q <= 1'b1; end
				else begin
					state <= state_0; q <= 1'b1; end
			default: begin
					state <= state_2; q <= 1'b0; end
			endcase
		end
endmodule
