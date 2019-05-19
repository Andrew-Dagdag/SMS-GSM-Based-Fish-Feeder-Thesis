#include <Servo.h>

Servo servo;
int pos = 180;

void setup() {
  Serial.begin(9600);
  servo.attach(6);
  servo.write(pos);
  Serial.write("setup complete");
}

void loop() {
  Serial.println("opening");
  for (pos;pos>130;pos--){
    servo.write(pos);
  }
  delay(2000);
  Serial.println("closing\n");
  for (pos;pos<180;pos++){
    servo.write(pos);
  }
  delay(2000);
}

