// C++ code
//
#include <LiquidCrystal_I2C.h>

int seconds = 0;

float temp;
int tempPin = A0;

int lum;
const int pResistor = A1;

int trigPin = 9;    // TRIG pin
int echoPin = 8;    // ECHO pin
float duration_us, distance_cm;

int buzzer = 2;

LiquidCrystal_I2C lcd(0x27, 20, 4);

void setup()
{

   pinMode(pResistor, INPUT);// Set pResistor - A0 pin as an input (optional)
  // configure the trigger pin to output mode
  pinMode(trigPin, OUTPUT);
  digitalWrite(trigPin, LOW); // La broche TRIGGER doit être à LOW au repos
  // configure the echo pin to input mode
  pinMode(echoPin, INPUT);
  
  lcd.init(); // initialisation de l'afficheur
  
  Serial.begin(9600);

}

void loop()
{

  lcd.backlight();
  lcd.clear();
  
  lum = analogRead(pResistor);

   temp = analogRead(tempPin);
   // read analog volt from sensor and save to variable temp
   temp = temp * 0.13;

  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  // Sets the trigPin on HIGH state for 10 micro seconds
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  //  // Reads the echoPin, returns the sound wave travel time in microseconds

   // measure duration of pulse from ECHO pin
   duration_us = pulseIn(echoPin, HIGH);
   // calculate the distance
   distance_cm = 0.017 * duration_us;

  tone(buzzer,distance_cm);
  
   
   lcd.setCursor(0, 0);
   lcd.print("Lum=");
   lcd.setCursor(4, 0);
   lcd.print(lum);
   
   lcd.setCursor(9, 0);
   lcd.print("T=");
   lcd.setCursor(11, 0);
   lcd.print(temp,1);
   lcd.setCursor(15, 0);
   lcd.print("C");

   lcd.setCursor(0, 1);
   lcd.print("Dis=");
   lcd.setCursor(4, 1);
   lcd.print(distance_cm);

   delay(1000); // update sensor reading each one second
}
