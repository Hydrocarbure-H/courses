#include <Arduino_FreeRTOS.h>

const char *pcTextForTask1 = "Tache 1 en execution";
const char *pcTextForTask2 = "Tache 2 en execution";

void Task1(void *pvParameters);
void Task2(void *pvParameters);

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(13, OUTPUT);
  pinMode(12, INPUT_PULLUP);
  while (!Serial) {
    ;
  }
  
  xTaskCreate(
    Task1, "Task 1", 128, (void*) pcTextForTask1, 1, NULL);

  xTaskCreate(
    Task2, "Task 2", 128, (void*) pcTextForTask2, 1, NULL);

  xTaskCreate(
    Task3, "Task 2", 128, (void*) pcTextForTask2, 1, NULL);


  vTaskStartScheduler();
}

void loop() {
  //Empty. Things are done in Tasks
}

void Task1(void *pvParameters) {
  volatile uint32_t cnt;
  char *pcTaskName;
  pcTaskName = (char *)pvParameters;
  for (;;) {

    Serial.println(pcTaskName);
    // delay(1000);
      for(cnt=0; cnt<=3200000;cnt++);
  }
}

void Task2(void *pvParameters) {
  volatile uint32_t cnt;
  char *pcTaskName;
  pcTaskName = (char *)pvParameters;
  for (;;) {

    Serial.println(pcTaskName);

    // delay(1000);
    for(cnt=0; cnt<=32000000;cnt++);
  }
}

void Task3(void *pvParameters) {
  volatile uint32_t cnt;
  char *pcTaskName;
  pcTaskName = (char *)pvParameters;
  for (;;) {
    if(Serial.available() > 0)
    {
      char incommingChar = Serial.read();

      // on
      if (incommingChar == 'M')
      {
        Serial.println("ON");
        digitalWrite(13, HIGH);
      }
      else if(incommingChar == 'A')
      {
        Serial.println("OFF");
        digitalWrite(13, LOW);
      }
    }
  }
}
