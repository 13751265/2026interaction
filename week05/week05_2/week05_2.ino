//week05_2_arduino_do_re_mi_seriaal
//在啟動時,void setup()裡多了do,re,mi
//修改自week02-5
//我想要把arduino跟processing結合
//在processing按下key1 2 3對應arduino的Do Re Mi使用USB serial
void setup() {
  Serial.begin(9600);//USB Serial開始傳輸,速度9600 bps
  tone(8,523,1000);delay(200);//do
  
  tone(8,587,1000);delay(200);//re
  
  tone(8,659,1000);delay(200);//mi

  tone(8,587,1000);delay(200);//re

  tone(8,523,1000);delay(200);//do
}
char c='0';
void loop() {
  if (Serial.available()){//如果USB Serial有收到資料
      c=Serial.read(); //就讀進來
  }
  if (c=='0') noTone(8);
  if (c=='1') tone(8,523,1000);//Do 1秒
  if (c=='2') tone(8,587,1000);//Re 1秒
  if (c=='3') tone(8,659,1000);//Mi 1秒
}
