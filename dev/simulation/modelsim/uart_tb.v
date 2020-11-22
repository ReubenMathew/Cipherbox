`timescale 1ns/10ps

module uart_tb();

parameter c_BIT_PERIOD = 8600;

reg r_Rx_Serial = 1;

// Takes in input byte and serializes it 
  task UART_WRITE_BYTE;
    input [7:0] i_Data;
    integer     ii;
    begin
      
      
      // Send Start Bit
      r_Rx_Serial <= 1'b0;
      #(c_BIT_PERIOD);
      #1000;
      
      
      // Send Data Byte
      for (ii=0; ii<8; ii=ii+1)
        begin
          r_Rx_Serial <= i_Data[ii];
          #(c_BIT_PERIOD);
        end
       
      // Send Stop Bit
      r_Rx_Serial <= 1'b1;
      #(c_BIT_PERIOD);
     end
  endtask // UART_WRITE_BYTE

reg clk = 0;

wire [7:0] data;

// 50000000 / 115200 =  434 Clocks/bit
parameter CLKS_PER_BIT = 434;
parameter CLK_PERIOD = 20;

// wire [2:0] state;
wire activate;
wire [2:0] rx_state;

uart_rx uart_rx0(
	.clk(clk),
	.rx(r_Rx_Serial),
	.done(activate),
	.rx_data(data),
	.rx_state(rx_state)
);

wire [7:0] data_out;
assign data_out = data ^ 8'hff;

wire tx_active, tx_done, tx;

uart_tx uart_tx0(
	.clk(clk),
	.activate(activate),
	.data(data_out),
	.active(tx_active),
	.tx(tx),
	.done(tx_done),
	.tx_state()
);



// TB clk
always #(CLK_PERIOD/2) clk <= !clk;

//Test Bench
initial 
begin
	
	@(posedge clk);
	UART_WRITE_BYTE(8'h47);
			 
	// Check that the correct command was received
	if (data == 8'h47)
	  $display("Test Passed - Correct Byte Received");
	else
	  $display("Test Failed - Incorrect Byte Received");
	  $display("Byte Received = %b",data);
	
end


endmodule