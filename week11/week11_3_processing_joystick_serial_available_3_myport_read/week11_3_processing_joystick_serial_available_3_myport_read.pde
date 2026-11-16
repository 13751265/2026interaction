//week11_3_processing_joystick_serial_available_3_myport_read
//要把auduino的資料,用usb讀入
import processing.serial.*; //使用USB的serial的外掛
Serial myPort;
void setup(){
  size(512,512);
  myPort=new Serial(this,"COM3",9600);
}
int x=0,y=0,sw=0;
void draw(){
  background(255);
  if(myPort.available()>=3){
    x=(int)myPort.read();
    y=(int)myPort.read();
    sw=(int)myPort.read();
    //myPort.read();
  }
  ellipse(x+128,y+128,8,8);
}
