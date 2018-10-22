void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
}

void loop() {
  digitalWrite(2,LOW);
  digitalWrite(3,HIGH);
  Serial.println("compressor on, solenoid closed");
  delay(10000);
  
  digitalWrite(2,HIGH);
  digitalWrite(3,LOW);
  Serial.println("compressor off, solenoid open");
  delay(2000);
  
  digitalWrite(3,HIGH);
  Serial.println("compressor off, solenoid closed");
  delay(10000);
  Serial.println("downtime");
}
