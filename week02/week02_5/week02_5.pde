//week02_5_arduino_do_re_mi_import_serial_myPort_void_keyPressed_write
//我想要把arduino跟processing結合
//在processing按下key1 2 3對應arduino的Do Re Mi使用USB serial
import precessing.serial.*;//使用ＵＳＢ外掛
Serial myPort;
void setup(){
  size(300,200);//隨便的視窗
  myPort=new Serial(this,"COM3",9600);//中間COM3 or COM4
}

void draw(){
 
}
void keyPressed(){//按數字鍵時,會利用USB Serial上傳資料到電路板
  if (key=='1')myPort.write('1');
  if (key=='2')myPort.write('2');
  if (key=='3')myPort.write('3');
