transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Reuben/Github/FPGA-Encryption {C:/Users/Reuben/Github/FPGA-Encryption/FPGA_Encryption.v}
vlog -vlog01compat -work work +incdir+C:/Users/Reuben/Github/FPGA-Encryption/src {C:/Users/Reuben/Github/FPGA-Encryption/src/uart_tx.v}
vlog -vlog01compat -work work +incdir+C:/Users/Reuben/Github/FPGA-Encryption/src {C:/Users/Reuben/Github/FPGA-Encryption/src/uart_rx.v}
vlog -vlog01compat -work work +incdir+C:/Users/Reuben/Github/FPGA-Encryption/src {C:/Users/Reuben/Github/FPGA-Encryption/src/xor_cipher.v}

