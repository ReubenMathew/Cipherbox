module UART_Test(
	
);



uart #(
.baud_rate(9600), // default is 9600
.sys_clk_freq(12000000) // default is 100000000
)
uart0(
.clk(CLK12M), // The master clock for this module
.rst(~nrst), // Synchronous reset
.rx(UART_RXD), // Incoming serial line
.tx(UART_TXD), // Outgoing serial line
.transmit(), // Signal to transmit
.tx_byte(), // Byte to transmit
.received(isrx), // Indicated that a byte has been received
.rx_byte(rx_byte), // Byte received
.is_receiving(), // Low when receive line is idle
.is_transmitting(),// Low when transmit line is idle
.recv_error() // Indicates error in receiving packet.
);

endmodule
