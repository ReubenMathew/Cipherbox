//int incomingByte = 0;
//
//void loop() {
//
//  int sentByte = 72;
//  Serial.print("I sent: ");
//  Serial.println(sentByte, HEX);
//  Serial.write(sentByte);
//  
//  if (Serial.available() > 0) {
//    // read the incoming byte:
//    incomingByte = Serial.read();
//
//    // say what you got:
//    Serial.print("I received: ");
//    Serial.println(incomingByte, HEX);
//  }  
//
//  delay(1000);
//  
//}

char receivedChar;
int sentByte = 71;
boolean newData = false;
boolean sent = false;

void setup() {
    Serial.begin(115200);
    Serial.println("<Arduino is ready>");
    sendOneChar();
    delay(100);
    recvOneChar();
    showNewData();

}

void loop() {

}

void sendOneChar() {
  if (sent == false){
    Serial.print("Sending : ");
    Serial.println(sentByte,HEX);
    Serial.write(sentByte);
    sent = true;
  }
}

void recvOneChar() {
    if (Serial.available() > 0) {
        receivedChar = Serial.read();
        newData = true;
    }
}

void showNewData() {
    if (newData == true) {
        Serial.print("This just in ... ");
        Serial.println(receivedChar,HEX);
        newData = false;
    }
}
