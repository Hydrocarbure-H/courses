//===================================================================================================================

#define DISPLAY_SSD1306Wire

#include <BLEDevice.h>
#include <BLEUtils.h>
#include <BLEServer.h>
#include <BLE2902.h>

#define SERVICE_UUID        "042bd80f-14f6-42be-a45c-a62836a4fa3f"
#define CHARACTERISTIC_UUID "065de41b-79fb-479d-b592-47caf39bfccb"

BLEServer* pServer = NULL;
BLECharacteristic* pCharacteristic = NULL;

#define NOTIFY_CHARACTERISTIC

bool estConnecte = false;
bool etaitConnecte = false;
uint8_t valeur = 0; // le compteur

class EtatServeur : public BLEServerCallbacks 
{
    void onConnect(BLEServer* pServer) 
    {
      estConnecte = true;
    }

    void onDisconnect(BLEServer* pServer) 
    {
      estConnecte = false;
    }
};

//===================================================================================================================

#ifdef DISPLAY_SSD1306Wire
#include "SSD1306Wire.h"

SSD1306Wire  display(0x3c, 5, 4);
void initDisplay();
void afficherMessage(String msg, int duree);
void afficherDatas(String msg, String datas, int duree);
#endif

//===================================================================================================================

void setup() 
{
  Serial.begin(115200);
  Serial.println("Test BLE init");

  #ifdef DISPLAY_SSD1306Wire
  initDisplay();

  afficherMessage("Test BLE init server", 0);
  #endif

  Serial.println("Test BLE init server");  

  BLEDevice::init("MonESP32");
  //BLEDevice::getAddress(); // Retrieve our own local BD BLEAddress
  pServer = BLEDevice::createServer();
  pServer->setCallbacks(new EtatServeur());
  
  BLEService *pService = pServer->createService(SERVICE_UUID);
  
  #ifdef NOTIFY_CHARACTERISTIC
  pCharacteristic = pService->createCharacteristic(CHARACTERISTIC_UUID,BLECharacteristic::PROPERTY_READ | BLECharacteristic::PROPERTY_WRITE  | BLECharacteristic::PROPERTY_NOTIFY | BLECharacteristic::PROPERTY_INDICATE);
  // https://www.bluetooth.com/specifications/gatt/viewer?attributeXmlFile=org.bluetooth.descriptor.gatt.client_characteristic_configuration.xml
  // Crée un descripteur : Client Characteristic Configuration (pour les indications/notifications)
  pCharacteristic->addDescriptor(new BLE2902());
  #else
  pCharacteristic = pService->createCharacteristic(CHARACTERISTIC_UUID, BLECharacteristic::PROPERTY_READ | BLECharacteristic::PROPERTY_WRITE);
  #endif

  pService->start();

  pServer->getAdvertising()->start();
  //BLEAdvertising *pAdvertising = pServer->getAdvertising();
  //pAdvertising->start();
  Serial.println("Test BLE start advertising");

  Serial.println("Test BLE wait connection");

  #ifdef DISPLAY_SSD1306Wire
  afficherMessage("Test BLE wait", 1000);
  #endif
}

void loop() 
{
  bool fini = false;

  while(!fini)
  { 
    // notification 
    if (estConnecte) 
    { 
      pCharacteristic->setValue(&valeur, 1); // la nouvelle valeur du compteur
      #ifdef NOTIFY_CHARACTERISTIC
      pCharacteristic->notify();  
      #endif      
      delay(10); // bluetooth stack will go into congestion, if too many packets are sent

      String datas(valeur);
      //Serial.println("BLE notify");
      Serial.printf("BLE notify : %d\n", valeur);
      #ifdef DISPLAY_SSD1306Wire
      afficherDatas("BLE notify", datas, 500);
      #endif
      
      valeur++; // on compte ...
    }
    // déconnecté ?
    if (!estConnecte && etaitConnecte) 
    {
      Serial.println("BLE deconnection");
      #ifdef DISPLAY_SSD1306Wire
      afficherMessage("BLE deconnecte", 500);
      #else
      delay(500); // give the bluetooth stack the chance to get things ready
      #endif
      
      pServer->startAdvertising(); // restart advertising
      Serial.println("BLE restart advertising");

      Serial.println("Test BLE wait connection");
      #ifdef DISPLAY_SSD1306Wire
      afficherMessage("Test BLE wait", 0);
      #endif
      
      etaitConnecte = estConnecte;
    }
    // connecté ?
    if (estConnecte && !etaitConnecte) 
    {
      Serial.println("BLE connection");
      #ifdef DISPLAY_SSD1306Wire
      afficherMessage("BLE connecte", 0);
      #endif
      
      etaitConnecte = estConnecte;
    }
  }
}

//===================================================================================================================

#ifdef DISPLAY_SSD1306Wire
void initDisplay()
{
  display.init();
  display.flipScreenVertically();
  display.setFont(ArialMT_Plain_10);
  display.setTextAlignment(TEXT_ALIGN_LEFT);
  display.clear();
}

void afficherMessage(String msg, int duree)
{
  //char ligne1[64];  
  //sprintf(ligne1, "%s", );
  //display.drawString(0, 10, String(ligne1));
  
  display.clear();  
  display.drawString(0, 10, msg);
  display.drawString(0, 20, "====================");  
  display.display();
  delay(duree);
}

void afficherDatas(String msg, String datas, int duree)
{  
  display.clear();  
  display.drawString(0, 10, msg);
  display.drawString(0, 20, "====================");  
  display.drawString(0, 40, datas);  
  display.display();
  delay(duree);
}

#endif

