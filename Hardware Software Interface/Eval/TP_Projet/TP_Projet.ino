#include <LiquidCrystal_I2C.h>
#include <Servo.h>

LiquidCrystal_I2C lcd(0x27, 20, 4);

int buttonH = 2; // Higher
int buttonL = 3; // Lower

int gear = 0;

int pot = 0;
int vitesse = 0;
int acceleration = 0;
int acceleration_map = 0;

Servo myservo;


int IntervalleVitesse[7][2] = { { 0, 3 },
                       { 3, 10 },
                       { 10, 20 },
                       { 20, 30 },
                       { 30, 40 },
                       { 40, 50 },
                       { 50, 60 }};


byte flecheBas[8] = {
  0b00100,
  0b00100,
  0b00100,
  0b00100,
  0b11111,
  0b11111,
  0b01110,
  0b00100
};

byte flecheHaut[8] = {
  0b00100,
  0b01110,
  0b11111,
  0b11111,
  0b00100,
  0b00100,
  0b00100,
  0b00100
};

void setup() {
  // put your setup code here, to run once:

  myservo.attach(9);

  pinMode(buttonH,INPUT);
  pinMode(buttonL,INPUT);
  
  attachInterrupt(digitalPinToInterrupt(buttonH),changeGearH, RISING);
  attachInterrupt(digitalPinToInterrupt(buttonL),changeGearL, RISING);

  lcd.init(); // initialisation de l'afficheur

  lcd.createChar(0, flecheBas); // create a new custom character
  lcd.createChar(1, flecheHaut); // create a new custom character
  
  Serial.begin(9600);
  
}

void loop() {
  // put your main code here, to run repeatedly:
    
  myservo.write(gear*30);

  acceleration = analogRead(pot);
  acceleration_map = map(acceleration, 0, 880, -10, 10);
  
  if (vitesse+acceleration_map >= 60){
    vitesse = 60;
  }
  else if (vitesse+acceleration_map <= 0){
    vitesse = 0;
  }
  else{
    vitesse += acceleration_map;
  }

  // Question 6
  if (vitesse + acceleration_map > IntervalleVitesse[gear][1]){
    vitesse = IntervalleVitesse[gear][1];
  }

  
  
  lcd.clear();
  lcd.backlight();

  lcd.setCursor(0, 1);
  lcd.print("G");

  lcd.setCursor(0, 0);
  lcd.print("A");

  lcd.setCursor(10, 0);
  lcd.print("V");
  
  lcd.setCursor(1, 1);
  lcd.print(gear);

  lcd.setCursor(1, 0);
  lcd.print(acceleration_map);

  lcd.setCursor(11, 0);
  lcd.print(vitesse);

  lcd.setCursor(5, 1);

  if (vitesse < IntervalleVitesse[gear][0]){
    lcd.write((byte)1);
  }
  else if (vitesse > IntervalleVitesse[gear][1]){
    lcd.write((byte)0);
  }
  else{
    lcd.print(" ");
  }

  delay(1000);
}

void changeGearL(){
  if (gear > 0){
    gear = gear-1; 
    Serial.println(gear);
  }
}

void changeGearH(){
  if (gear < 6){
    gear = gear+1; 
    Serial.println(gear);
  }
}
