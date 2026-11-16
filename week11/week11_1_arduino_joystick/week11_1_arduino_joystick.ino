//week11_1_arduino_joystick
//要把joystick的A0,A1接起來,讀資料
void setup() {
  // put your setup code here, to run once:

}

void loop() {
  // put your main code here, to run repeatedly:
  int x=analogRead(A0);//讀入x座標
  int y=analogRead(A1);//讀入y座標
  tone(8,x);//會把x的值,直接很吵的輸出
}
