
char receivedChar;
boolean newData = false;

boolean sent = false;
boolean received = false;

int key = 1;

void setup() {
    Serial.begin(115200);
    Serial.println("<Arduino is ready>");
    Serial1.begin(115200);
    Serial2.begin(115200);
    delay(1500);

//    char ciphertext[6];
//    String plaintext = "hello";
//    int idx = 0;
//    for (char i : plaintext){
//      ciphertext[idx++] = loopback(i);
//      delay(2000);
//    }
//    ciphertext[idx++] = '\0';
//    Serial.println(ciphertext);

    sendOneChar('e');

    
}

void loop() {
    recvOneChar();
    showNewData();
}

char loopback(char c){
   if (sent == false){
      Serial.print("Sending : ");
      Serial.println(c, HEX);
      Serial1.write(c);
      sent = true; //false
      received = false;
    }

    while(received == false){
      if (Serial1.available() > 0) {
        receivedChar = Serial1.read();
        newData = true;
        sent = false;
        received = true;
      }
    }

    if (newData == true) {
        Serial.print("This just in ... ");
        Serial.println(receivedChar, HEX);
        newData = false;
        received = false;
    }

    return receivedChar;
}

void sendOneChar(char c) {
  if (sent == false){
    Serial.print("Sending : ");
    Serial.println(c);
    Serial1.write(c);
    Serial2.write(key);
    sent = true; //false
  }
}

char recvOneChar() {
  if (Serial1.available() > 0) {
      receivedChar = Serial1.read();
      newData = true;
      sent = false;
  }
  return receivedChar;
}

void showNewData() {
    if (newData == true) {
        Serial.print("This just in ... ");
        Serial.println(receivedChar);
        newData = false;
    }
}
