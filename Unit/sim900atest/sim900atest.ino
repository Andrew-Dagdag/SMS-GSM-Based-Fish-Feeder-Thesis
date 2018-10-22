#include <SoftwareSerial.h>
#include <String.h>
 
SoftwareSerial mySerial(4, 5);
 
void setup()
{
  mySerial.begin(9600);  // the GPRS baud rate   
  Serial.begin(9600);    // the GPRS baud rate
  Serial.println("  setup complete\n==================");
  delay(500);
}
 
void loop()
{
  if (mySerial.available())
    Serial.write(mySerial.read());
}
 

void SendTextMessage()
{
  mySerial.print("AT+CMGF=1\r");    //Because we want to send the SMS in text mode
  delay(100);
  mySerial.println("AT + CMGS = \"+639301316858\"");//send sms message, be careful need to add a country code before the cellphone number
  delay(100);
  mySerial.println("- field unit response -");//the content of the message
  delay(100);
  mySerial.println((char)26);//the ASCII code of the ctrl+z is 26
  delay(100);
  mySerial.println();
  Serial.println(" > sent '- field unit response -' to 09301316858");
}

 
void ShowSerialData()
{
  while(mySerial.available()!=0)
    Serial.write(mySerial.read());
}
