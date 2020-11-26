# Cipherbox
**Reuben Ninan**

### Description
This project was built by myself and was an amazing learning experience to sink my teeth into digital logic design.

My project is utilizing an FPGA as a hardware accelerated encryption device. FPGAs are a great way to implement encryption algorithms due to the high performance of hardware implementations while maintaining the option for updates in case of a security compromise. 

My project is a verilog implementation of the XOR algorithm which can encrypt/decrypt bytes with a key byte. A stream of bytes can be input with a key stream and produce a manipulated stream of bytes that has either been encrypted/decrypted.

The XOR cipher is a simple yet effective algorithm, that is used to encrypt/decrypt incoming bytes of data. By leveraging the UART transmission protocol I am able to send bytes of data over a single line at fast speeds.

An Arduino can both read and write to an FGPA using the `Serial` library:
```c
void setup(){
	Serial.begin(115200); // Serial Baud Rate
	Serial.read(); // UART Serial read from RX port
	Serial.write(c) // UART Serial write to TX port
}
```

### Encryption Module Implementation:
- 1 pin serial input, for key
- 1 pin serial input, for (encrypted or plain) bytes
- 1 pin serial output, for (encrypted or plain) bytes

The serial inputs utilize an `uart_rx` module to convert the serial data into a register to be used for computation. The `uart_tx` transmitter module is used to convert the parallel encrypted data register into a serial line that can be read by the Arduino. 

Both uart modules are state machines that transmit/receive bits according to the uart protocol which is one start bit, 8 data bits and one stop bit at a specific baud rate (bits/second). Once the Arduino and FPGA are communicating at the same rate information is easily exchanged between the two.

The flow for using this encryption device is as follows:
1. Arduino sends plaintext byte and key byte to FPGA
2. FPGA encrypts (XOR) the plaintext and key bytes together
3. The resultant byte is transmitted back to the Arduino

### References
- https://www.nandland.com/vhdl/modules/module-uart-serial-port-rs232.html
- https://github.com/kithminr1995/verilog_fpga_uart
