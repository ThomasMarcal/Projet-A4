/*
  Ultrasonic Sensor HC-SR04 and Arduino Tutorial

  by Dejan Nedelkovski,
  www.HowToMechatronics.com

*/
// defines pins numbers
const int trigPin = 9;
const int echoPin = 10;


int ledR2 = 8;
int ledR1 = 7;

int ledG2 = 6;
int ledG1 = 5;

int ledB2 = 4;
int ledB1 = 3;


// defines variables
long duration;
int distance;

void setup() {
  pinMode(trigPin, OUTPUT); // Sets the trigPin as an Output
  pinMode(echoPin, INPUT); // Sets the echoPin as an Input
  Serial.begin(9600); // Starts the serial communication
}

void loop() {
  // Clears the trigPin

  
digitalWrite(trigPin, LOW);
delayMicroseconds(2);
// Sets the trigPin on HIGH state for 10 micro seconds
digitalWrite(trigPin, HIGH);
delayMicroseconds(10);
digitalWrite(trigPin, LOW);
//  // Reads the echoPin, returns the sound wave travel time in microseconds


  duration = pulseIn(echoPin, HIGH);
  // Calculating the distance
  distance = duration * 0.034 / 2;
  // Prints the distance on the Serial Monitor
  Serial.print("Distance: ");
  Serial.println(distance);

  if (distance < 10){
    analogWrite(ledR2, LOW);
    analogWrite(ledB1, HIGH);
  }
  else if (distance < 20){
        analogWrite(ledB1, LOW);
        analogWrite(ledB2, HIGH);
  }
  else if (distance < 30){
        analogWrite(ledB2, LOW);
        analogWrite(ledG1, HIGH);
  }
    else if (distance < 40){
        analogWrite(ledG1, LOW);
        analogWrite(ledG2, HIGH);
  }
      else if (distance < 50){
        analogWrite(ledG2, LOW);
        analogWrite(ledR1, HIGH);
  }
  else{
        analogWrite(ledR1, LOW);
        analogWrite(ledR2, HIGH);
  }
  
  
}
