module rc4(
	output[5:0] seg_sel,
	output[7:0] seg_data,
	input clk,
	input	rst
);

reg[15:0] plain = 16'hB309;
reg[15:0] key_raw = 16'h1234;
reg output_ready;
// plain -> 16'hA13D

reg[15:0] ciphertext;

always@(posedge clk)
begin
	ciphertext = plain ^ key_raw;
end



wire[6:0] seg_data_0;
seg_decoder seg_decoder_m0(
    .bin_data  (ciphertext[15:12]),
    .seg_data  (seg_data_0)
);
wire[6:0] seg_data_1;
seg_decoder seg_decoder_m1(
    .bin_data  (ciphertext[11:8]),
    .seg_data  (seg_data_1)
);
wire[6:0] seg_data_2;
seg_decoder seg_decoder_m2(
    .bin_data  (ciphertext[7:4]),
    .seg_data  (seg_data_2)
);
wire[6:0] seg_data_3;
seg_decoder seg_decoder_m3(
    .bin_data  (ciphertext[3:0]),
    .seg_data  (seg_data_3)
);

wire[6:0] seg_data_4;
seg_decoder seg_decoder_m4(
    .bin_data  (4'b1111),
    .seg_data  (seg_data_4)
);

wire[6:0] seg_data_5;
seg_decoder seg_decoder_m5(
    .bin_data  (4'b1111),
    .seg_data  (seg_data_5)
);




display display_1(
	 .clk			 (clk),
    .seg_sel    (seg_sel),
    .seg_data   (seg_data),
    .seg_data_0 ({1'b0,seg_data_0}),      //The  decimal point at the highest bit,and low level effecitve
    .seg_data_1 ({1'b0,seg_data_1}), 
    .seg_data_2 ({1'b0,seg_data_2}),
    .seg_data_3 ({1'b0,seg_data_3}),
    .seg_data_4 ({1'b0,seg_data_4}),
    .seg_data_5 ({1'b0,seg_data_5})
);

endmodule
