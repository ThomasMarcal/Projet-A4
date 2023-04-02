// C++ code
//
const int buttonPin = 2;     // the number of the pushbutton pin

const int RedPin =  11;      // the number of the RED pin
const int BluePin =  10;
const int GreenPin =  9;

int sensorPin = A0;
int sensorValue = 0;

int buzzer = 6;



// variables will change:
int buttonState = 0;         // variable for reading the pushbutton status

/* Change l'état de la LED embarquée sur la carte */
void maRoutine()
{
    if(buttonState ==0){
    buttonState = 1;}
    else{
    buttonState = 0;}
    
}


void setup() {
  // initialize the LED pin as an output:
  pinMode(RedPin, OUTPUT);
  pinMode(BluePin, OUTPUT);
  pinMode(GreenPin, OUTPUT);
  pinMode(buzzer, OUTPUT);
  
  // initialize the pushbutton pin as an input:
  pinMode(buttonPin, INPUT);
  
  attachInterrupt(digitalRead(buttonPin), maRoutine, RISING);
   
}

void gauchedroite()
{
    
    sensorValue = analogRead(sensorPin); 
    
    digitalWrite(RedPin, HIGH);
    delay(sensorValue);
    digitalWrite(RedPin, LOW);
    delay(sensorValue);
    
    digitalWrite(BluePin, HIGH);
    delay(sensorValue);
    digitalWrite(BluePin, LOW);
    delay(sensorValue);
    
    digitalWrite(GreenPin, HIGH);
    delay(sensorValue);
    digitalWrite(GreenPin, LOW);
    delay(sensorValue);
  
}

void droitegauche(){
    
    sensorValue = analogRead(sensorPin); 
    
    digitalWrite(GreenPin, HIGH);
    delay(sensorValue);
    digitalWrite(GreenPin, LOW);
    delay(sensorValue);
    
    digitalWrite(BluePin, HIGH);
    delay(sensorValue);
    digitalWrite(BluePin, LOW);
    delay(sensorValue);
    
    digitalWrite(RedPin, HIGH);
    delay(sensorValue);
    digitalWrite(RedPin, LOW);
    delay(sensorValue);
}


void loop() {

  // check if the pushbutiton is pressed. If it is, the buttonState is HIGH:

  if(buttonState == 0){
    gauchedroite();
  }else{
    droitegauche();
  }
    
}  
