//week11_3_arduino_joystick
//將要跟processing相互溝通
void setup() {
  Serial.begin(9600);
  pinMode(2,INPUT_PULLUP);
}
int myAnalogRead(int pin){
  //利用map()函式,把0..1023對應0..255
  return map(analogRead(pin),0,1023,0,255);
}

void loop() {
  delay(30);
  Serial.write(myAnalogRead(A0));
  Serial.write(myAnalogRead(A1));
  if (digitalRead(2)==LOW)Serial.print("D");//DOWN按
  else Serial.print("U");//UP沒按
}
