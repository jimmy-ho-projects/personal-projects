// Vers 4.00 

// Code Author: Jimmy Ho
// Start date: 14 March 2023
// Date Uploaded: 16 March 2023
// Current Status: Work-in-Progress
// Comments: 
//  Will include method of indexing cuvette position, credit to Ryan + Poala for idea
//  From Meeting Minutes 3/10:
//  Ryan: Homing system, load blank first (all other cuvette holders are empty), 
//    rotate and record which has the lowest value, the cuvette with the blank is cuvette 1
//  Poala: a variable to increment the number of steps taken, 
//    record how many steps needed to get to the next cuvette 
//=============================
//  Hardware:
//  Arduino Mega 2560
//  17HS15-1504S Stepper Motor
//  NEMA17 Stepper Motor
//  ** expecting walls between cuvette walls for program to run properly
//=============================

// Global Variables
#include <Stepper.h>
const int stepsPerRevolution = 200; // steps per rotation (1.8° degree per step)
Stepper myStepper(stepsPerRevolution, 22, 26, 23, 27); // initialize digital output pins 
unsigned int cuvetteNum = 6;
unsigned int stepsTaken = 0;
unsigned int stepsBetweenCuvette[6]; //store distance between cuvettes as array, credit to Poala
float pv_Voltage = 0; //0V to 5V, 10-bit, analogRead(A0) * 5 / 1023, pv = photo voltaic
int blankIndex = 0;
int currIndex = 0;

//TODO: calibration stage (Ryan's idea)
void setup(){
  myStepper.setSpeed(30); // 30 rpm:
  Serial.begin(9600);     // initialize serial
  pinMode(A0, INPUT);
  
  //==============================
  //CALIBRATION: IDEA CREDIT RYAN
  //==============================
  Serial.println("Please insert BLANK, then send data to Serial monitor"); //placeholder text until proper GUI
  while(Serial.available() == 0){
    //Pause program until any data input
    //TOOLS > SERIAL MONITOR > input any value 
    //then press "SEND"
    }
  Serial.println("BLANK loaded\nCALIBRATING");
  delay(1000);

  //hacky way to clear Serial buffer https://linuxhint.com/clear-arduino-serial-buffer/
  Serial.end();
  Serial.begin(9600); 
  
  //Manual check if power supply on (motor can spin)
  Serial.println("Make sure Power Supply is ON then send data to Serial monitor"); //placeholder text until proper GUI
  while(Serial.available() == 0){
      myStepper.step(100); myStepper.step(-100);
    }
  Serial.println("BLANK loaded\nCALIBRATING");
  delay(1000);


  pv_Voltage = analogRead(A0) * 5.0 / 1023.0;
      
  //initial rotation to align with first valid cuvette laser reading 
  while(pv_Voltage < 1.50){
      myStepper.step(1);
      pv_Voltage = analogRead(A0) * 5.0 / 1023.0;
//        https://www.arduino.cc/reference/en/language/variables/data-types/float/
//        "If doing math with floats, you need to add a decimal point, otherwise 
//        it will be treated as an int."
      Serial.println("Initial Rotation");
      Serial.println(pv_Voltage);
  }

  float bork[cuvetteNum]; //initialize array "bork", store valid pv readings (blank should be lowest)

  //for # of cuvette, rotate until valid signal, then record / store val in BORK
  //store n as current cuvette index
  for(int n = 0; n < cuvetteNum; n++){
    Serial.println("NEXT INDEX"); delay(1000);
    myStepper.step(20); //forcing steps to misalign laser, reset reading 
    stepsTaken = 20;
    pv_Voltage = analogRead(A0) * 5.0 / 1023.0; //refresh reading
    while(pv_Voltage < 1.50){
      myStepper.step(1);
      stepsTaken += 1;
      pv_Voltage = analogRead(A0) * 5.0 / 1023.0;
      Serial.println("Calibration voltage: ");
      Serial.println(pv_Voltage);
      }
    currIndex = n;
    bork[n] = pv_Voltage;
    stepsBetweenCuvette[n] = stepsTaken; //index 1 correlate to distance between cuvette 1 and 2
  }

  float blankVal = 5.9; //store lowest value
  blankIndex = 0;
  
  //iterate through array, compare and store lowest value
  //latest index 5 should be current position  
  for(int n = 0; n < cuvetteNum; n++){
    if(blankVal>bork[n]){
      blankVal = bork[n]; blankIndex = n;}
    }
//
//  //after calibration, rotate platform to BLANK INDEX
//  while(currIndex != blankIndex){
//    //TODO
//    }
    
  while(true){
    Serial.println(bork[0]);
    Serial.println(bork[1]);
    Serial.println(bork[2]);
    Serial.println(bork[3]);
    Serial.println(bork[4]);
    Serial.println(bork[5]);
    Serial.println(blankIndex); 
    Serial.println(blankVal); delay(1000);
    }
}


void loop(){
//  stepsTaken = 0; //reset # steps 
//  pv_Voltage = analogRead(A0) * 5 / 1023;
//  
//  while( pv_Voltage <= 2.5 ){ //threshold based on voltage reading
//    myStepper.step(1);
//    stepsTaken += 1; 
//    pv_Voltage = analogRead(A0) * 5 / 1023; //refresh pv_voltage reading
//    
//    Serial.println(pv_Voltage);
// 
//    }
//    
//    Serial.println(pv_Voltage); //5V/1023 = x / toggle
//    Serial.println("have left loop");
//    delay(3000); //3 second delay, allow data collection  
//    myStepper.step(20);

  Serial.println("END");

  }




  //TODO: convert Serial plotter raw readings to Voltage
  //TODO: record reading of solar cell when laser is not shining on solar cell (set as ambient)
  //TODO: find way to record position/order of specific cuvette holders
  //TODO: during delay, record readings; replace DELAY with a FOR or WHILE loops
