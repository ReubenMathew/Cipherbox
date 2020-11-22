module uart_tx(
	input clk,
	input activate,
	input [7:0] data,
	output reg active,
	output reg tx,
	output reg done,
	output [2:0] tx_state
);

// UART_TX States
parameter IDLE = 3'd0;
parameter START = 3'd1;
parameter TRANSMIT = 3'd2;
parameter STOP = 3'd3;
parameter CLEANUP = 3'd4;

reg[2:0] state; 
reg[2:0] bit_index;

assign tx_state = state;

reg[7:0] tx_data = 0;

// 50000000 / 115200 =  434 Clocks/bit
parameter CLKS_PER_BIT = 434;
reg[11:0] clk_counter = 0;

always @(posedge clk)
begin
	// State Machine
	case (state)
		IDLE:
		begin
			tx <= 1;
			done <= 0;
			bit_index <= 0;
			clk_counter <= 0;
			
			if(activate == 1)
			begin
				active <= 1;
				tx_data <= data;
				state <= START;
			end
			else
				state <= IDLE;
		end
		
		START:
		begin
			
			tx <= 0;
			
			if (clk_counter < CLKS_PER_BIT-1)
			begin
				clk_counter <= clk_counter + 1;
				state <= START;
			end
			else
			begin
				clk_counter <= 0;
				state <= TRANSMIT;
			end
			
		end
		
		TRANSMIT:
		begin
			tx <= tx_data[bit_index];
			state <= TRANSMIT;
			
			if (clk_counter < CLKS_PER_BIT-1)
			begin
				clk_counter <= clk_counter + 1;
				state <= TRANSMIT;
			end
			else
			begin
				clk_counter <= 0;
				if(bit_index < 7)
				begin
					bit_index <= bit_index + 1;
					state <= TRANSMIT;
				end
				else
				begin
					bit_index <= 0;
					state <= STOP;
				end	
			end
					

			
		end
		
		STOP:
		begin
			tx <= 1;
			
			if (clk_counter < CLKS_PER_BIT-1)
			begin
				clk_counter <= clk_counter + 1;
				state <= STOP;
			end
			else
			begin
				clk_counter <= 0;
				done <= 1;
				state <= CLEANUP;
				active <= 0;
			end
		end
		
		CLEANUP:
		begin
			done <= 1;
			state <= IDLE;
			tx_data <= 0;
		end
		
		default: 
			state <= IDLE;
		
	endcase

end


endmodule
