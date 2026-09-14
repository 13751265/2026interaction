//week02_1_??
//鍵盤的操作,與上周的mouse結合
//FIle-preference字型放大
void setup(){//設定的函式
  size(500,500);//視窗大小
}
void draw(){
 if (mousePressed)background(#F58A8A);
 else background(#D6F074);//用tool-color選擇器
 fill(0,0,255); //藍色的填充色
 textSize(80); //字的大小
 text("key: "+key,200,300); //把注音輸入法,才能收到key
}
