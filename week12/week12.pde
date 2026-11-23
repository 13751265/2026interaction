
import java.util.ArrayList;

// =====================================
// TARGET SHOOTING GAME
// Processing 4 - Java Mode
// =====================================

final int MENU = 0;
final int SETTINGS = 1;
final int PLAYING = 2;
final int GAMEOVER = 3;

int screenState = MENU;

// =====================================
// 圓球設定類別
// =====================================

class BallConfig {
  color c;
  int points;
  float speed;
  int diameter;

  BallConfig(color c, int points,
             float speed, int diameter) {
    this.c = c;
    this.points = points;
    this.speed = speed;
    this.diameter = diameter;
  }

  BallConfig copy() {
    return new BallConfig(c, points, speed, diameter);
  }
}

// =====================================
// 全域設定
// =====================================

int gameDuration = 60;
float dpi = 1.00;

ArrayList<BallConfig> configs =
  new ArrayList<BallConfig>();

ArrayList<BallConfig> backupConfigs =
  new ArrayList<BallConfig>();

int backupDuration;
float backupDpi;

int selectedBall = 0;
int settingsPage = 0;

String dpiInput = "1.00";
boolean editingDpi = false;

color[] palette = {
  #FF5252, #FFD54F, #42A5F5,
  #66BB6A, #AB47BC, #FFFFFF,
  #FF9800, #00BCD4, #E91E63,
  #8BC34A, #795548, #607D8B
};

// =====================================
// 遊戲變數
// =====================================

ArrayList<TargetBall> balls =
  new ArrayList<TargetBall>();

int score = 0;
int shots = 0;
int hits = 0;

int startTime;
int timeLeft;

float aimX;
float aimY;

// =====================================
// 全螢幕
// =====================================

void settings() {
  fullScreen();
}

void setup() {
  frameRate(60);
  surface.setTitle("Target Shooting Game");

  cursor();

  resetSettings();

  aimX = width / 2;
  aimY = height / 2;
}

// =====================================
// 主迴圈
// =====================================

void draw() {
  background(20, 30, 45);

  if (screenState == PLAYING) {
    noCursor();
  } else {
    cursor();
  }

  if (screenState == MENU) {
    drawMenu();
  } else if (screenState == SETTINGS) {
    drawSettings();
  } else if (screenState == PLAYING) {
    drawGame();
  } else if (screenState == GAMEOVER) {
    drawGameOver();
  }
}

// =====================================
// 按鈕
// =====================================

void drawButton(String label,
                float x, float y,
                float w, float h,
                color c) {

  boolean hover = inButton(x, y, w, h);

  noStroke();
  fill(hover ? lerpColor(c, color(255), 0.15) : c);
  rect(x, y, w, h, 9);

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(17);
  text(label, x + w/2, y + h/2);
}

boolean inButton(float x, float y,
                 float w, float h) {
  return mouseX >= x && mouseX <= x+w &&
         mouseY >= y && mouseY <= y+h;
}

// =====================================
// 主選單
// =====================================

void drawMenu() {
  textAlign(CENTER, CENTER);

  fill(255);
  textSize(54);
  text("TARGET SHOOTING",
       width/2, height*0.26);

  fill(160, 185, 210);
  textSize(22);
  text("Shooting Training System",
       width/2, height*0.34);

  float bx = width/2 - 130;

  drawButton("START GAME",
    bx, height*0.48, 260, 58, #2879D0);

  drawButton("RANGE SETTINGS",
    bx, height*0.48+85, 260, 58, #42556B);

  fill(160);
  textSize(15);
  text("ESC : EXIT", width/2, height-45);
}

// =====================================
// 設定管理
// =====================================

void resetSettings() {
  gameDuration = 60;
  dpi = 1.00;
  dpiInput = "1.00";
  editingDpi = false;

  configs.clear();

  configs.add(new BallConfig(
    #FF5252, 10, 3.0, 45));

  configs.add(new BallConfig(
    #42A5F5, 20, 4.0, 40));

  configs.add(new BallConfig(
    #66BB6A, 30, 5.0, 35));

  selectedBall = 0;
  settingsPage = 0;
}

void backupSettings() {
  backupDuration = gameDuration;
  backupDpi = dpi;

  backupConfigs.clear();

  for (BallConfig b : configs) {
    backupConfigs.add(b.copy());
  }
}

void restoreSettings() {
  gameDuration = backupDuration;
  dpi = backupDpi;
  dpiInput = nf(dpi, 0, 2);

  configs.clear();

  for (BallConfig b : backupConfigs) {
    configs.add(b.copy());
  }

  selectedBall = 0;
  settingsPage = 0;
  editingDpi = false;
}

void addBall() {
  ArrayList<Integer> available =
    new ArrayList<Integer>();

  for (int i=0; i<palette.length; i++) {
    boolean used = false;

    for (BallConfig b : configs) {
      if (b.c == palette[i]) {
        used = true;
        break;
      }
    }

    if (!used) {
      available.add(i);
    }
  }

  if (available.size() == 0) return;

  int index = available.get(
    int(random(available.size())));

  configs.add(new BallConfig(
    palette[index], 10, 3.0, 45));

  selectedBall = configs.size()-1;
  settingsPage = selectedBall / 6;
}

void deleteBall() {
  if (configs.size() <= 1) return;

  configs.remove(selectedBall);

  selectedBall = constrain(
    selectedBall, 0, configs.size()-1);

  settingsPage = selectedBall / 6;
}

// =====================================
// 設定畫面
// =====================================

void drawSettings() {
  background(20, 30, 45);

  float x = max(35, width*0.12);
  float w = width - 2*x;

  fill(255);
  textAlign(LEFT, CENTER);
  textSize(36);
  text("RANGE SETTINGS", x, 55);

  // 上方設定
  fill(35, 50, 70);
  noStroke();
  rect(x, 95, w, 175, 12);

  fill(255);
  textSize(19);
  textAlign(LEFT, CENTER);

  text("MODE", x+25, 130);

  drawButton("BOUNCE MODE",
    x+190, 108, 210, 44, #2879D0);

  text("TIME", x+25, 190);

  int[] times = {30, 60, 90, 120};

  for (int i=0; i<4; i++) {
    drawButton(times[i]+"s",
      x+190+i*95, 168, 82, 44,
      gameDuration == times[i] ?
      #2879D0 : #42556B);
  }

  text("DPI", x+25, 245);

  drawButton(dpiInput +
    (editingDpi ? "|" : ""),
    x+190, 223, 210, 42,
    editingDpi ? #2879D0 : #42556B);

  // 球體列表
  float listY = 295;

  fill(255);
  textSize(23);
  text("BALL LIST (" + configs.size() + ")",
       x, listY);

  drawButton("+ ADD BALL",
    x+w-170, listY-22,
    170, 45, #238C62);

  float cardY = 340;
  float cardW = min(155, (w-50)/6.0);
  float cardGap = 10;

  for (int i=0; i<6; i++) {
    int index = settingsPage*6+i;

    if (index >= configs.size()) break;

    BallConfig b = configs.get(index);

    float cx = x+i*(cardW+cardGap);

    fill(index == selectedBall ?
      #345C85 : #2B3B50);

    stroke(index == selectedBall ?
      #68B4FF : #53657B);

    strokeWeight(index == selectedBall ? 3 : 1);
    rect(cx, cardY, cardW, 120, 10);

    stroke(0);
    strokeWeight(2.5);
    fill(b.c);
    ellipse(cx+cardW/2, cardY+40, 46, 46);

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(15);
    text("BALL " + (index+1),
      cx+cardW/2, cardY+80);

    textSize(13);
    text(b.points+" PTS",
      cx+cardW/2, cardY+102);
  }

  noStroke();

  // 分頁
  if (configs.size() > 6) {
    drawButton("<",
      x, 475, 45, 36, #42556B);

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(16);
    text((settingsPage+1)+"/"+
      ((configs.size()+5)/6),
      x+105, 493);

    drawButton(">",
      x+155, 475, 45, 36, #42556B);
  }

  // 個別設定
  float detailY = configs.size() > 6 ?
    525 : 490;

  BallConfig b = configs.get(selectedBall);

  fill(35, 50, 70);
  noStroke();
  rect(x, detailY, w, 260, 12);

  fill(255);
  textAlign(LEFT, CENTER);
  textSize(23);
  text("BALL " + (selectedBall+1) +
       " SETTINGS", x+25, detailY+32);

  drawButton("DELETE BALL",
    x+w-175, detailY+10,
    155, 42, #A04444);

  float lx = x+25;
  float rx = x+200;

  // 顏色
  fill(255);
  textSize(18);
  text("COLOR", lx, detailY+88);

  for (int i=0; i<palette.length; i++) {
    float px = rx+(i%6)*55;
    float py = detailY+77+(i/6)*48;

    boolean used = false;

    for (int j=0; j<configs.size(); j++) {
      if (j != selectedBall &&
          configs.get(j).c == palette[i]) {
        used = true;
      }
    }

    stroke(b.c == palette[i] ?
      #FFFFFF : #777777);

    strokeWeight(b.c == palette[i] ? 4 : 1);
    fill(palette[i]);
    ellipse(px, py, 32, 32);

    if (used) {
      stroke(0);
      strokeWeight(3);
      line(px-10, py-10, px+10, py+10);
    }
  }

  noStroke();

  // 分數
  drawValueControl("SCORE",
    str(b.points), lx, rx,
    detailY+178);

  // 速度
  drawValueControl("SPEED",
    nf(b.speed, 0, 2), lx+390,
    rx+390, detailY+178);

  // 大小
  drawValueControl("SIZE",
    str(b.diameter), lx, rx,
    detailY+230);

  // 底部操作
  float by = height-75;

  drawButton("CONFIRM",
    x, by, 160, 48, #238C62);

  drawButton("CANCEL",
    x+175, by, 160, 48, #A04444);

  drawButton("RESET",
    x+350, by, 160, 48, #64748B);
}

void drawValueControl(String label,
                      String value,
                      float lx, float rx,
                      float y) {
  fill(255);
  textAlign(LEFT, CENTER);
  textSize(18);
  text(label, lx, y);

  drawButton("-",
    rx, y-19, 38, 38, #42556B);

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(17);
  text(value, rx+94, y);

  drawButton("+",
    rx+150, y-19, 38, 38, #42556B);
}

// =====================================
// 開始遊戲
// =====================================

void startGame() {
  balls.clear();

  score = 0;
  shots = 0;
  hits = 0;

  timeLeft = gameDuration;
  startTime = millis();

  aimX = width/2;
  aimY = height/2;

  for (BallConfig b : configs) {
    balls.add(new TargetBall(b));
  }

  screenState = PLAYING;
}

// =====================================
// 球體
// =====================================

class TargetBall {
  BallConfig config;

  float x, y;
  float vx, vy;
  float r;

  TargetBall(BallConfig config) {
    this.config = config;

    r = config.diameter/2.0;

    if (random(1) < 0.5) {
      x = -r;
      vx = config.speed;
    } else {
      x = width+r;
      vx = -config.speed;
    }

    y = random(120, max(121, height-r-20));
    vy = random(-5, -2);
  }

  void update() {
    x += vx;

    vy += 0.18;
    y += vy;

    if (y-r < 85) {
      y = 85+r;
      vy = abs(vy)*0.85;
    }

    if (y+r > height) {
      y = height-r;
      vy = -abs(vy)*0.85;

      if (abs(vy) < 2) {
        vy = -random(3, 6);
      }
    }
  }

  void display() {
    stroke(0);
    strokeWeight(2.5);
    fill(config.c);

    ellipse(x, y, r*2, r*2);

    fill(0);
    textAlign(CENTER, CENTER);
    textSize(14);
    text(config.points, x, y);
  }

  boolean hit(float px, float py) {
    return dist(px, py, x, y) <= r;
  }

  boolean outside() {
    return x < -r-20 || x > width+r+20;
  }
}

// =====================================
// 遊戲畫面
// =====================================

void drawGame() {
  background(238, 245, 250);

  timeLeft = max(0,
    gameDuration-(millis()-startTime)/1000);

  if (timeLeft <= 0) {
    screenState = GAMEOVER;
    return;
  }

  for (int i=0; i<balls.size(); i++) {
    TargetBall b = balls.get(i);

    b.update();

    if (b.outside()) {
      balls.set(i, new TargetBall(b.config));
    } else {
      b.display();
    }
  }

  drawHUD();
  drawCrosshair();
}

// =====================================
// HUD
// =====================================

void drawHUD() {
  noStroke();
  fill(35, 53, 74);
  rect(0, 0, width, 85);

  float accuracy = shots == 0 ?
    0 : (float)hits/shots*100;

  fill(255);
  textAlign(LEFT, CENTER);
  textSize(25);

  text("TIME: "+timeLeft, 35, 42);

  text("ACCURACY: "+
    nf(accuracy, 0, 2)+"%",
    width*0.35, 42);

  text("SCORE: "+score,
    width*0.75, 42);
}

// =====================================
// 十字準星
// =====================================

void drawCrosshair() {
  pushStyle();

  stroke(0);
  strokeWeight(2);
  noFill();

  ellipse(aimX, aimY, 24, 24);

  line(aimX-22, aimY, aimX-7, aimY);
  line(aimX+7, aimY, aimX+22, aimY);
  line(aimX, aimY-22, aimX, aimY-7);
  line(aimX, aimY+7, aimX, aimY+22);

  fill(255, 0, 0);
  noStroke();
  ellipse(aimX, aimY, 4, 4);

  popStyle();
}

void mouseMoved() {
  if (screenState != PLAYING) return;

  aimX += (mouseX-pmouseX)*dpi;
  aimY += (mouseY-pmouseY)*dpi;

  aimX = constrain(aimX, 0, width);
  aimY = constrain(aimY, 85, height);
}

void mouseDragged() {
  mouseMoved();
}

// =====================================
// 遊戲結束
// =====================================

void drawGameOver() {
  background(20, 30, 45);

  float accuracy = shots == 0 ?
    0 : (float)hits/shots*100;

  fill(255);
  textAlign(CENTER, CENTER);

  textSize(55);
  text("GAME OVER",
    width/2, height*0.30);

  textSize(30);
  text("SCORE: "+score,
    width/2, height*0.43);

  text("ACCURACY: "+
    nf(accuracy, 0, 2)+"%",
    width/2, height*0.51);

  drawButton("RESTART",
    width/2-120, height*0.62,
    240, 55, #2879D0);

  drawButton("MAIN MENU",
    width/2-120, height*0.62+80,
    240, 55, #42556B);
}

// =====================================
// 滑鼠點擊
// =====================================

void mousePressed() {
  if (mouseButton != LEFT) return;

  if (screenState == MENU) {
    float bx = width/2-130;

    if (inButton(bx, height*0.48, 260, 58)) {
      startGame();
      return;
    }

    if (inButton(bx, height*0.48+85, 260, 58)) {
      backupSettings();
      dpiInput = nf(dpi, 0, 2);
      editingDpi = false;
      screenState = SETTINGS;
      return;
    }
  }

  else if (screenState == SETTINGS) {
    handleSettingsClick();
  }

  else if (screenState == PLAYING) {
    shots++;

    for (int i=balls.size()-1; i>=0; i--) {
      TargetBall b = balls.get(i);

      if (b.hit(aimX, aimY)) {
        score += b.config.points;
        hits++;

        balls.set(i, new TargetBall(b.config));
        break;
      }
    }
  }

  else if (screenState == GAMEOVER) {
    if (inButton(width/2-120,
      height*0.62, 240, 55)) {
      startGame();
    }

    else if (inButton(width/2-120,
      height*0.62+80, 240, 55)) {
      screenState = MENU;
    }
  }
}

// =====================================
// 設定畫面操作
// =====================================

void handleSettingsClick() {
  float x = max(35, width*0.12);
  float w = width-2*x;

  int[] times = {30, 60, 90, 120};

  for (int i=0; i<4; i++) {
    if (inButton(x+190+i*95,
      168, 82, 44)) {
      gameDuration = times[i];
      editingDpi = false;
      return;
    }
  }

  if (inButton(x+190, 223, 210, 42)) {
    editingDpi = true;
    return;
  }

  editingDpi = false;

  if (inButton(x+w-170, 273, 170, 45)) {
    addBall();
    return;
  }

  float cardW = min(155, (w-50)/6.0);
  float cardGap = 10;

  for (int i=0; i<6; i++) {
    int index = settingsPage*6+i;

    if (index >= configs.size()) break;

    float cx = x+i*(cardW+cardGap);

    if (inButton(cx, 340, cardW, 120)) {
      selectedBall = index;
      return;
    }
  }

  if (configs.size() > 6) {
    if (inButton(x, 475, 45, 36)) {
      settingsPage = max(0, settingsPage-1);
      return;
    }

    if (inButton(x+155, 475, 45, 36)) {
      settingsPage = min(
        (configs.size()-1)/6,
        settingsPage+1);
      return;
    }
  }

  float detailY = configs.size() > 6 ?
    525 : 490;

  BallConfig b = configs.get(selectedBall);

  if (inButton(x+w-175,
    detailY+10, 155, 42)) {
    deleteBall();
    return;
  }

  float rx = x+200;

  // 顏色
  for (int i=0; i<palette.length; i++) {
    float px = rx+(i%6)*55;
    float py = detailY+77+(i/6)*48;

    if (dist(mouseX, mouseY, px, py)<18) {
      boolean used = false;

      for (int j=0; j<configs.size(); j++) {
        if (j != selectedBall &&
            configs.get(j).c == palette[i]) {
          used = true;
        }
      }

      if (!used) {
        b.c = palette[i];
      }
      return;
    }
  }

  // 分數
  if (inButton(rx, detailY+159, 38, 38)) {
    b.points = max(1, b.points-5);
    return;
  }

  if (inButton(rx+150,
    detailY+159, 38, 38)) {
    b.points = min(500, b.points+5);
    return;
  }

  // 速度
  if (inButton(rx+390,
    detailY+159, 38, 38)) {
    b.speed = max(0.5, b.speed-0.5);
    return;
  }

  if (inButton(rx+540,
    detailY+159, 38, 38)) {
    b.speed = min(15, b.speed+0.5);
    return;
  }

  // 大小
  if (inButton(rx, detailY+211, 38, 38)) {
    b.diameter = max(15, b.diameter-5);
    return;
  }

  if (inButton(rx+150,
    detailY+211, 38, 38)) {
    b.diameter = min(120, b.diameter+5);
    return;
  }

  float by = height-75;

  // 確認
  if (inButton(x, by, 160, 48)) {
    applyDpi();
    screenState = MENU;
    return;
  }

  // 取消
  if (inButton(x+175, by, 160, 48)) {
    restoreSettings();
    screenState = MENU;
    return;
  }

  // 重置
  if (inButton(x+350, by, 160, 48)) {
    resetSettings();
    return;
  }
}

// =====================================
// DPI 處理
// =====================================

void applyDpi() {
  try {
    float v = Float.parseFloat(dpiInput);

    if (Float.isNaN(v) ||
        Float.isInfinite(v)) {
      v = 1.0;
    }

    dpi = constrain(v, 0.10, 10.00);

  } catch (Exception e) {
    dpi = 1.00;
  }

  dpi = round(dpi*100)/100.0;
  dpiInput = nf(dpi, 0, 2);
}

// =====================================
// 鍵盤
// =====================================

void keyPressed() {
  if (key == ESC) {
    key = 0;

    if (screenState == SETTINGS) {
      restoreSettings();
    }

    if (screenState != MENU) {
      screenState = MENU;
    } else {
      exit();
    }
    return;
  }

  if (screenState == SETTINGS && editingDpi) {
    if (key == ENTER || key == RETURN) {
      applyDpi();
      editingDpi = false;
    }

    else if (key == BACKSPACE) {
      if (dpiInput.length()>0) {
        dpiInput = dpiInput.substring(
          0, dpiInput.length()-1);
      }
    }

    else if ((key >= '0' && key <= '9') ||
             key == '.') {

      if (key == '.' &&
          dpiInput.indexOf('.')>=0) return;

      if (dpiInput.length()<8) {
        dpiInput += key;
      }
    }
  }
}
