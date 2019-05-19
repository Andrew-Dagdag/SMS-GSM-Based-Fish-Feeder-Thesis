#include <Servo.h>

Servo servo;
unsigned long mark = 0;

void setup() {
  Serial.begin(9600);
  servo.attach(6);
  Serial.write("setup complete");
}

void loop() {
  servo.write(180);
  Serial.println("opening door");
  delay(2500);
  servo.write(0);
  Serial.println("closing door");
  delay(2500);
  servo.write(90);
  Serial.println("waiting\n");
  delay(5000);
}

