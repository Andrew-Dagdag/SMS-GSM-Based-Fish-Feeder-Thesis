#include <Servo.h>
#include <SoftwareSerial.h>
#include <String.h>

SoftwareSerial sim900a(4, 5);
Servo loadDoor;
//String serverNo = "+639301316858";  // test number
String serverNo = "+639486479289"; // server number
unsigned long timer = 0;
bool loaderOn = false;
bool compOn = false;

void setup() {
  Serial.begin(9600); // set Serial baud rate
  pinMode(2, OUTPUT); // set pin for relay IN1
  pinMode(3, OUTPUT); // set pin for relay IN2
  digitalWrite(2,HIGH);
  digitalWrite(3,HIGH);
  loadDoor.attach(6); // attach loader servo to pin 6
  loadDoor.write(180);
  Serial.println("  pins set\n  loader door set to closed\n  waiting for SIM900A to connect");
  sim900a.begin(9600);// set GSM module baud rate
  delay(3000);
  sim900a.print("AT+CMGF=1\r\n"); // check if SIM900A works
  delay(1000);
  sim900a.print("AT+CNMI=2,2,0,0,0\r\n"); // set SIM900A mode to receive
  delay(1000);
  Serial.println("  setup complete\n==================");
  delay(500);
}

void loop() {
  String buffer = readMsg();  // store received data here
  if (buffer.startsWith("\r\n+CMT: "))
  {
    String from = buffer.substring(9, 22);  // store sender cel no
    if (from.equalsIgnoreCase(serverNo)){   // only server cel no is authorized to command
      //Serial.println(buffer);
      Serial.println("From:" + from);
  
      buffer.remove(0,51);                   // isolate sms content
      buffer.remove(buffer.length() - 2, 2); // remove \r\n at the end
  
      Serial.println("SMS: '" + buffer + "'");
      sequence();                             // begin firing sequence
      sim900a.print("AT+CMGD=1,4");           // clear inbox so it never gets full
    }else{
      Serial.println("Unauthorized number. Message ignored.\n");
    }
  }
  delay(100);
}

String readMsg() {  // read and store data when received
  String buffer;    // data stored here as string
  //Serial.println("reading");
  
  while (sim900a.available()) { // store data char by char
    //Serial.println("yeeting");
    char c = sim900a.read();    // read char
    buffer.concat(c);           // concatenate char to string
    delay(10);                  // 10ms delay to prevent char skipping
  }
  if (buffer.equalsIgnoreCase("")){
    //Serial.println("this bitch empty");
    // do nothing
  }else{
    Serial.println(buffer);
  }
  return buffer;
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

  loadDoor.write(130);
  digitalWrite(2,LOW);  // turn on compressor for 25s; 60psi
  while (millis() - timer < 2500){
    //Serial.print("wiggle ");
    loadDoor.write(130);
    delay(50);
    loadDoor.write(145);
    delay(50);
  }
  loadDoor.write(180);
  
  while (millis() - timer < 25000) {
    if ((millis() - timer)%1000 == 0){
      Serial.println(millis() - timer);
      //Serial.println("\n");
    }
  }
  digitalWrite(2,HIGH); // turn off compressor at 25s
  compOn = false;       // set compressor flag to false
  Serial.println(" > air tank ready. compressor off");
}

