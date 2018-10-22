#include <Servo.h>

Servo servo;
unsigned long mark = 0;

void setup() {
  Serial.begin(9600);
  servo.attach(6);
  servo.write(180);
  Serial.write("setup complete");
}

void loop() {
  mark = millis();
  servo.write(130);
  while (millis() - mark < 2500){
    Serial.println("wiggle");
    servo.write(130);
    delay(50);
    servo.write(145);
    delay(50);
  }
  servo.write(180);
  delay(5000);
}

