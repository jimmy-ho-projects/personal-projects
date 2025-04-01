// Include the Arduino Stepper Library
#include <Stepper.h>

// Number of steps per output rotation
// 17HS15-1504S Stepper Motor, 1.8° degree per step
const int stepsPerRevolution = 200;

// Create Instance of Stepper library; initializes digital output pins of Arduino Mega 2560
Stepper myStepper(stepsPerRevolution, 22, 26, 23, 27);

void setup(){
  
  myStepper.setSpeed(60); // set the speed at 60 rpm:
  Serial.begin(9600);   // initialize the serial port:

  pinMode(A0, INPUT);

}

void loop(){
  Serial.println("lmao rofl eat poo");

  int toggle = analogRead(A0);

  if (toggle >= 1) {
    myStepper.step(1);
  }
  else{
    Serial.println("scanning");
    delay(1000); //pre-made delay to allow scanning of sample

    myStepper.step(1); //after scanning, move
    
    }
  
  Serial.println(toggle);
}
