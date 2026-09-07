//week01_5_google_gemini_mouse_wheel
float circleSize = 50;

void setup() {
  size(400, 400);
}

void draw() {
  background(220);
  // 根據滾輪改變的大小來畫圓
  ellipse(width/2, height/2, circleSize, circleSize);
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount(); // 取得滾動數值
  circleSize -= e * 5;        // 改變變數數值
  
  // 限制圓形大小的極值
  circleSize = constrain(circleSize, 10, 300);
}
