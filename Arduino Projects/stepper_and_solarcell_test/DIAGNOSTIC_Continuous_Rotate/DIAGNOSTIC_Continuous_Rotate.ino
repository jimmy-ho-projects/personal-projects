// SWEEP_ANGLE_TEST

// Code Author: Jimmy Ho
// Start date: ?? April 2023 (ongoing)
// Date Uploaded: 8 May 2023
// Current Status: Work-in-Progress
// Comments: 
//  Continuous rotation for longevity test. Should output number of rotations
//=============================
//  Hardware:
//  Arduino Mega 2560
//  17HS15-1504S Stepper Motor
//  NEMA17 Stepper Motor
//=============================

// Global Variables
#include <Stepper.h>
const int stepsPerRevolution = 200; // 200 steps = 360 degrees
Stepper myStepper(stepsPerRevolution, 22, 26, 23, 27); // initialize digital output pins 


void setup(){
  Serial.begin(9600); 
  pinMode(A0, INPUT); //0V to 5V, 10-bit, analogRead(A0) * 5.0 / 1023.0
  myStepper.setSpeed(30); //rpm
}

void loop(){
  Serial.println("Beginning longevity Test in");
  Serial.println("3..."); delay(1000);
  Serial.println("2..."); delay(1000);
  Serial.println("1..."); delay(1000);
  while(true){
    myStepper.step(100); // >= (6V, 0.5A)
  }

}
