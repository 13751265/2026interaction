//week05_3_arduino_do_re_mi_seriaal
//修改自week05_2_arduino_do_re_mi_seriaal
//在啟動時,void setup()裡多了do,re,mi
//修改自week02-5
//我想要把arduino跟processing結合
//在processing按下key1 2 3對應arduino的Do Re Mi使用USB serial
void setup() {
  pinMode(8,OUTPUT);//BUZZER 8
  pinMode(10,OUTPUT);//對應0
  pinMode(11,OUTPUT);//對應1
  pinMode(12,OUTPUT);//對應2
  pinMode(13,OUTPUT);//對應3
  
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
  for(int i=10;i<=13;i++)digitalWrite(i,LOW);
  if (c>='0'&&c<='3')digitalWrite(c-'0'+10,HIGH);
  if (c=='0') noTone(8);
  if (c=='1') tone(8,523,1000);//Do 1秒
  if (c=='2') tone(8,587,1000);//Re 1秒
  if (c=='3') tone(8,659,1000);//Mi 1秒
}
