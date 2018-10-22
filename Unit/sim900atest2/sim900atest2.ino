#include <SoftwareSerial.h>
#include <String.h>

SoftwareSerial gsm(4,5);

void setup() {
  Serial.begin(9600);
  Serial.println("  Serial ready");
  gsm.begin(9600);
  Serial.println("  SIM900A ready");
  delay(1000);
  Serial.println("=================");
}

void loop() {
  String buffer = readgsm();
  Serial.println(buffer);
  if (buffer.startsWith("\r\n+CMT: "))
  {
    Serial.println("vvv SMS vvv");

    buffer.remove(0,51);
    int len = buffer.length();
    buffer.remove(len - 2, 2);

    Serial.println(buffer);

    Serial.println("^^^ END ^^^");
  }
  delay(100);
}

String readgsm() {
  String buffer;
  
  while (gsm.available()) {
    Serial.println("GSM available");
    char c = gsm.read();
    buffer.concat(c);
    delay(10);
  }
  
  return buffer;
}

