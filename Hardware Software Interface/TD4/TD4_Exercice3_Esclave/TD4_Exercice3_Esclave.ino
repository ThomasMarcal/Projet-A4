// Include Arduino Wire library for I2C
#include <Wire.h>
 
// Define Slave I2C Address
#define SLAVE_ADDR 9

#include "LiquidCrystal_I2C.h"

LiquidCrystal_I2C LCD(0x27,16,2); // définit le type d'écran lcd 16 x 2

// Define LED Pin
// int LED = 11;
 
// Variable for received data
int rd;
 
// Variable for blink rate
int br;
 
void setup() {
 
  // pinMode(LED, OUTPUT);
   LCD.init(); // initialisation de l'afficheur
   LCD.backlight();

  // Initialize I2C communications as Slave
  Wire.begin(SLAVE_ADDR);

  // Function to run when data received from master
  Wire.onReceive(receiveEvent);

  // Setup Serial Monitor 
  Serial.begin(9600);
  Serial.println("I2C Slave Demonstration");
}
 
 
void receiveEvent() {
  // read one character from the I2C
  rd = Wire.read();
  // Print value of incoming data
  Serial.println(rd);

}
void loop() {
 
  // Calculate blink value
  Serial.println(rd);
  //br = map(rd, 1, 255, 100, 2000);
  LCD.setCursor(1, 3);
   LCD.print(rd);
  // analogWrite(LED,rd);


 
}
