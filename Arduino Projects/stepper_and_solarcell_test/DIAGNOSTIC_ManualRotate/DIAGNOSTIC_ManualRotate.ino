// Adapted from solar_cell_stepper_motor_test_Vers 4.00 

// Code Author: Jimmy Ho
// Start date: 5 April 2023
// Date Uploaded: 10 April 2023
// Current Status: eh 
// Comments: allow user specified rotation of platform w/ solar cell reading
//=============================
//  Hardware:
//  Arduino Mega 2560
//  17HS15-1504S Stepper Motor
//  NEMA17 Stepper Motor
//=============================

// Global Variables
#include <Stepper.h>
const int stepsPerRevolution = 200; // 200 steps = 360 degrees
Stepper myStepper(stepsPerRevolution, 2, 4, 3, 5); // initialize digital output pins 


void setup(){
  Serial.begin(9600); 
  pinMode(A0, INPUT); //0V to 5V, 10-bit, analogRead(A0) * 5.0 / 1023.0
  myStepper.setSpeed(30); //rpm
}


void loop(){

  Serial.println("Enter # of steps in command line then press ENTER: ");
  Serial.print("> ");

  //WAIT FOR USER ENTRY
  while (!Serial.available()){
    //do nothing while Serial buffer empty
    // user enters stuff into command line, stored in serial buffer (64 byte)
      // Note: terminating characters add extra byte to serial buffer
      // see command line settings
      //  carriage return \r
      //  newline \n
  }
  delay(100); //IMPORTANT: give serial buffer time to process recieved bytes

  //READ BUFFER
  unsigned int ii = 0;
  char txtArray[Serial.available()+1]={};
  while (Serial.available()){
    txtArray[ii]=Serial.read(); //assign character at first byte in buffer to array, frees up byte
    ii++; delay(5);
  }

  Serial.println(txtArray); //newline added from command line
  
  //CONVERTING ENTRY TO INTEGER
  int txt2int = atoi(txtArray); //return first integer, else zero for first non-int byte

  //CHECK IF INTEGER
  if (txt2int == 0){
    Serial.println("Input not integer");
    Serial.end();
    Serial.begin(9600); //hacky, clear serial buffer
  }
  //ROTATE AND RECORD SOLAR CELL READING
  else{
    Serial.print("Stepper motor rotate by ");
    Serial.print(txt2int);
    Serial.println(" steps.");

    stepperRotate(txt2int);
  }
  
}

void stepperRotate(int numRotate){

  unsigned long currTime[2]; //index 0 store begin time, index 1 store end time, difference for time elapsed 
  int numReadings = 5; //number of solar cell readings to take per step
  float voltRead[numReadings] = {};

  //MULTIPLE SOLAR CELL RECORDINGS PER STEP, THEN AVERAGE
  for (int ii = 0; ii < numRotate; ii++){
    myStepper.step(1); 
    currTime[0] = millis();
    float voltReadAve = 0;
    for (int kk = 0; kk < numReadings; kk++){
      voltRead[kk] = analogRead(A0) * 5.0 / 1023.0;
      voltReadAve = voltReadAve + voltRead[kk];
  
      char stringBuffer[32]; //32 byte store string for sprintf
      char volt_float2char[]={};
      dtostrf(voltRead[kk], 4, 2, volt_float2char); //https://www.programmingelectronics.com/dtostrf/
      Serial.print("Solar Cell Voltage Reading "); Serial.print(kk+1); Serial.print(": ");
      Serial.println(volt_float2char);
      
    }
    voltReadAve = voltReadAve / numReadings;
    Serial.print("Solar Cell Reading Average: "); Serial.println(voltReadAve);
    currTime[1] = millis();
    currTime[0] = currTime[1] - currTime[0];
    Serial.print("Solar Cell Readings Elapsed time: "); Serial.print(currTime[0]); Serial.println(" ms");
  }
  
}

//    void setup(){
//  Serial.begin(9600);
//  char buffer[32]={};
//  char floatbuff[]={};
//  int kk = 9;
//  float numBurritos = 2.23;
//  dtostrf(numBurritos, 4, 2, floatbuff); 
//  sprintf(buffer, "Solar Cell Voltage Reading %d: %s", kk, floatbuff);
//  Serial.println(buffer);
