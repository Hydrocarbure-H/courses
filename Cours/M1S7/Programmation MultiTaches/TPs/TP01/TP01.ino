int frequency_counter = 5;
int ledPin = 13;

void setup() 
{
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
}

void loop() 
{
  if (Serial.available() > 0) 
  {
    char incomingChar = Serial.read();
    Serial.print("Start frequency is f=");
    Serial.println(frequency_counter);

    if (incomingChar == '+' && frequency_counter < 10) 
    {
      frequency_counter = frequency_counter + 1;
    } 
    else if (incomingChar == '-' && frequency_counter > 1) 
    { 
      frequency_counter = frequency_counter - 1;
    }
  }

  int blinkDelay = 1000 / frequency_counter; // Do the maths for frequency result
  digitalWrite(ledPin, HIGH); // Switch on
  delay(blinkDelay);
  digitalWrite(ledPin, LOW); // Switch off
  delay(blinkDelay);
}