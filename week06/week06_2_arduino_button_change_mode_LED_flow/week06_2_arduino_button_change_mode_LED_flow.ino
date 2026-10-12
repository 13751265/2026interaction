//week06_2_arduino_button_change_mode_LED_flow
int mode=0;//從小變大,1:從大變小
void setup() {
  pinMode(2,INPUT_PULLUP);
  for(int i=3;i<=13;i++){
    pinMode(i,OUTPUT);
  }
  tone(8,523,100);delay(100);//DO
  tone(8,784,100);delay(100);//Mi
}
int prev=HIGH,now=3;
void loop() {
  if (prev==HIGH && digitalRead(2)==LOW){//按下去的瞬間
    if (mode==0)mode=1;//從0變成1
    else mode=0;//從1變成0
    prev=LOW;
  } else if(prev=LOW && digitalRead(2)==HIGH){//放開的瞬間
    prev=HIGH;
  }
  if (mode==0){//0:從小變大
    now++;
    if(now>13)now=3;
    digitalWrite(now,HIGH);//亮
    delay(100);//等一下
    digitalWrite(now,LOW);//暗
  } else{
    now--;
    if(now<3)now=13;
    digitalWrite(now,HIGH);//亮
    delay(100);//等一下
    digitalWrite(now,LOW);//暗
  }
}
