//week01_6_mousewheel
//整合week01-4 week01-5
float circleSize=5;//小一點
void setup(){
  size(500,500);
  background(255);
}
void draw(){
  strokeWeight(circleSize);
  if (mousePressed){
    if (mouseButton==LEFT)stroke(0);
    if (mouseButton==RIGHT)stroke(255);
    line(mouseX,mouseY,pmouseX,pmouseY);
  }
  noStroke();
  rect(0,0,100,100);
  stroke(0);
  strokeWeight(1);
  ellipse(50,50,circleSize,circleSize);
}
void mouseWheel(MouseEvent e){
  circleSize=circleSize-e.getCount();
}
