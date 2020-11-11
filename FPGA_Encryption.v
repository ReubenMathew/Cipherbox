module FPGA_Encryption(
	input clk,
	input activate,
	output active,
	output tx,
	output done
);

//	input clk,
//	input activate,
//	input [7:0] data,
//	output active,
//	output tx,
//	output done

reg [7:0] tx_data = 8'hD1;

uart_tx uart_tx0(
	.clk(clk),
	.activate(!activate),
	.data(tx_data),
	.active(active),
	.tx(tx),
	.done(done),
	.tx_state()
);



endmodule