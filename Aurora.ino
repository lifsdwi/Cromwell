int l = 6;     
int r = 9;
int d = 10;
int j =11;               
void setup() {
  pinMode(l, INPUT);
  pinMode(r,INPUT);
 pinMode(d,INPUT);
 pinMode(j,INPUT);             
  Serial.begin(9600);                    
}

void loop() {
  int l =digitalRead(6);
int r =digitalRead(9);
int d =digitalRead(10);
  int j =digitalRead(11);
  if (l == HIGH) {  
    Serial.write(0);  }
                 
    if (r == HIGH) {  
    Serial.write(1);  }   
      if (d == HIGH) {  
    Serial.write(8);  }                         
     if (j == HIGH) {  
    Serial.write(9);  }  
  delay(100);                            
}


