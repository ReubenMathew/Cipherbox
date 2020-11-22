module FPGA_Encryption(
	input clk,
	input rx,
	output active,
	output tx,
	output done
);

wire activate;

wire [7:0] data;
wire [7:0] data_out;

uart_rx uart_rx0(
	.clk(clk),
	.rx(rx),
	.done(activate),
	.rx_data(data),
	.rx_state()
);


xor_cipher xor_cipher0(
	.in(data),
	.key(8'hab),
	.out(data_out)
);


uart_tx uart_tx0(
	.clk(clk),
	.activate(activate),
	.data(8'hff),
	.active(active),
	.tx(tx),
	.done(done),
	.tx_state()
);



endmodule