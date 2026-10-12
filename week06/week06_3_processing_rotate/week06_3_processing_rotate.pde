//week06_3_processing_rotate
//想要做一個會旋轉的迷宮
void setup(){
  size(500,500);
}
void draw(){
  background(0);//黑色背景
  translate(250,250);//往右移,往下移
  //translate(mouseX,mouseY);
  //println(mouseX,mouseY);
  rotate(radians(frameCount));//持續轉動
  rect(-250,-250,400,400);
}
