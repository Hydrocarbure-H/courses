//===================================================================================================================
//
//===================================================================================================================

#include <BLEDevice.h>
#include <BLEUtils.h>
#include <BLEServer.h>
#include <BLE2902.h>

#define SERVICE_UART_UUID      "6E400001-B5A3-F393-E0A9-E50E24DCCA9E" // UART service UUID
#define CHARACTERISTIC_UUID_RX "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"
#define CHARACTERISTIC_UUID_TX "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"

BLEServer* pServer = NULL;
BLECharacteristic* pTxCharacteristic = NULL;
BLECharacteristic* pRxCharacteristic = NULL;

bool estConnecte = false;
bool etaitConnecte = false;
uint8_t valeur = 0;

//===================================================================================================================

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

class CharacteristicUART : public BLECharacteristicCallbacks 
{
    void onWrite(BLECharacteristic *pCharacteristique) 
    {
      std::string rxValue = pCharacteristique->getValue();

      if (rxValue.length() > 0) 
      {
        Serial.println("*********");
        Serial.print("Received Value: ");
        for (int i = 0; i < rxValue.length(); i++)
          Serial.print(rxValue[i]);
        Serial.println();
        Serial.println("*********");
      }
    }
};

//===================================================================================================================

void setup() 
{
  Serial.begin(115200);
  Serial.println("UART Over BLE init");
  
  BLEDevice::init("MonESP32");
  //BLEDevice::getAddress(); // Retrieve our own local BD BLEAddress
  pServer = BLEDevice::createServer();
  pServer->setCallbacks(new EtatServeur());
  
  BLEService *pServiceUART = pServer->createService(SERVICE_UART_UUID);
  pTxCharacteristic = pServiceUART->createCharacteristic(CHARACTERISTIC_UUID_TX, BLECharacteristic::PROPERTY_NOTIFY);
  // Create a BLE Descriptor : Client Characteristic Configuration (for indications/notifications)
  pTxCharacteristic->addDescriptor(new BLE2902());
  pRxCharacteristic = pServiceUART->createCharacteristic(CHARACTERISTIC_UUID_RX, BLECharacteristic::PROPERTY_WRITE);
  pRxCharacteristic->setCallbacks(new CharacteristicUART());
  
  pServiceUART->start();

  pServer->getAdvertising()->start();
  //BLEAdvertising *pAdvertising = pServer->getAdvertising();
  //pAdvertising->start();
  Serial.println("UART Over BLE start advertising");

  Serial.println("UART Over BLE wait connection");
}

//===================================================================================================================

void loop() 
{
  bool fini = false;

  while(!fini)
  { 
    // notification 
    if (estConnecte) 
    {
      String datas(valeur);      
      pTxCharacteristic->setValue(&valeur, 1);
      pTxCharacteristic->notify();        
      delay(10); // bluetooth stack will go into congestion, if too many packets are sent
      valeur++;
    }
    // déconnecté ?
    if (!estConnecte && etaitConnecte) 
    {
      Serial.println("UART Over BLE deconnection");      
      delay(500); // give the bluetooth stack the chance to get things ready      
      pServer->startAdvertising(); // restart advertising
      Serial.println("UART Over BLE restart advertising");      
      etaitConnecte = estConnecte;
    }
    // connecté ?
    if (estConnecte && !etaitConnecte) 
    {
      Serial.println("UART Over BLE connection");      
      etaitConnecte = estConnecte;
    }
  }
}

