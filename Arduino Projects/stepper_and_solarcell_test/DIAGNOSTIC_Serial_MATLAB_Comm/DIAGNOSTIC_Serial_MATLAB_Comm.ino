// uploaded 9 May 2023

void setup() {
  // Initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
}


void loop() {

  unsigned int current_time = millis();
  static int measure_Time = 3000; //15min
  
  int i = 0;
  while( current_time < measure_Time ){
    Serial.println(i);
    i++;
    current_time = millis();
    }
    
Serial.println('f'); delay(1000);
}
