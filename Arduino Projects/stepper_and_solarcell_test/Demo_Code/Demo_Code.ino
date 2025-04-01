
void setup(){
Serial.begin(9600);   // initialize serial port:
  pinMode(A0, INPUT);
}


void loop(){
  float toggle = analogRead(A0) * 5.0 / 1023.0;
  Serial.println(analogRead(A0));
  Serial.println(toggle);
  delay(1000);
  }


  //TODO: convert Serial plotter raw readings to Voltage
  //TODO: record reading of solar cell when laser is not shining on solar cell (set as ambient)
  //TODO: find way to record position/order of specific cuvette holders
  //TODO: during delay, record readings; replace DELAY with a FOR or WHILE loops
