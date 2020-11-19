module uart_rx(
	input clk,
	input rx,
	output done,
	output [7:0] rx_data,
	output [2:0] rx_state
);

// UART_RX States
parameter IDLE = 3'd0;
parameter START = 3'd1;
parameter TRANSMIT = 3'd2;
parameter STOP = 3'd3;
parameter CLEANUP = 3'd4;

reg[2:0] state = 0; 
reg[2:0] bit_index;

reg r_done = 0;

assign done = r_done;

assign rx_state = state;

// 9600 baud = 5208
// 50000000 / 115200 =  434 Clocks/bit
parameter CLKS_PER_BIT = 434;
reg[11:0] clk_counter = 0;

reg rx_reg = 1;
reg rx_r = 1;
reg [7:0] rx_buffer = 0;

always@(posedge clk)
begin

	rx_r <= rx;
	rx_reg <= rx_r;
	
	case(state)
		IDLE:
		begin
			r_done <= 0;
			clk_counter <= 0;
			bit_index <= 0;
			// start bit
			if (rx_reg == 0)
				state <= START;
			else
				state <= IDLE;
		end
		
		START:
		begin
			if(clk_counter == (CLKS_PER_BIT-1)/2)
			begin
				if(rx_reg == 0)
				begin
					clk_counter <= 0;
					state <= TRANSMIT;
				end
				else
					state <= IDLE;
			end
			else
			begin
				clk_counter <= clk_counter + 1;
				state <= START;
			end
		end
		
		TRANSMIT:
		begin
			if(clk_counter < CLKS_PER_BIT-1)
			begin
				clk_counter <= clk_counter + 1;
				state <= TRANSMIT;
			end
			else
			begin
				
				clk_counter <= 0;
				rx_buffer[bit_index] <= rx_reg;
				
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
			if(clk_counter < CLKS_PER_BIT-1)
			begin
				clk_counter <= clk_counter + 1;
				state <= STOP;
			end
			else
			begin
				r_done <= 1;
				clk_counter <= 0;
				state <= CLEANUP;
			end
		end
	
		CLEANUP:
		begin
			state <= IDLE;
			r_done <= 0;
		end
	
	endcase

end

assign rx_data = rx_buffer;

endmodule
