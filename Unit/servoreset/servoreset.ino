#include <Servo.h>

Servo servo;

void setup() {
  servo.attach(6);
  servo.write(180);
}

void loop() {
}

