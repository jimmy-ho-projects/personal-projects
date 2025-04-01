void setup() {
  // put your setup code here, to run once:
Serial.begin(9600);
}

float Photoread = 0.0;

void loop() {
  Photoread = 0;
  for(int i = 0; i < 1000; i++ ){
     Photoread = Photoread + analogRead(0);
  }

Serial.println(5 * Photoread/1000 /1024);
}
