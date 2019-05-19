#include <Servo.h>
#include <SoftwareSerial.h>
#include <String.h>

SoftwareSerial sim900a(4, 5);
Servo loadDoor;
String serverNo = "+639484240042";  // test number
//String serverNo = "+639486479289"; // server number
unsigned long timer = 0;
bool loaderOn = false;
bool compOn = false;
int pos = 180;

void setup() {
  Serial.begin(9600); // set Serial baud rate
  pinMode(2, OUTPUT); // set pin for relay IN1
  pinMode(3, OUTPUT); // set pin for relay IN2
  digitalWrite(2,HIGH);
  digitalWrite(3,HIGH);
  loadDoor.attach(6); // attach loader servo to pin 6
  loadDoor.write(pos);
  Serial.println("  pins set\n  loader door set to closed");
  Serial.println("  setup complete\n==================");
  delay(500);
  sequence();
}

void loop() {

}

void sequence() {
  Serial.println("=== FIRING SEQUENCE STARTED ===");
  delay(1000);
  timer = millis();
  prep();                             // load feeds and fill air tank
  digitalWrite(3,LOW);                // solenoid valve opens to fire
  Serial.println(" > solenoid open");
  delay(3000);                        // wait 3s to make sure all air is expelled
  digitalWrite(3,HIGH);               // solenoid valve closes again
  Serial.println(" > solenoid closed\n==== FIRING SEQUENCE ENDED ====\n");
}

void prep() {
  Serial.println(" > reloading feeds & filling air tank");
  loaderOn = true;        // set loader flag to true
  compOn = true;          // set compressor flag to true

  /*for (pos;pos>130;pos--){
    loadDoor.write(pos);
  }*/
  digitalWrite(2,LOW);  // turn on compressor for 25s; 60psi
  /*while (millis() - timer < 2500){
    //Serial.print("wiggle ");
    for (pos;pos<160;pos++){
      loadDoor.write(pos);
    }
    delay(100);
    for (pos;pos>130;pos--){
      loadDoor.write(pos);
    }
    delay(100);
  }
  for (pos;pos<180;pos++){
    loadDoor.write(pos);
  }*/
  
  while (millis() - timer < 25000) { // change 2000 back to 25000
    if ((millis() - timer)%1000 == 0){
      Serial.println(millis() - timer);
      //Serial.println("\n");
    }
  }
  digitalWrite(2,HIGH); // turn off compressor at 25s
  compOn = false;       // set compressor flag to false
  Serial.println(" > air tank ready. compressor off");
}
