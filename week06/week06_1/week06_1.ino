//week06_1
void setup() {
  pinMode(2,INPUT_PULLUP);//預設pin2是button
  pinMode(8,OUTPUT);//預設pin8是buzzer
  tone(8,523,100);//開啟時,發一下聲音,代表程式沒錯 
}

void loop() {
  if (digitalRead(2)==LOW){
    tone(8,523,100);//0.1秒
    delay(100);//等一下
  }
}
