// SWEEP_ANGLE_TEST

// Code Author: Jimmy Ho
// Start date: 
// Date Uploaded: 10-11 May 2023
// Current Status: Work-in-Progress
// Comments: 
//  Implementing refined "angle sweep" for laser to find best place to get signal 
//  (not while hitting edge of cuvette hole). modified for data collection
//=============================
//  Hardware:
//  Arduino UNO
//  17HS15-1504S Stepper Motor
//  NEMA17 Stepper Motor
//=============================

// Global Variables
#include <Stepper.h>
const int stepsPerRevolution = 200; // 200 steps = 360 degrees
Stepper myStepper(stepsPerRevolution, 2, 4, 3, 5); // initialize digital output pins 
float pv_Voltage = 0;
float pv_Threshold = 0.25; //compares volt reading
int numReadings = 5;

void setup(){
  Serial.begin(9600); 
  pinMode(A0, INPUT); //0V to 5V, 10-bit, analogRead(A0) * 5.0 / 1023.0
  myStepper.setSpeed(30); //rpm
}

void loop(){
  pv_Voltage = analogRead(A0)* 5.0 / 1023.0;
  while(pv_Voltage < pv_Threshold){
//    Serial.println(pv_Voltage);
    myStepper.step(1);
    pv_Voltage = analogRead(A0) * 5.0 / 1023.0;
    }
//  Serial.print("Voltage exit value: "); Serial.println(pv_Voltage);
//  Serial.println("exit light search"); delay(1000);

  //rotate 1 step at time, take multiple readings and store to determine highest laser reading at what step
  int idx = 0; //track index (correlate to step)
  int largest_idx = 0;
  float largest_pv_Voltage = 0;
  float temp = 0;
  
  while(pv_Voltage >= pv_Threshold){
    temp = readSolarCell(numReadings);
    if(temp > largest_pv_Voltage){
      //store largest index
      largest_pv_Voltage = temp;
      largest_idx = idx; 
      // Serial.println("NEW HI-SCORE!");
      }
    idx = idx + 1;
    myStepper.step(1);
    pv_Voltage = analogRead(A0) * 5.0 / 1023.0; delay(1000);
  }

  //Rotate to index of largest pv_Voltage, current idx likely larger than largest_idx
  int numRotate = - (idx - largest_idx);
  myStepper.step(numRotate); delay(1000);

  
  //MAKE MEASUREMENTS HERE
  //read data, send to matlab via serial monitor
  for( int ik = 0; ik<1200; ik++ ){
    pv_Voltage = analogRead(A0) * 5.0 / 1023.0;
    Serial.println(pv_Voltage);
    delay(100); //100ms * 1200 = 120 sec
    }
  
  //exit the hole
  Serial.println("Exiting..."); delay(30000); //30 sec to manually collect spectrum data
  myStepper.step(-numRotate + 15);

}


float readSolarCell(int numReadings){
  //MULTIPLE SOLAR CELL RECORDINGS PER STEP, THEN AVERAGE
    float voltRead[numReadings] = {};
    float voltReadAve = 0;
    float temp = 0;
    
    for (int kk = 0; kk < numReadings; kk++){
      voltRead[kk] = analogRead(A0) * 5.0 / 1023.0;
      //Serial.print(kk); Serial.print(": "); Serial.print(voltRead[kk]); Serial.print(", ");
      temp = temp + voltRead[kk];
    }
    //Serial.print('\n');
    voltReadAve = temp / numReadings;
    //Serial.print("Solar Cell Reading Average: "); Serial.println(voltReadAve);
  
    return voltReadAve;
  }
