//see LCD.ino for code

#include <LiquidCrystal.h>                                    // include the library code:
  const int rs = 12, en = 11, d4 = 5, d5 = 4, d6 = 3, d7 = 2; // initialize the library by associating any needed LCD interface pin with the arduino pin number it is connected to
  LiquidCrystal lcd(rs, en, d4, d5, d6, d7);
//above is a bunch of initializing LCD screen stuff

float T = 0; //float values are more accurate the integers, nerd stuff ask zinal

void setup() {
  Serial.begin(2000000);       //establish communication with PC
  lcd.begin(16, 2);            //set up the LCD's number of columns and rows; important otherwise screen gets fucky
}

void loop() {
  for (int i = 0; i < 1000; i++){
    T = T + analogRead(A0);
  } 
  //for loop will repeatedly take value of T, add whatever value is given by ANALOGUE PIN 0 to T, then repeat for 1000 iterations
  
  T = T / 1000; //takes the sum of above 1000 additions and divides by 1000 for average value
  
  lcd.setCursor(0,0); //set cursor to first column, first row
  lcd.print("Temp = "); 
  lcd.setCursor(0,1); //set cursor first column, second row
  lcd.print(T); //print whatever value is T
  lcd.setCursor(6,1); //set cursor 5th column, second row
  lcd.print(" F");
  Serial.println(T); //prints whatever value is T into serial plotter for diagnostic purposes
  
  
}
  
