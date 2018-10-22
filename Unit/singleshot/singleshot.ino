void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600); // set serial baud rate
  pinMode(2, OUTPUT); // set pin for relay IN1
  pinMode(3, OUTPUT); // set pin for relay IN2
  
  digitalWrite(2,LOW);
  digitalWrite(3,HIGH);
  Serial.println("compressor on, solenoid closed");
  delay(25000); //60 psi
  
  digitalWrite(2,HIGH);
  digitalWrite(3,LOW);
  Serial.println("compressor off, solenoid open");
  delay(3000);
  
  digitalWrite(3,HIGH);
  Serial.println("compressor off, solenoid closed");
  delay(1000);
  Serial.println("fire test end");
}

void loop() {

}

