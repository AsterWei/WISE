#include <RFduinoGZLL.h>
#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BNO055.h>
#include <utility/imumaths.h>
device_t role = DEVICE4;
/* This driver reads raw data from the BNO055

   Connections
   ===========
   Connect SCL to GPIO 5
   Connect SDA to GPIO 6
   Connect VDD to 3.3V DC
   Connect GROUND to common ground
*/

/* Set the delay between fresh samples */
String final="";
//char mydata[18];
//#define BNO055_SAMPLERATE_DELAY_MS (10)
Adafruit_BNO055 bno = Adafruit_BNO055(1,0x28);

void setup()
{
  RFduinoGZLL.begin(role);
  RFduinoGZLL.txPowerLevel=4;
  Serial.begin(115200);
  pinMode(3,OUTPUT);
  if(!(bno.begin()))
  {
    /* There was a problem detecting the BNO055 ... check your connections */
//    Serial.print("Ooops, no BNO055_0 and 1 detected ... Check your wiring or I2C ADDR!");
    while(1);
  }
  delay(1000);
//  int8_t temp = bno.getTemp();
  bno.setExtCrystalUse(true);
}

void loop()
{
digitalWrite(3,LOW);
imu::Quaternion quat = bno.getQuat();
double w = quat.w();
double x = quat.x();
double y = quat.y();
double z = quat.z();
Serial.print(w);Serial.print(", ");Serial.print(x);Serial.print(", ");Serial.print(y);Serial.print(", ");Serial.println(z);

}