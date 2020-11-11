`timescale 1ns/10ps

module uart_tx_tb();

//	input clk,
//	input activate,
//	input [7:0] data,
//	output active,
//	output tx,
//	output done

reg clk = 0;

reg r_activate = 0;
reg [7:0] tx_data = 0;
wire tx_active, tx_done;
wire tx_serial; // tx output serial wire

// 50000000 / 115200 =  434 Clocks/bit
parameter CLKS_PER_BIT = 434;
parameter CLK_PERIOD = 20;

wire [2:0] state;

uart_tx uart_tx0(
	.clk(clk),
	.activate(r_activate),
	.data(tx_data),
	.active(tx_active),
	.tx(tx_serial),
	.done(tx_done),
	.tx_state(state)
);

// TB clk
always #(CLK_PERIOD/2) clk <= !clk;

//Test Bench
initial 
begin
	@(posedge clk);
	@(posedge clk);
	r_activate <= 1;
	tx_data <= 8'hD1;
	@(posedge clk);
	r_activate <= 0; // loop?
end


endmodule