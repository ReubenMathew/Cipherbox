module xor_cipher(
	input [7:0] in,
	input [7:0] key,
	output [7:0] out
);

xor xor0(out, in, key);

	
endmodule