#include <LiquidCrystal.h>

const int rs = 12, en = 11, d4 = 5, d5 = 4, d6 = 3, d7 = 2;
  LiquidCrystal lcd(rs, en, d4, d5, d6, d7);
const int pingPin = 7; // Trigger Pin of Ultrasonic Sensor
  const int echoPin = 6; // Echo Pin of Ultrasonic Sensor

void setup() {
  lcd.begin(16, 2);
  }

void loop() {
  int triggerVal = 0;  
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Trigger up");
    lcd.setCursor(0,1);
    lcd.print("to prime sonar");
  lcd.setCursor(15, 1);
  
  for(int i = 0; i < 10; ++i){
    triggerVal = triggerVal + analogRead(0);     
  }
  triggerVal = triggerVal/10;

  if(triggerVal>900){
    sonarYEET(triggerVal);
  }
   
} //constant loop/refresh causes fun screen effect

void sonarYEET(int& triggerVal) {
  
  lcd.clear();
    lcd.setCursor(0,0);
      lcd.print("Hold Trig down");
    lcd.setCursor(0,1);
      lcd.print("to fire");
    lcd.setCursor(15,1);
      lcd.print("5");

    int timeTick = 6;
    
    while(triggerVal>151){
      for(int i = 0; i < 10; ++i){
        triggerVal = triggerVal + analogRead(0);     
      }
      
      triggerVal = triggerVal/10;
      
      if(triggerVal<150){
        lcd.clear();
        lcd.setCursor(0,0);
        long duration; long cm;
        pinMode(pingPin, OUTPUT);
        digitalWrite(pingPin, LOW);
        delayMicroseconds(2);
        digitalWrite(pingPin, HIGH);
        delayMicroseconds(10);
        digitalWrite(pingPin, LOW);
        pinMode(echoPin, INPUT);
        duration = pulseIn(echoPin, HIGH);
          cm = duration / 29 / 2;
        lcd.print(cm);
        lcd.print("cm");
        delay(3000);
      }
      else{    
        lcd.clear();
        lcd.setCursor(0,0);
         lcd.print("Hold Trig down");
        lcd.setCursor(0,1);
          lcd.print("to fire");
        lcd.setCursor(15,1);
        --timeTick;
          lcd.print(timeTick);            
        delay(1000); //1 second
      }
     
     if(timeTick==0){triggerVal=151; 
      } //exit while loop after 5 seconds no input
    
    }
}
