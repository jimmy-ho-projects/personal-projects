//see LCD.ino for code

#include <LiquidCrystal.h>                                  // include the library code:
  const int rs = 12, en = 11, d4 = 5, d5 = 4, d6 = 3, d7 = 2; // initialize the library by associating any needed LCD interface pin with the arduino pin number it is connected to
  LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

int setCursor_xpos = 0;
int setCursor_ypos = 0; //keeps track of current position of cursor on LCD screen

void setup() {
  Serial.begin(9600);          //establish communication with PC
  lcd.begin(16, 2);            // set up the LCD's number of columns and rows:
  lcd.print(" Move w JoyStick");  // Print a message to the LCD.
  setCursor_xpos = 0;
  setCursor_ypos = 1;         //see int setCursor
}


void loop() {
  lcd.setCursor(0, 1);                // set the cursor to column 0, line 1 (note: line 1 is the second row, since counting begins with 0):
}
