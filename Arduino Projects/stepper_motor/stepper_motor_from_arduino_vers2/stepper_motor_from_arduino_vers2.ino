// Include the Arduino Stepper Library
#include <Stepper.h>

// Number of steps per output rotation
// 17HS15-1504S Stepper Motor, 1.8° degree per step
const int stepsPerRevolution = 200;

// Create Instance of Stepper library; initializes digital output pins of Arduino Mega 2560
Stepper myStepper(stepsPerRevolution, 22, 26, 23, 27);

void setup()
{
  
  myStepper.setSpeed(60); // set the speed at 60 rpm:
  Serial.begin(9600);   // initialize the serial port:

  pinMode(42, INPUT);
  pinMode(43, OUTPUT);
  digitalWrite(43, HIGH);
}

void loop()
{

  Serial.println("lmao rofl eat poo");

  int toggle = digitalRead(42);

  if (toggle == 1) {
    myStepper.step(1);
  }
  
  Serial.println(toggle);
}
