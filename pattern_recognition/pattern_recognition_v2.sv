module pattern_recognition_v2(
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
				state_0: if(d) state <= state_1; else state <= state_0; 
				state_1: if(d) state <= state_2; else state <= state_0; 
				state_2: if(d) state <= state_2; else state <= state_0; 
				default: state <= state_2;
			endcase
		end

	always@(state)
		case(state)
			state_0: q = 1'b0;
			state_1: q = 1'b0;
			state_2: q = 1'b1;
			default: q = 1'b0;
		endcase
endmodule
