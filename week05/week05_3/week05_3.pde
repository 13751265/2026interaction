//week05_3_processing_do-re-mi
//修改自week05_2
//希望有視覺的互動
import processing.serial.*; //使用ＵＳＢ外掛
Serial myPort;
void setup(){
  size(300,200);//隨便的視窗
  myPort=new Serial(this,"COM4",9600);//中間COM3 or COM4
}
void draw(){
  background(128);
  if(p1==1)fill(0);//黑色,按下去
  else fill(255);//否則是白色
  rect(0,0,100,150);//第1個按鍵
  
  if(p2==1)fill(0);
  else fill(255);
  rect(100,0,100,150);//第2個按鍵
  
  if(p3==1)fill(0);
  else fill(255);
  rect(200,0,100,150);//第3個按鍵
  
  fill(255,0,0);
  if(now=='1')ellipse(50,175,50,50);
  if(now=='2')ellipse(150,175,50,50);
  if(now=='3')ellipse(250,175,50,50);

}
char now=0;
int p1=0,p2=0,p3=0;
void keyPressed(){//按數字鍵時,會利用USB Serial上傳資料到電路板
  now=key;
  if (p1==0 && key=='1')myPort.write('1');//之前沒按,現在按
  if (p2==0 && key=='2')myPort.write('2');
  if (p3==0 && key=='3')myPort.write('3');
  if (p1==0 && key=='1')p1=1;//0代表沒有按1代表按下去
  if (p2==0 && key=='2')p2=1;
  if (p3==0 && key=='3')p3=1;
  now=key;
}
void keyReleased(){
  now='0';
  if(key=='1')p1=0;//放開1鍵
  if(key=='2')p2=0;//放開2鍵
  if(key=='3')p3=0;//放開3鍵
  myPort.write('0');
}
