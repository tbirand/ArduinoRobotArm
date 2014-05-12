// Serial Robot Arm Controller
// by Turgay Birand
// This example code is in the public domain.


#include <Servo.h> 
 
Servo foot;  // create servo object to control a servo 
Servo lift;
Servo arm1;
Servo arm2;
Servo gripper;
int led = 8;
int cycles;
int commaPosition;
String str;
boolean waving = false;
boolean active = false;
boolean moving = false;
boolean grip = true;
int pos[5], to[5];
 
void setup() 
{ 
    Serial.begin(115200);
} 
 
void loop() 
{ 
  while(Serial.available()) {
    delay(2);
    if(Serial.available() > 0) {
      str += (char)Serial.read();
    }
  }
  
  if(str == "a")
    activate();
  else if(str == "d")
    deactivate();
  else if(str == "g") {
    if(grip) {
      Serial.println("Gripper open");
      gripper.write(120);
    }
    else {
      Serial.println("Gripper closed");
      gripper.write(0);
    }   
    grip = !grip;
    str = "";
  }
  else if(str.indexOf(",") > -1) {
    int k = 0;
    int j = 0;
    do
    {
      commaPosition = str.indexOf(',');
      if(commaPosition != -1)
      {
          to[k] = str.substring(0,commaPosition).toInt();
          k++;
          str = str.substring(commaPosition+1, str.length());
      }
      else
      {  // here after the last comma is found
         if(str.length() > 0) {
           to[k] = str.toInt();  // if there is text after the last comma,
           k++;
         }
      }
    }
    while(commaPosition >=0);
    
    if(k==4) {
      String vectors = "Received vectors ";
      for(int i=0;i<4;i++)
        vectors += String(to[i]) + " ";
      vectors.trim();
      Serial.println(vectors + ".");
      
      foot.write(to[0]);
      lift.write(to[1]);
      arm1.write(to[2]);
      arm2.write(to[3]);
    }
    else
      Serial.println("Invalid vectors.");
    
    str = "";
  }
  else if(str != "") {
    Serial.println("Unknown: " + str);
    str = "";
  }
} 

void activate() {
  active = true;
  Serial.println("System Active.");
  digitalWrite(led, HIGH);
  foot.attach(14);
  arm1.attach(16);
  arm2.attach(17);
  lift.attach(15);
  gripper.attach(18);
  setTo(90, 90, 60, 30, 0);
  str = "";
}

void deactivate() {
  active = false;
  grip = true;
  gripper.write(0);
  Serial.println("System Passive.");
  setTo(90, 90, 60, 30, 0);
  delay(250);
  str = "";
  foot.detach();
  arm1.detach();
  arm2.detach();
  lift.detach();
  gripper.detach();
  digitalWrite(led, LOW);
}

void setTo(int a, int b, int c, int d, int e) {
  to[0] = a;
  to[1] = b;
  to[2] = c;
  to[3] = d;
  to[4] = e;
  foot.write(to[0]);
  lift.write(to[1]);
  arm1.write(to[2]);
  arm2.write(to[3]);
  moving = true;
}
