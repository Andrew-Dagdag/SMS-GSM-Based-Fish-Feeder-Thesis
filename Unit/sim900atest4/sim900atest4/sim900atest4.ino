#include <Servo.h>
#include <SoftwareSerial.h>
#include <String.h>

SoftwareSerial sim900a(4, 5);
//String serverNo = "+639773518918";  // test number (andrew)
String serverNo = "+639484240042";  // test number (donn)
//String serverNo = "+639486479289"; // server number

void setup() {
  Serial.begin(9600); // set Serial baud rate
  sim900a.begin(9600);// set GSM module baud rate
  delay(3000);
  sim900a.print("AT+CMGF=1\r\n"); // check if SIM900A works
  delay(1000);
  sim900a.print("AT+CNMI=2,2,0,0,0\r\n"); // set SIM900A mode to receive
  delay(2000);
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
      String command = buffer.substring(0,4);
      buffer = buffer.substring(5);
      int amount = buffer.toInt();
      Serial.println("Amount: " + buffer);

      respond();

      while (amount > 0){
        sequence();                           // begin firing sequence
        amount -= 100;
        Serial.println(amount);
        delay(200);
      }
      
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
  Serial.println("=== FIRING SEQUENCE STARTED ===\nYEEEEET\n==== FIRING SEQUENCE ENDED ====\n");
}

void respond() {
  sim900a.println("AT + CMGS = \"+639484240042\"");
  delay(200);
  sim900a.println("this is a message");
  delay(200);
  sim900a.println((char)26);//the ASCII code of the ctrl+z is 26
  delay(200);
  sim900a.println();
  Serial.println(" > response message has been sent\n");
  delay(200);
  sim900a.print("AT+CNMI=2,2,0,0,0\r\n"); // set SIM900A mode to receive
}

