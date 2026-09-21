//week03_6_processing_NS_SHAFT_03
//修改自week03_5
//小朋友下樓梯 加上地板
void setup(){
  size(600,600); //小畫家截youtube圖片,得到大小
  for(int i=0;i<20;i++)floorX[i]=int(random(600-140));
}
int[]floorX=new int[20];//準備20個地板
void draw(){
  background(0,5,95);//小畫家的吸管
  fill(47,105,190);//左右磚的色彩
  for(int i=0;i<=10;i++){
    rect(0,i*60,25,60);//左邊的牆
    rect(600-25,i*60,25,60);//右邊的牆
  }
  fill(208,216,189);//畫地板
  //rect(200,200,140,25);//大概量一下寬度
  for(int i=0;i<20;i++){  
    //rect(floorX[i],i*75,140,25);
    //rect(floorX[i],75+i*75-frameCount%1500,140,25);//y座標一直減
    //用完20格地板後,會出現空白,我們加了%%(25*75)即%1500後,還是有問題
    //問一下ai,chatGPT建議(一開始錯了,後來對了),下面三行的版本
    float y=75+i*75-frameCount%1500;
    if(y<-25)y+=1500;
    rect(floorX[i],y,140,25);
  }
  fill(255);//畫尖刺
  for(int i=0;i<24;i++){
    float x=i*23+27;//多次測試出來的較適合的數值,數量23,往右移27
    triangle(x,0,x+9,30,x+18,0);//左上,下,右上
  }
}
