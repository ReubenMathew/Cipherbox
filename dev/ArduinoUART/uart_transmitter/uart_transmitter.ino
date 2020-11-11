void setup() {
  Serial.begin(115200, SERIAL_8N1); // Baud rate = 115200bps
}

int incomingByte = 0;

void loop() {
  if (Serial.available() > 0) {
    // read the incoming byte:
    incomingByte = Serial.read();

    // say what you got:
    Serial.print("I received: ");
    Serial.println(incomingByte, DEC);
  }
}
