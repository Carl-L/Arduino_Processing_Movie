#include <Adafruit_NeoPixel.h>

#define NUMPIXELS      30

int colorLedPin = 6;
int sensorPin = A0;    // select the input pin for the potentiometer
int ledPin = 13;      // select the pin for the LED
float sensorValue = 0;  // variable to store the value coming from the sensor
int ledNum = 0;
Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUMPIXELS, colorLedPin, NEO_GRB + NEO_KHZ800);

int delayval = 50; // delay for half a second

void setup() {
  // declare the ledPin as an OUTPUT:
  //pinMode(colorLedPin, OUTPUT);
  pixels.begin();
  Serial.begin(9600);
}

void loop() {
  // read the value from the sensor:
  sensorValue = analogRead(sensorPin);
  Serial.println(sensorValue);
  ledNum = 1.0 * sensorValue / 1024 * 30;
  //in
  // pixels.Color takes RGB values, from 0,0,0 up to 255,255,255
  for (int i=0;i<NUMPIXELS;i++) {
    if (((int)(ledNum)) == i)
      pixels.setPixelColor(i, pixels.Color(0,150,0)); // Moderately bright green color.
    else
      pixels.setPixelColor(i, pixels.Color(0,0,0));
  }
  pixels.show(); // This sends the updated pixel color to the hardware.

  delay(delayval); // Delay for a period of time (in milliseconds).
  // turn the ledPin on
  //digitalWrite(ledPin, HIGH);  
  // stop the program for <sensorValue> milliseconds:
  //delay(sensorValue);          
  // turn the ledPin off:        
  //digitalWrite(ledPin, LOW);   
  // stop the program for for <sensorValue> milliseconds:
  //delay(sensorValue);
}
