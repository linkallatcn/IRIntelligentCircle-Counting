#include <IRremote.h>

int RECV_PIN = 11;

IRrecv irrecv(RECV_PIN);

decode_results results;

long cartime1 = 0;
long cartime2 = 0;
long delaytime = 20000;
int carcircle1 =0,carcircle2=0;

void setup()
{
  Serial.begin(9600);
  irrecv.enableIRIn(); // Start the receiver
  cartime1=-20000;
  cartime2=-20000;
}

void loop() {
  if (irrecv.decode(&results)) {
    //Serial.println(results.value, HEX);
    if(results.value==0xFF8679){	//cara
      if(millis()-cartime1>0){
        cartime1=millis();
        Serial.print("cara circle:");
        Serial.print(carcircle1);
        carcircle1=carcircle1+1;
        Serial.println(results.value);
      }
    }else
    if(results.value==0xFF46B9){	//carb
      if(millis()-cartime2>0){
        cartime2=millis();
        Serial.print("carb circle:");
        Serial.print(carcircle2);
        carcircle2=carcircle2+1;
        Serial.println(results.value);
      }
    }
    irrecv.resume(); // Receive the next value
  }
}
