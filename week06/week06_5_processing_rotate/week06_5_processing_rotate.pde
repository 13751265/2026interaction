//week06_5_processing_rotate
//修改自week06_3_processing_rotate
//想要做一個會旋轉的迷宮
void setup(){
  size(500,500);
}
void draw(){
  background(0);//黑色背景
  translate(250,250);//往右移,往下移
  rotate(radians(frameCount));//持續轉動
  rect(-250,-250,400,400);
  for(int i=0;i<8;i++){
    for(int j=0;j<9;j++){
      if((i+j)%2==1)fill(255);
      else fill(0);
      rect(j*50-200,i*50-200,50,50);
    }
  }
}
