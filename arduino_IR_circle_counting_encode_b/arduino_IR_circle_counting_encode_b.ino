#define UID 0x00
int IR_S = 3;                              //接arduino 3号引脚
void setup(){
  pinMode(IR_S, OUTPUT);
  Serial.begin(9600);                      // 9600 波特率
}
void loop(){
  //if ( Serial.available()) {
    int ch = 98;
    //int ch = Serial.read();
     
    IR_Send38KHZ(280,1);                //发送9ms的引导码高电平
    IR_Send38KHZ(140,0);                //发送4.5ms的引导码低电平
     
    IR_Sendcode(UID);                  //用户识别码
    IR_Sendcode(~UID);                 //用户识别码反吗
    IR_Sendcode(ch);                   //操作码
    IR_Sendcode(~ch);                  //操作码反码
    
    IR_Send38KHZ(21,1);                //发送结束码
  //}
  delay(20);
}
void IR_Send38KHZ(int x,int y) {      // y为1:生成38KHZ高低电平，x:指定生成时间
  for(int i=0;i<x;i++){              //15=386US
    if(y==1) {
      digitalWrite(IR_S,HIGH);
      delayMicroseconds(9);
      digitalWrite(IR_S,LOW);
      delayMicroseconds(9);
    } else{
      digitalWrite(IR_S,LOW);
      delayMicroseconds(20);
    }
  } 
}
void IR_Sendcode(uint8_t x){
  for(int i=0;i<8;i++){
    if((x&0x01)==0x01) {
      IR_Send38KHZ(23,HIGH);         //23:大约560US
      IR_Send38KHZ(64, LOW); 
    } else{
      IR_Send38KHZ(23, HIGH);
      IR_Send38KHZ(21, LOW);  
    }
    x=x>>1;
  } 
}

