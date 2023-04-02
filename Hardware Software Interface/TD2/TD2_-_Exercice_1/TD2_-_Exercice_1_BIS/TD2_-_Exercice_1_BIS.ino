// C++ code
//

int ledRed = 11;
int ledBlue = 10;
int ledGreen = 9;

int potentiometre = A0;

int button = 2;

int val = 0;
int buttonState = 0;
  

int buzzer = 6;



void setup()
{
  pinMode(ledRed, OUTPUT);
  pinMode(ledBlue, OUTPUT);
  pinMode(ledGreen, OUTPUT);
  
  pinMode(buzzer, OUTPUT);
  
}

void loop()
{
  val = analogRead(potentiometre);
  buttonState = digitalRead(button);
  
  if (buttonState == HIGH) {
    tone(buzzer, 1000); // Send 1KHz sound signal...
    delay(1000);        // ...for 1 sec
    noTone(buzzer);     // Stop sound...
  }
  
  if (buttonState == HIGH) {
    
    digitalWrite(ledGreen, LOW);
    digitalWrite(ledRed, HIGH);
    delay(val);
    digitalWrite(ledRed, LOW);
    digitalWrite(ledBlue, HIGH);
    delay(val);
    digitalWrite(ledBlue, LOW);
    digitalWrite(ledGreen, HIGH);
    delay(val);
    
  } else {
    
    digitalWrite(ledRed, LOW);
    digitalWrite(ledGreen, HIGH);
    delay(val);
    digitalWrite(ledGreen, LOW);
    digitalWrite(ledBlue, HIGH);
    delay(val);
    digitalWrite(ledBlue, LOW);
    digitalWrite(ledRed, HIGH);
    delay(val);
  }
  

}
