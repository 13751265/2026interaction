//week02_5_arduino_do_re_mi
//我想要把arduino跟processing結合
//在processing按下key1 2 3對應arduino的Do Re Mi使用USB serial
void setup() {
  Serial.begin(9600);//USB Serial開始傳輸,速度9600 bps

}

void loop() {
  if (Serial.available()){//如果USB Serial有收到資料
    char c=Serial.read(); //就讀進來
    if (c=='1') tone(8,523,1000);//Do 1秒
    if (c=='2') tone(8,587,1000);//Re 1秒
    if (c=='3') tone(8,659,1000);//Mi 1秒
  }
}
