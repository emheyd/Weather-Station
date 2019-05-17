// Weather station
// Emad Heydari
// 2019-05-01
// v2


#include "DHT.h"
// #include "Wire.h"
// #include "Adafruit_Sensor.h"
// #include "Adafruit_BMP280.h"



#define DHTPIN A1 // arduino pin to connect data
#define DHTTYPE DHT11 // define the sensor number

DHT dht(DHTPIN,DHTTYPE);
//Adafruit_BMP280 bmp;



void setup() 
{

  Serial.begin(9600); // start the door
  dht.begin(); //calling dht
//  bmp.begin(); //calling bmp
}

void loop() 
{
  float h = dht.readHumidity(); // read the humidity value
  float t = dht.readTemperature(); // read the temperature value
//  float p = bmp.readPressure(); // read the pressure value


  Serial.print(h,0); // print the humidity value 
  Serial.print(".");
  Serial.print(t,0); //print the temperature value
  Serial.print(".");
//  Serial.print((p/101325,2)*10 ,2);
  Serial.println();

  delay(3000);

}
