#include <Wire.h>
#include <LiquidCrystal_I2C.h>
//----- Adressage matériel -----
// En cas de non fonctionnement, mettez la ligne 8 en
// commentaire et retirez le commentaire à la ligne 9.
LiquidCrystal_I2C lcd(0x27, 20, 4);
//LiquidCrystal_I2C lcd(0x3F,20,4);

int buttonPin1 = 2;
int buttonPin2 = 3;

int playState1 = 1;
int playState2 = 1;

int x = 0;
int y = 0;

void setup()
{
lcd.init(); // initialisation de l'afficheur
pinMode(buttonPin1, INPUT);
pinMode(buttonPin2, INPUT);
attachInterrupt(digitalPinToInterrupt(buttonPin1), gd, RISING);
attachInterrupt(digitalPinToInterrupt(buttonPin2), hb, RISING);

lcd.setCursor(x, y);
lcd.print("O");

}

void gd(){
    if(playState1==1)
    {
      playState1=0; 
    }
    else
    {
      playState1=1;
    }
}

void hb(){
      if(playState2==1)
    {
      playState2=0; 
    }
    else
    {
      playState2=1;
    }
}


void loop()
{
lcd.backlight();


if (playState1 == 1){
  x+=1;
  if (x == 16){
    x = 0;
  }
  lcd.clear();
  lcd.setCursor(x, y);
  lcd.print("O");
  delay(1000);
}
else{
  x-=1;
  if (x == -1){
    x = 16;
  }
  lcd.clear();
    lcd.setCursor(x, y);
  lcd.print("O");
  delay(1000);
}
if (playState2 == 1){
  y+=1;
  if (y ==2){
    y = 0;
  }
  lcd.clear();
    lcd.setCursor(x, y);
  lcd.print("O");
  delay(1000);
}
else{
  y-=1;
  if (y ==-1){
    y = 1;
  }
  lcd.clear();
    lcd.setCursor(x, y);
  lcd.print("O");
  delay(1000);
}

}
