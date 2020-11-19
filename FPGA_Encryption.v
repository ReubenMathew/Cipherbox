module FPGA_Encryption(
	input clk,
	input rx,
	output active,
	output tx,
	output done
);

wire activate;

wire [7:0] data;

uart_rx uart_rx0(
	.clk(clk),
	.rx(rx),
	.done(activate),
	.rx_data(data),
	.rx_state()
);

uart_tx uart_tx0(
	.clk(clk),
	.activate(activate),
	.data(data),
	.active(active),
	.tx(tx),
	.done(done),
	.tx_state()
);



endmodule