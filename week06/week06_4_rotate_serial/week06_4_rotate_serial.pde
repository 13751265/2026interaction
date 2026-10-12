//week06_4_rotate_serial
//修改自week06_3_processing_rotate
//上面還要再補1~3行
import processing.serial.*;
Serial myPort;
void setup(){
  size(500,500);
  myPort=new Serial(this,"COM3",9600);
}
int now=0;//現在的旋轉角度
int dd=1;//now++跟now--用now+=dd其中dd是1or-1
void draw(){
  if(myPort.available()>0){//如果有資料要讀
    if(myPort.read()=='1')dd=-1;//讀入的資料
    else dd=1;
  }
  background(0);//黑色背景
  translate(250,250);//往右移,往下移
  now+=dd;
  rotate(radians(now));//持續轉動
  rect(-250,-250,400,400);
}
void mousePressed(){//先暫時用mouse點擊,來修改dd轉動改變量
  if(dd==1)dd=-1;//正的變成負的
  else dd=1;//負的變成正的
}
