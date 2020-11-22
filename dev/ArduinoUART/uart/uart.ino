char str[6];
char receivedChar;
boolean newData = false;
boolean sent = false;

// Cipher Key
// d'18 = h'12
int key = 18;
String plaintext = "hello";

void setup() {
    Serial.begin(115200);
    Serial.println("<Arduino is ready>");
    delay(500);
    Serial.print("STARTING ENCRYPTION, key=0x");
    Serial.println(key,HEX);
    Serial1.begin(115200);
    Serial2.begin(115200);
    delay(1000);

    for(int i = 0; i < plaintext.length(); i++){
      str[i] = loopback(plaintext.charAt(i));
    }

    Serial.println("-----------\nENCRYPTION COMPLETE:");

    Serial.print(plaintext);
    Serial.print(" ---> ");
    Serial.println(str);
    
}

void loop() {
}

char loopback(char c){
    send(c);
    delay(250);
    char retChar = recvOneChar();
    showNewData();
    delay(1000);
    return retChar;
}


void send(char c) {
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
