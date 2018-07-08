import ddf.minim.*;
import ddf.minim.analysis.*;

import processing.serial.*;

Minim minim;
AudioPlayer kingk1;
FFT fft;

Serial myPort;
int val;

Sky stars = new Sky();
Rect rect1;
Box[] boxes;
Time timer;
Drop[] drop;
PImage head;
int totaldrop=0;
int totalboxes=0;
float speedX;
float speedY;





void setup(){
minim=new Minim(this);
myPort = new Serial(this,"COM3", 9600);
kingk1=minim.loadFile("Phonetic Hero - Sky Rogue - 04 Cleared For Takeoff.mp3",560);
kingk1.play();
size(800,1000);
smooth();
rect1=new Rect();
stars.setup();
head=loadImage("s47.JPG");
timer=new Time(300);
drop=new Drop[1000];
boxes=new Box[100];
timer.start();
}


void draw(){
  background(255);
  
  
  
  
  if ( myPort.available() > 0) {  
    val = myPort.read();         
  }
  if (val == 0) {            //left  
   speedX=speedX-5;
   speedX--;
  } 
  if (val == 1) {            //right 
  speedX=speedX+5;
   speedX++;
  } 
  if (val == 8) {            //up 
   speedY=speedY+6;
    speedY++;
  } 
   if (val == 9) {            //down  
    speedY=speedY-6;
    speedY--;
  } 

  

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

rect1.setlocation(speedX,speedY);                                         //xiugai.arduino
rect1.display();
stars.move();
stars.display();
imageMode(CENTER);
image(head,speedX,speedY);                                                //
if(timer.isFinished()){
drop[totaldrop]=new Drop();
boxes[totalboxes]=new Box();
totaldrop++;
totalboxes++;
if(totaldrop>=drop.length){
totaldrop=0;
}
if(totalboxes>=boxes.length){
totalboxes=0;
}
timer.start();
}
for(int i=0;i<totaldrop;i++){
drop[i].move();
drop[i].display();
}
for(int j=0;j<totalboxes;j++){
boxes[j].move();
boxes[j].display();
for(int i=0;i<totaldrop;i++){
if(drop[i].intersect(boxes[j])){
boxes[j].caught();
drop[i].caught1();
}
if(rect1.inter(boxes[j])){
gameover();
boxes[j].stop1();
drop[i].stop2();
}
}
}
}













void gameover(){
fill(150,50,50);
speedX=1;
speedY=1;
textSize(100);
textAlign(CENTER);
text("Game Over",width/2,height/2);
}
class Time{
int savedtime;
int totaltime;
Time(int temptotaltime){
 totaltime=temptotaltime; 
  }


void start(){
  savedtime=millis();
}
boolean isFinished(){
int passedtime=millis()-savedtime;
if(passedtime>totaltime){
return true;
}else{
  return false;
}
}
}



class Drop{
float x,y;
float r;
float speed;
color c;
Drop(){
r=3;
y=speedY;                                                    //xiugai.arduino
x=speedX;                                                    //xiugai.arduino
speed=random(20,30);
c=color(255,220,20);
} 
void move(){
y=y-speed;
}
void display(){
noStroke();
fill(c);
for(int i=9;i>r;i--){
ellipse(x,y-i*6,i*2,i*2);
ellipse(x+20,y-i*6,i,i);
ellipse(x-20,y-i*6,i,i);
}
}
boolean intersect(Box b){
float distance=dist(x,y,b.x,b.y);
if(distance<r+55){
  return true;
}else{
return false;
}
}
void caught1(){
speed=0;
y=-1000;
}
void stop2(){
  speed=0; 
}
}



class Box{
float x= random(width);
float y=random(1);
int life;
int speed;
Box(){
life=5;
speed=2;
}
void display(){
ellipseMode(CENTER);
rectMode(CENTER);
stroke(0);
strokeWeight(1);
fill(45,37,100);
rect(x,y-15,65,6);
rect(x,y-15,85,5);
arc(x,y-8,16,35,PI,PI*2);
ellipse(x,y-10,35,16);
fill(0,80,192);
ellipse(x-26,y-15,13,13);
ellipse(x+26,y-15,13,13);
fill(99,173,242);
ellipse(x+26,y-15,5,5);
ellipse(x-26,y-15,5,5);
}
void move(){
y=y+speed;
}
void caught(){
  speed=0;
  y=-1000;
}
void stop1(){
speed=0;
}
}



class Sky{
int n=60;
float speed=3;
float[]x=new float[n];
float[]y=new float[n];
float[]d=new float[n];
Sky(){
}
void setup(){
for (int i=0;i<n;i++){
if(i%5==0)
d[i]=random(0,2);
else
d[i]=3;
x[i]=random(0,width);
y[i]=random(-height,height*2);
}
}
void move(){
for (int i=0;i<n;i++){
  y[i]+=d[i]*speed;
  if(y[i]>height*2)
y[i]=random(-height-100,-height+1000);
}
}
void display(){
fill(0);
noStroke();
for (int i=0;i<n;i++){
  ellipse(x[i],y[i],d[i],d[i]);
}
}
}


class Rect{
float x;
float y;
float w;
float h;
Rect(){
x=0;
y=0;
w=85;
h=60;
}
void speedX(){
speedX=x;
speedY=y;
}
void setlocation(float tempx,float tempy){
x=tempx;
y=tempy;
}
void display(){
noStroke();
fill(255);
rectMode(CENTER);
rect(0,0,w,h);
}
boolean inter(Box b1){
float distance1=dist(x+40,y+30,b1.x+40,b1.y+6);
if(distance1<70){
return true;
}else{
return false;
}
}
}
