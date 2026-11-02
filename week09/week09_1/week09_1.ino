//week09-1
//想要讓maker UNO發出比較多元的聲音
//老師示範用AI
//Q1: Maker UNO本身可以用pin8的buzzer利用tone()來發出單調的聲音,有辦法發出比較精彩的聲音嗎
//註: 老師教ai要10問10答,百問百答,所以要一步步練習問,找到答案
//Q2: 請幫我找PCM相關的libraries我想試試看
//Q3: 如何修改PCM Library讓他利用pin 8的軟體PWM或其他輸出技術撥放PCM
//這時ai給我們修改後的,makerUNO_PCM_D8.zip壓縮檔解開
//Q4: 我在編譯時,出現PCM.h的錯誤
// Experimental PCM output for Maker UNO pin D8 (ATmega328P 16 MHz).
// Uses Timer1 64 kHz interrupt and first-order pulse-density modulation.
// Experimental PCM output for Maker UNO pin D8 (ATmega328P 16 MHz).
// Uses Timer1 64 kHz interrupt and first-order pulse-density modulation.
// Experimental PCM output for Maker UNO pin D8 (ATmega328P 16 MHz).
// Uses Timer1 64 kHz interrupt and first-order pulse-density modulation.

#include "PCM.h"
#include "sounddata.h"

void setup() {
  startPlayback(sounddata_data, sounddata_length);
}

void loop() {
  // One-shot sample plays for 1 second. Press RESET to play again.
}
