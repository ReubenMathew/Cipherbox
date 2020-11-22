module xor_cipher(
	input clk,
	input activate,
	input [7:0] in,
	input [7:0] key,
	output [7:0] out,
	output reg done
);

// UART_TX States
parameter IDLE = 3'd0;
parameter ENCRYPT = 3'd1;
parameter STOP = 3'd3;
parameter CLEANUP = 3'd4;

reg [2:0] state = 0;
reg [7:0] data_out = 0;


always@(posedge clk)
begin
	case (state)
		IDLE:
		begin
			done <= 0;
			data_out <= 0;
			if(activate)
			begin
				state <= ENCRYPT;
			end 
			else
			begin
				state <= IDLE;
			end
		end
		
		ENCRYPT:
		begin
			done <= 0;
			data_out <= in ^ key;
			state <= STOP;
		end
		
		STOP:
		begin
			done <= 1;
			state <= CLEANUP;
		end
		
		CLEANUP:
		begin
			done <= 0;
			state <= IDLE;
		end
		
		
	endcase
end

assign out = data_out;

endmodule