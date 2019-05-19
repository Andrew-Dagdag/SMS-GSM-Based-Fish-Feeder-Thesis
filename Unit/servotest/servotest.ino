#include <Servo.h>

Servo servo;
unsigned long mark = 0;
int pos = 180;

void setup() {
  Serial.begin(9600);
  servo.attach(6);
  servo.write(pos);
  Serial.write("setup complete");
  load();
}

void loop() {
  
}

void load() {
  mark = millis();
  for (pos;pos>130;pos--){
    servo.write(pos);
  }
  while (millis() - mark < 2500){
    Serial.println("wiggle");
    for (pos;pos<160;pos++){
      servo.write(pos);
    }
    delay(100);
    for (pos;pos>130;pos--){
      servo.write(pos);
    }
    delay(100);
  }
  for (pos;pos<180;pos++){
    servo.write(pos);
  }
}

