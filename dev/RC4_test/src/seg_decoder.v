module seg_decoder(
	input[3:0]      bin_data,     // bin data input
	output reg[6:0] seg_data      // seven segments LED output
);

wire A,B,C,D;
assign A = bin_data[3];
assign B = bin_data[2];
assign C = bin_data[1];
assign D = bin_data[0];

always@(*)
begin

	seg_data[6] = (~A&~B&~C) | ~A&B&C&D | A&B&~C&~D;
	seg_data[5] = (~A&~B&D) | (~A&~B&C) | (~A&C&D) | (A&B&~C&D);
	seg_data[4] = (~A&D) | (~A&B&~C) | (~B&~C&D);
	seg_data[3] = (~A&~B&~C&D) | (~A&B&~C&~D) | (B&C&D) | (A&~B&C&~D);
	seg_data[2] = (~A&~B&C&~D) | (A&B&~D) | (A&B&C);
	seg_data[1] = (~A&B&~C&D) | (B&C&~D) | (A&B&~D) | (A&C&D);
	seg_data[0] = (~A&~B&~C&D) | (~A&B&~C&~D) | (A&B&~C&D) | (A&~B&C&D);

end

endmodule
