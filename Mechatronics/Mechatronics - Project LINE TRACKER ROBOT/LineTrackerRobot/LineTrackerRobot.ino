// Code by : MARCAL Thomas

// ---------------------------------------------------------

// Project Mechatronics 

// Line Tracker Robot
// +  Obstacle detection and avoidance
// +  Control of the car via bluetooth module


// ---------------------------------------------------------
// ---------------------------------------------------------
// ---------------------------------------------------------

// LCD screen
#include <Wire.h>
#include <LiquidCrystal_I2C.h>
LiquidCrystal_I2C lcd(0x27, 20, 4); // 0x27 LCD screen with 20 columns and 4 rows


// ---------------------------------------------------------

// BLUETOOTH
#include <SoftwareSerial.h>
SoftwareSerial hc06(12,13); // Create a software serial port and assign the pins for TX and RX


// ---------------------------------------------------------

// Define strings

String cmd= "";
String mode = "PILOTAGE";

// ---------------------------------------------------------

// Control Motors 

// MOTORS
#define enA 10//Enable1 L298 Pin enA 
#define in1 9 //Motor1  L298 Pin in1 
#define in2 8 //Motor1  L298 Pin in2 
#define in3 7 //Motor2  L298 Pin in3
#define in4 6 //Motor2  L298 Pin in4
#define enB 5 //Enable2 L298 Pin enB 

// SENSORS
#define R_S A0 //ir sensor Right
#define L_S A1 //ir sensor Left

// CONST
int ValueR;
int ValueL;

// ---------------------------------------------------------

// Define custom characters for the LCD

byte FAHG[8] = {
  0b00001,
  0b00011,
  0b00111,
  0b01111,
  0b11111,
  0b11111,
  0b11111,
  0b00111
};
byte FAHD[8] = {
  0b10000,
  0b11000,
  0b11100,
  0b11110,
  0b11111,
  0b11111,
  0b11111,
  0b11100
};
byte FABD[8] = {
  0b11100,
  0b11100,
  0b11100,
  0b11100,
  0b11100,
  0b11100,
  0b11100,
  0b11100
};
byte FABG[8] = {
  0b00111,
  0b00111,
  0b00111,
  0b00111,
  0b00111,
  0b00111,
  0b00111,
  0b00111
};
byte FArBG[8] = {
  0b00111,
  0b11111,
  0b11111,
  0b11111,
  0b01111,
  0b00111,
  0b00011,
  0b00001
};
byte FArBD[8] = {
  0b11100,
  0b11111,
  0b11111,
  0b11111,
  0b11110,
  0b11100,
  0b11000,
  0b10000
};
byte FDBD[8] = {
  0b11111,
  0b11111,
  0b11110,
  0b11100,
  0b11000,
  0b10000,
  0b00000,
  0b00000
};
byte FDHD[8] = {
  0b00000,
  0b00000,
  0b10000,
  0b11000,
  0b11100,
  0b11110,
  0b11111,
  0b11111
};
byte FDHG[8] = {
  0b00000,
  0b00000,
  0b00000,
  0b00000,
  0b00000,
  0b11111,
  0b11111,
  0b11111
};
byte FDBG[8] = {
  0b11111,
  0b11111,
  0b11111,
  0b00000,
  0b00000,
  0b00000,
  0b00000,
  0b00000
};
byte FGHG[8] = {
  0b00000,
  0b00000,
  0b00001,
  0b00011,
  0b00111,
  0b01111,
  0b11111,
  0b11111
};
byte FGBG[8] = {
  0b11111,
  0b11111,
  0b01111,
  0b00111,
  0b00011,
  0b00001,
  0b00000,
  0b00000
};
byte CarreBas[8] = {
  0b11111,
  0b11111,
  0b11111,
  0b11111,
  0b11111,
  0b00000,
  0b00000,
  0b00000
};
byte CarreHaut[8] = {
  0b00000,
  0b00000,
  0b00000,
  0b11111,
  0b11111,
  0b11111,
  0b11111,
  0b11111
};

// ---------------------------------------------------------

// Ultrasonic sensor to avoid obstacles

const byte TRIGGER_PIN = 3; // Broche TRIGGER
const byte ECHO_PIN = 2;    // Broche ECHO
 
const unsigned long MEASURE_TIMEOUT = 25000UL; // 25ms = ~8m à 340m/s

/* Speed of sound in air in mm/us */
const float SOUND_SPEED = 340.0 / 1000;


// ---------------------------------------------------------

void setup(){ // SETUP CODE

  // Pin initialization
  // Sensors
  pinMode(R_S, INPUT); 
  pinMode(L_S, INPUT);
  // Motors
  pinMode(enA, OUTPUT); // declare as output for L298 Pin enA 
  pinMode(in1, OUTPUT); // declare as output for L298 Pin in1 
  pinMode(in2, OUTPUT); // declare as output for L298 Pin in2 
  pinMode(in3, OUTPUT); // declare as output for L298 Pin in3   
  pinMode(in4, OUTPUT); // declare as output for L298 Pin in4 
  pinMode(enB, OUTPUT); // declare as output for L298 Pin enB 
  // Ultrasonic sensor
  pinMode(TRIGGER_PIN, OUTPUT);
  digitalWrite(TRIGGER_PIN, LOW); // The TRIGGER pin must be at LOW when not in use
  pinMode(ECHO_PIN, INPUT);
  
  // SETUP motor speed in 0
  analogWrite(enA, 0); // Write The Duty Cycle 0 to 255 Enable Pin A for Motor1 Speed 
  analogWrite(enB, 0); // Write The Duty Cycle 0 to 255 Enable Pin B for Motor2 Speed 

  // SETUP display on the LCD screen
  lcd.init(); // Initialization of the LCD screen
  lcd.cursor_on();
  lcd.blink_on();
  lcd.backlight();
  lcd.setCursor(0,0); 
  lcd.print("Mechatronic Project");
  lcd.setCursor(0,1); 
  lcd.print("Line Tracker Robot");
  lcd.setCursor(0,2); 
  lcd.print("+ Control Bluetooth");
  lcd.setCursor(0,3); 
  lcd.print("+ Obstacle Detection");
  delay(6000);
  lcd.clear();
  delay(500);

  // Preparation of the communication with the Bluetooth module
  hc06.begin(9600);
  // Serial.begin(9600);
}


// ---------------------------------------------------------

void loop() { // LOOP Code
  
// Communication with the Bluetooth module
  while(hc06.available()>0){
    cmd += (char)hc06.read();
  }

// OBSTACLE DETECTION
  // Start a distance measurement by sending a 10µs HIGH pulse on the TRIGGER pin 
  digitalWrite(TRIGGER_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIGGER_PIN, LOW);
  // Measures the time between the sending of the ultrasonic pulse and its echo (if it exists)
  long measure = pulseIn(ECHO_PIN, HIGH, MEASURE_TIMEOUT);
  // Calculates the distance from the measured time
  float distance = measure / 2.0 * SOUND_SPEED;

  lcd.setCursor(0,2); 
  lcd.print(distance);

// MODE OF THE CAR
  if (cmd != ""){
    if (cmd == "pilotage") {
      mode = "PILOTAGE";
    }
    else if (cmd == "suiveur") {
      mode = "SUIVEUR";
    }
  }

// Mode "PILOTAGE"
  if (mode == "PILOTAGE") {
    lcd.setCursor(0,3); 
    lcd.print("Mode : Pilotage");
    // Depending on the command sent the car moves 
    if(cmd!=""){
      if (distance < 150){ // If there is an obstacle in front of us we can't move forward
        if(cmd=="arriere"){ 
          AffichageFlecheArriere();
          backwards();
        }
        if(cmd=="droite"){  
          AffichageFlecheDroite();
          turnRight();
        }
        if(cmd=="gauche"){
          AffichageFlecheGauche();
          turnLeft();
        }
        if(cmd=="stop"){ 
          AffichageStop();
          Stop();
        }
      }
      else{
        if(cmd=="avant"){
          AffichageFlecheAvant();
          forward();
        }
        if(cmd=="arriere"){ 
          AffichageFlecheArriere();
          backwards();
        }
        if(cmd=="droite"){  
          AffichageFlecheDroite();
          turnRight();
        }
        if(cmd=="gauche"){
          AffichageFlecheGauche();
          turnLeft();
        }
        if(cmd=="stop"){ 
          AffichageStop();
          Stop();
        }
      }
      cmd=""; //reset cmd
    }
    delay(100);
  }
  // Mode "SUIVEUR"
  else if (mode == "SUIVEUR") {
    lcd.setCursor(0,3); 
    lcd.print("Mode : Suiveur");

    if(distance <= 150) { // If an obstacle is detected, the robot goes around it
      Stop();
      delay(100);
      turnRight();
      delay(1300);
      forward();
      delay(600);
      turnLeft();
      delay(1500);
      forward();
      delay(1100);
      turnLeft();
      delay(700);
      forward();
      delay(300);
    }

    int sensorValueR = analogRead(R_S);
    int sensorValueL = analogRead(L_S);

    if (sensorValueR > 100){
      ValueR = 1;
    }
    else {
      ValueR = 0;
    }
    if (sensorValueL > 100){
      ValueL = 1;
    }
    else {
      ValueL = 0;
    }

    //Serial.println(sensorValueR);
    //Serial.println(sensorValueL);
  
    if((ValueR == 0)&&(ValueL == 0)) { // If the sensors are on black
      AffichageFlecheAvant();
      forward(); // Go straight ahead
    }
    else if((ValueR == 1)&&(ValueL == 0)) { // If right sensor on white and left sensor on black
      AffichageFlecheDroite();
      turnRight(); // Turn to the right
    }
    else if((ValueR == 0)&&(ValueL == 1)) { // If right sensor on black and left sensor on white
      AffichageFlecheGauche();
      turnLeft(); // Turn to the left
    }
    else if((ValueR == 1)&&(ValueL == 1)) { // If the sensors are on white
      AffichageStop();
      Stop(); // Stop
    }
    
    if (cmd != ""){
      cmd=""; //reset cmd
    }
    delay(100);
  }
  
  delay(200);
  lcd.clear();
  
}


// ---------------------------------------------------------

// Functions used
void forward(){  // Allows the car to move forward
analogWrite(enA, 60);
analogWrite(enB, 60);
digitalWrite(in1, LOW);
digitalWrite(in2, HIGH);
digitalWrite(in3, LOW);
digitalWrite(in4, HIGH);
}

void backwards(){  // Allows the car to move backwards
analogWrite(enA, 60);
analogWrite(enB, 60);
digitalWrite(in1, HIGH); 
digitalWrite(in2, LOW); 
digitalWrite(in3, HIGH); 
digitalWrite(in4, LOW); 
}

void turnRight(){ // Allows the car to turn right
analogWrite(enA, 90);
analogWrite(enB, 60);
digitalWrite(in1, LOW);
digitalWrite(in2, HIGH);
digitalWrite(in3, HIGH); 
digitalWrite(in4, LOW);
}

void turnLeft(){ // Allows the car to turn left
analogWrite(enA, 60);
analogWrite(enB, 90);
digitalWrite(in1, HIGH); 
digitalWrite(in2, LOW);  
digitalWrite(in3, LOW);
digitalWrite(in4, HIGH); 
}

void Stop(){ // Allows the car to stop
analogWrite(enA, 0); 
analogWrite(enB, 0); 
digitalWrite(in1, LOW); 
digitalWrite(in2, LOW); 
digitalWrite(in3, LOW); 
digitalWrite(in4, LOW); 
}


// Arrow display 
void AffichageFlecheAvant(){
  lcd.createChar(0, FAHG);
  lcd.createChar(1, FAHD);
  lcd.createChar(2, FABG);
  lcd.createChar(3, FABD);
  lcd.setCursor(0,0); 
  lcd.write((byte)0);
  lcd.setCursor(0,1); 
  lcd.write((byte)2);
  lcd.setCursor(1,0); 
  lcd.write((byte)1);
  lcd.setCursor(1,1); 
  lcd.write((byte)3);
}
void AffichageFlecheArriere(){
  lcd.createChar(0, FABG);
  lcd.createChar(1, FABD);
  lcd.createChar(2, FArBG);
  lcd.createChar(3, FArBD);
  lcd.setCursor(0,0); 
  lcd.write((byte)0);
  lcd.setCursor(0,1); 
  lcd.write((byte)2);
  lcd.setCursor(1,0); 
  lcd.write((byte)1);
  lcd.setCursor(1,1); 
  lcd.write((byte)3);
}
void AffichageFlecheDroite(){
  lcd.createChar(0, FDHG);
  lcd.createChar(1, FDHD);
  lcd.createChar(2, FDBG);
  lcd.createChar(3, FDBD);
  lcd.setCursor(0,0); 
  lcd.write((byte)0);
  lcd.setCursor(0,1); 
  lcd.write((byte)2);
  lcd.setCursor(1,0); 
  lcd.write((byte)1);
  lcd.setCursor(1,1); 
  lcd.write((byte)3);
}
void AffichageFlecheGauche(){
  lcd.createChar(0, FGHG);
  lcd.createChar(1, FDHG);
  lcd.createChar(2, FGBG);
  lcd.createChar(3, FDBG);
  lcd.setCursor(0,0); 
  lcd.write((byte)0);
  lcd.setCursor(0,1); 
  lcd.write((byte)2);
  lcd.setCursor(1,0); 
  lcd.write((byte)1);
  lcd.setCursor(1,1); 
  lcd.write((byte)3);
}
void AffichageStop(){
  lcd.createChar(0, CarreHaut);
  lcd.createChar(1, CarreHaut);
  lcd.createChar(2, CarreBas);
  lcd.createChar(3, CarreBas);
  lcd.setCursor(0,0); 
  lcd.write((byte)0);
  lcd.setCursor(0,1); 
  lcd.write((byte)2);
  lcd.setCursor(1,0); 
  lcd.write((byte)1);
  lcd.setCursor(1,1); 
  lcd.write((byte)3);
}

// END OF THE CODE
