#include <Stepper.h> //Arduino Stepper Library

// Hardware:
// Arduino Mega 2560
// 17HS15-1504S Stepper Motor

const int stepsPerRevolution = 200; // Number steps per rotation (1.8° degree per step)

// Create Instance of Stepper library; 
// initializes digital output pins (Arduino Mega 2560)
Stepper myStepper(stepsPerRevolution, 22, 26, 23, 27);

void setup(){
  myStepper.setSpeed(30); // set speed 30 rpm:
  Serial.begin(9600);   // initialize serial port:
  pinMode(A0, INPUT);
}


void loop(){
  int toggle = analogRead(A0);
//  
  while(toggle<=350){
    myStepper.step(1);
    Serial.println(analogRead(A0) * 5 / 1023);
    toggle = analogRead(A0); //refresh toggle whatever
    }
    Serial.println(toggle * 5 / 1023); //5V/1023 = x / toggle
    Serial.println("have left loop");
    delay(3000); //3 second delay, allow data collection  
    myStepper.step(20);
  }


  //TODO: convert Serial plotter raw readings to Voltage
  //TODO: record reading of solar cell when laser is not shining on solar cell (set as ambient)
  //TODO: find way to record position/order of specific cuvette holders
  //TODO: during delay, record readings; replace DELAY with a FOR or WHILE loops
