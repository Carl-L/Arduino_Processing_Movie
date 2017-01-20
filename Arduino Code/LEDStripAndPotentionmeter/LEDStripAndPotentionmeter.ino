#include <Adafruit_NeoPixel.h>

#define NUMPIXELS      30

// use array to store potentionmeter node
// the value should be adjusted by the device
float positionNodeVal[] = {
                      0, // 0
                      42.7, // movie clip 1
                      85.3, // movie clip 2
                      128.0, // movie clip 3
                      170.7, // movie clip 4
                      213.3, // movie clip 5
                      256.0, // movie clip 6
                      298.7, // movie clip 7
                      341.3, // movie clip 8
                      384.0, // movie clip 9 
                      426.7,
                      469.3,
                      1024.0              
                    };
                    
int colorLedPin = 6;
int sensorPin = A0;    // select the input pin for the potentiometer
int ledPin = 13;      // select the pin for the LED
float sensorValue = 0;  // variable to store the value coming from the sensor
int ledNum = 0;
Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUMPIXELS, colorLedPin, NEO_GRB + NEO_KHZ800);

int delayval = 50; // delay for half a second

int getMovieClipNum(float sensorVal)
{
  for (int i = 0; i < sizeof(positionNodeVal)/sizeof(positionNodeVal[0]); i++)
  {
    if (sensorVal > positionNodeVal[i] && sensorVal < positionNodeVal[i+1])
    {
      return i;
    }
  }
  return 0; // default value : 0
}

void setup() {
  // declare the ledPin as an OUTPUT:
  //pinMode(colorLedPin, OUTPUT);
  pixels.begin();
  Serial.begin(9600);
}

void loop() {
  // read the value from the sensor:
  sensorValue = analogRead(sensorPin);
  int movieClipNum = getMovieClipNum(sensorValue);
  char strToProcessing[3];
  sprintf(strToProcessing,"%d",movieClipNum);
  //Serial.println(sensorValue);
  Serial.print(movieClipNum);
  Serial.print('\n');
  ledNum = 1.0 * sensorValue / 1024 * 30;
  //in
  // pixels.Color takes RGB values, from 0,0,0 up to 255,255,255
  for (int i=0;i<NUMPIXELS;i++) {
    if (((int)(ledNum)) == i)
      pixels.setPixelColor(i, pixels.Color(0,50,0)); // Moderately bright green color.
    else
      pixels.setPixelColor(i, pixels.Color(0,0,0));
  }
  pixels.show(); // This sends the updated pixel color to the hardware.

  delay(delayval); // Delay for a period of time (in milliseconds).
}

