const int moteur = 12;
const int button = 2;
int playState = 1;

void setup() {                
  pinMode(moteur, OUTPUT);  
  pinMode(button, INPUT);  
  attachInterrupt(digitalPinToInterrupt(button), Button, RISING);
  Serial.begin(9600);
}


void Button()
{
  if(playState==1)
    {
      playState=0;
    }
    else
    {
      playState=1;
    }
}

void acceleration(){
   for (int i = 100 ; i <= 255 and playState == 0; i++)
      {
          //envoyer la valeur de 0 à 255
          analogWrite(moteur, i);
          // attendre 10 millisecondes pour donner le temps de réaliser l'accélération
          delay(50);
          Serial.println(i);
        while (i >= 255 && playState == 0)
        {
          analogWrite(moteur, 255);
          //Serial.println(i);
          delay(50);
        }}
}
   
void desacceleration(){
   for (int i = 255 ; i >= 100 and playState == 1; i--)
      {
          //envoyer la valeur de 0 à 255
          analogWrite(moteur, i);
          // attendre 10 millisecondes pour donner le temps de réaliser l'accélération
          delay(50);
          Serial.println(i);
          while (i <= 100 && playState == 1)
        {
          analogWrite(moteur, 100);
          //Serial.println(i);
            delay(50);
        }}
       
}

void loop() {
  
    if (playState == 0){  
      //Serial.print(1);
      acceleration();

    }
    else{
      //Serial.print(0);
      desacceleration();

    }          
     
} 
