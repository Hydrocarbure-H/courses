#include <Arduino_FreeRTOS.h>

void vTask1(void * pvParameters);
void vTask2(void * pvParameters);
void vTask3(void * pvParameters);
TaskHandle_t xTask2Handle = NULL;
TaskHandle_t xTask3Handle = NULL;

void setup() {
  Serial.begin(2000000);
  xTaskCreate(
    vTask1, "Task1", 128, NULL, 2, NULL);

  xTaskCreate(
    vTask2, "Task2", 128, NULL, 1, & xTask2Handle);

  xTaskCreate(
    vTask3, "Task3", 128, NULL, 3, & xTask3Handle);

  vTaskStartScheduler();
}

void loop() {
}

void vTask1(void * pvParameters) {
  UBaseType_t uxPriority;
  uxPriority = uxTaskPriorityGet(NULL);
  volatile uint32_t cnt;

  for (;;) {
    Serial.print("Task1 is running with priority: ");
    Serial.print(uxPriority);
    Serial.print(" About to raise Task2 priority to: ");
    Serial.println(uxPriority + 1);
    vTaskPrioritySet(xTask2Handle, uxPriority + 1); 
  }
}

void vTask2(void * pvParameters) {
  UBaseType_t uxPriority;
  uxPriority = uxTaskPriorityGet(NULL);
  volatile uint32_t cnt;

  for (;;) {
    Serial.print("Task2 is running with priority: ");
    Serial.print(uxPriority);
    Serial.print(" About to lower Task2 priority to: ");
    Serial.println(uxPriority - 2);
    vTaskPrioritySet(xTask3Handle, uxPriority + 1);
    vTaskPrioritySet(NULL, uxPriority - 2);
  }
}

void vTask3(void * pvParameters) {
  UBaseType_t uxPriority;
  uxPriority = uxTaskPriorityGet(NULL);
  volatile uint32_t cnt;

  for (;;) {
    Serial.print("Task3 is running with priority: ");
    Serial.print(uxPriority);
    Serial.print(" About to lower Task3 priority to: ");
    Serial.println(uxPriority - 2);
    vTaskPrioritySet(NULL, uxPriority - 2);
  }
}