int trigPin = 9;    // TRIG pin
int echoPin = 8;    // ECHO pin

float duration_us, distance_cm;

int latchPin = 5;	// Latch pin of 74HC595 is connected to Digital pin 5
int clockPin = 6;	// Clock pin of 74HC595 is connected to Digital pin 6
int dataPin = 4;	// Data pin of 74HC595 is connected to Digital pin 4

byte leds = 0;		// Variable to hold the pattern of which LEDs are currently turned on or off

int buzzer = 2;

void setup() {
  // begin serial port
  Serial.begin (9600);

  // configure the trigger pin to output mode
  pinMode(trigPin, OUTPUT);
  // configure the echo pin to input mode
  pinMode(echoPin, INPUT);
    // Set all the pins of 74HC595 as OUTPUT
  pinMode(latchPin, OUTPUT);
  pinMode(dataPin, OUTPUT);  
  pinMode(clockPin, OUTPUT);
}

void loop() {
  // generate 10-microsecond pulse to TRIG pin
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  // measure duration of pulse from ECHO pin
  duration_us = pulseIn(echoPin, HIGH);

  // calculate the distance
  distance_cm = 0.017 * duration_us;

  // print the value to Serial Monitor
  Serial.print("distance: ");
  Serial.print(distance_cm);
  Serial.println(" cm");

  tone(buzzer,distance_cm);
  
  leds = 0;	// Initially turns all the LEDs off, by giving the variable 'leds' the value 0
  updateShiftRegister();
  
  if (distance_cm<2)	// Turn all the LEDs ON one by one.
  {
    bitSet(leds, 2);		// Set the bit that controls that LED in the variable 'leds'
    updateShiftRegister();
    
  }
  else
  {
    if (distance_cm<5)	// Turn all the LEDs ON one by one.
  {
    for (int i = 0; i < 3; i++)	// Turn all the LEDs ON one by one.
  {
    bitSet(leds, i);		// Set the bit that controls that LED in the variable 'leds'
    updateShiftRegister();
    
  }
    
  }
    else
    {
      if (distance_cm<7)	// Turn all the LEDs ON one by one.
      {
          for (int i = 0; i < 4; i++)	// Turn all the LEDs ON one by one.
          {
            bitSet(leds, i);		// Set the bit that controls that LED in the variable 'leds'
            updateShiftRegister();
            
          }
          
      }
      else
      {
        if (distance_cm<9)	// Turn all the LEDs ON one by one.
      {
        
          for (int i = 0; i < 5; i++)	// Turn all the LEDs ON one by one.
          {
            bitSet(leds, i);		// Set the bit that controls that LED in the variable 'leds'
            updateShiftRegister();
            
          }
          
      }
      else
      {
        if (distance_cm<11)	// Turn all the LEDs ON one by one.
      {
          
          for (int i = 0; i < 6; i++)	// Turn all the LEDs ON one by one.
          {
            bitSet(leds, i);		// Set the bit that controls that LED in the variable 'leds'
            updateShiftRegister();
            
          }
          
      }
      else
      {
         if (distance_cm<13) // Turn all the LEDs ON one by one.
      {
          for (int i = 0; i < 7; i++)	// Turn all the LEDs ON one by one.
          {
            bitSet(leds, i);		// Set the bit that controls that LED in the variable 'leds'
            updateShiftRegister();
            
          }
      }   
      else{
          for (int i = 0; i < 8; i++)  // Turn all the LEDs ON one by one.
          {
            bitSet(leds, i);    // Set the bit that controls that LED in the variable 'leds'
            updateShiftRegister();
            
          }
      }
      }
      }
      }
    }
  }


  delay(500);
}

void updateShiftRegister()
{
   digitalWrite(latchPin, LOW);
   shiftOut(dataPin, clockPin, LSBFIRST, leds);
   digitalWrite(latchPin, HIGH);
}
