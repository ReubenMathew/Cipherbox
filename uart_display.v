
module uart_display(
	input 		clk,
	input 		rst_n,
	input			rx,
	input			rx_key,
	output		tx,
	output		done,
	output 		active,
	output[5:0] seg_sel,
	output[7:0]	seg_data
);


wire activate;
wire [7:0] data, data_out;
wire [7:0] key;

uart_rx uart_rx0(
	.clk(clk),
	.rx(rx),
	.done(activate),
	.rx_data(data),
	.rx_state()
);

uart_rx uart_rx1(
	.clk(clk),
	.rx(rx_key),
	.done(),
	.rx_data(key),
	.rx_state()
);

uart_tx uart_tx0(
	.clk(clk),
	.activate(activate),
	.data(data^key),
	.active(active),
	.tx(tx),
	.done(done),
	.tx_state()
);


wire[6:0] seg_data_0;
seg_decoder seg_decoder_m0(
    .bin_data  (data[7:4]),
    .seg_data  (seg_data_0)
);

wire[6:0] seg_data_1;
seg_decoder seg_decoder_m1(
    .bin_data  (data[3:0]),
    .seg_data  (seg_data_1)
);

display seg_scan_m0(
    .clk        (clk),
    .rst_n      (rst_n),
    .seg_sel    (seg_sel),
    .seg_data   (seg_data),
    .seg_data_0 ({1'b1,seg_data_0}),
    .seg_data_1 ({1'b1,seg_data_1})  
);

endmodule
