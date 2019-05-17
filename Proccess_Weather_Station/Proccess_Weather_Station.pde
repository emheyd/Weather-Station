// Weather station
// Emad Heydari
// 2019-05-02
// version 2.0
// an attempt to showcase the use of Arduino and processing in creating a weather station 


import processing.serial.*;

//declaring variables
Serial myPort;
PFont font;
//variables called each time a new data entry is received  
Rec1 tempRect;
Rec2 humRect;

//declare variables for table
Table table;
String filename;//new declarations for recording info into excel


// set initial sensor values
float hum = 0;
float tempc= 0;
float pres =0;

//timer variables
int totalSec;
int startTime;
int elapsedTime=0;
PImage img;

void setup(){
size(800,400);//size of box
img = loadImage("ireland-flag.png");

startTime =millis();//sets start time for timer
  
   myPort = new Serial(this, "/dev/cu.usbmodem1431",9600);
   myPort.bufferUntil('\n');
  
font = loadFont("SourceCodePro-Bold-48.vlw");//loads font stored in data folder
  textFont(font);

table = new Table();//to set up table  

  table.addColumn("Date");//col for date
  table.addColumn("Time");//col for date
  table.addColumn("Run Time");//col for runtime
  table.addColumn("Data Temp C");//col for data temp  
  table.addColumn("Data Hum %");//col for data hum  
 
 
 //sets up class for recta(1 and 2)
tempRect = new Rec1(200,0,100,100, "Temp C");// sets class for Rect1 syntaxt int x, int y, int d,float threshold, String text 
humRect = new Rec2(480,0,100,100, "% Humidity");// sets class for Rect1 syntaxt int x, int y, int d,float threshold, String text 
}

void draw(){
  
  
background(0);//background color 1 
//background(#310FF7);//background color 2
image(img, 0, 80);

//clock function
  int d = day();
  int m = month();
  int y = year();
  int h = hour();
  int min = minute();
  int s = second();
 String yearString = str(y);//converts year to string 
 //code to set AM PM
fill(255);//color of PM
   if(h>12){
    text("PM",110,55);}    
    else{
   text("AM",110,55);}
 
 h=h%12;//changes to 12 hour clock
  if(h==0){
    h=12;} 
  textSize(20);
  
   //date
    textSize(17);//back to 17
 text (m+"/"+d+"/"+yearString.substring(2),10,40);//display date on box
  //yearString.substring (2) displays reay as 2 digits 
  
  //clock
  fill(255);
 String sx=str((s));if(sx.length()==1){//converting data to string & adding "0" to single digit
  sx="0" +sx;
};

String mx=str((min));if(mx.length()==1){
  mx="0" +mx;
};
String hx=str((h));if(hx.length()==1){
  hx="0" +hx;
};

text(hx+":"+mx+":"+sx,10,55);//writes clock to box
//end clock function

//write ref numbers
textSize(22);
  fill(255,0);//color or ref numbers
 text( "100 C",130,20);
   text( "100 %",590,20);
   fill(255);
   text("-20 C",130,390);
 text("0 %",590,390);
 //end ref numbers
  
//instruction box to write text
 fill(255);
rect(305,5,170,60,7);
 textSize (15);//adds text to instruct in mouse to close program
 fill(0);//color black; 
 text("Click Here        to Close        and Save Data",315,15,170,150);
//end box instructions
  
 //cursor display 3 digit function shows x y cordinates for mouse
 //I use this to help locate and relocate things useful, but not essential to program
  textSize(15);// change size to 15 for grid  coordinates
  fill(255);//color 
  String mux =str(mouseX);//changes x value to string
   String muy =str(mouseY);//changes y value to string
   if(mux.length()==2){
  mux="0" +mux;}
  else if (mux.length()==1){
    mux="00"+mux;}//sets x value as 3 digits
    
    if(muy.length()==2){
  muy="0" +muy;}
  else if (muy.length()==1){
    muy="00"+muy;}//sets y value as 3 digits      
  text("x:"+mux+" y:"+muy, 670, 380); //display cursor value at 640,380  
  //end cursor display 
      
      
 //timer function display
 fill(255,255,255);
 rect(5,205,95,100,7);
 fill(0);
 textSize(15);
 text("Run Time:",10,220);
  
 int elapsedM=millis()-startTime; //sets timer based on milliseconds 
 int totalSec=elapsedM/1000; 
 String secs = str(totalSec % 60);
 String mins =str(totalSec /60 % 60);
 String hours =str(totalSec / 3600 % 24); 
 String days =str(totalSec /86400);
  
 //converts so format is "00"
 if(secs.length()==1){//converting data to string & adding "0" to single digit
  secs="0" +secs;
};
 if(mins.length()==1){//converting data to string & adding "0" to single digit
  mins="0" +mins;
};
 if(hours.length()==1){//converting data to string & adding "0" to single digit
  hours="0" +hours;
}; 


   text("S:"+secs,10,240);
   text("M:"+mins,10,260);
   text("H:"+hours,10,280);
   text ("D:"+days,10,300);
   
  //end timer function
  
   //rect class display
   tempRect.displayRec1();//displays Rect1
   tempRect.setSensorValue(tempc);//sets temp as SensorValue (a float) for tempRect (Recta1 class) to chanfe to C replace temp with tempc
   humRect.displayRec2();//displays Rect2
   humRect.setSensorValue(hum);//sets hum as SensorValue (a float) for humRect (Recta2 class)
 //writes to top of rectangles  
 textSize(15);   
 fill(0);
 text("Temp",220,10);
 text("Humidity",490,10);
 // ends writes to top of rectangles  
}

void serialEvent(Serial myPort){// reads serial data 
  String myString = myPort.readStringUntil('\n');  //read the serial buffer
  println(myString);
  if(myString != null){
    myString = trim(myString);
    int sensorData[] = int(split(myString,'.'));//splits in 2 as data was seperated by a comma
   tempc = sensorData[1];//recieves data for temp in C
   hum = sensorData[0];
   pres = sensorData[2];
    
    //clock tor table
  int d = day();
  int m = month();
  int y = year();
  int h = hour();
  int min = minute();
  int s = second();
  String yearString =str(y);//changes year into string 
  
   String sx=str((s));if(sx.length()==1){//converting data to string & adding "0" to single digit
  sx="0" +sx;
};
 
  String mx=str((min));if(mx.length()==1){
  mx="0" +mx;
};
String hx=str((h));if(hx.length()==1){
  hx="0" +hx;
};//end clock for table

//timer for table
 int elapsedM=millis()-startTime; //sets timer based on milliseconds 
 int totalSec=elapsedM/1000; 
 String secs = str(totalSec % 60);
 String mins =str(totalSec /60 % 60);
 String hours =str(totalSec / 3600 % 24); 
 String days =str(totalSec /86400);
  
 //converts so format is "00"
 if(secs.length()==1){//converting data to string & adding "0" to single digit
  secs="0" +secs;
};
 if(mins.length()==1){//converting data to string & adding "0" to single digit
  mins="0" +mins;
};
 if(hours.length()==1){//converting data to string & adding "0" to single digit
  hours="0" +hours;
}; //end timer for table
    
    //table set up
      TableRow newRow = table.addRow();
      
      newRow.setString("Date", int(m) + "/" + int(d) + "/"+yearString.substring(2) );  //place the new row and time under the "Date" column
      //yearString.substring(2) shows year as 2 digits      
      newRow.setString("Time", hx + ":" + mx + ":" + sx);  //place the new row and time under the "Time" column, time converted so "0's"
      newRow.setString("Run Time",(days)+":"+(hours)+":"+(mins)+":"+(secs));
      newRow.setString("Data Temp F",str(tempc));//places 2 digits of tempFstring into table, to convert to C replace "tempFstring.substring(0,2)" with "tempc"
      // newRow.setString("Data Hum %",myString.substring(3,5));//row for hum splits  data string 3-5
      newRow.setString("Data Hum %",str(hum));
  }
}
void mousePressed(){//ends program and writes file when mouse pressed
if (mousePressed && (mouseY > 5) && (mouseY < 60) && (mouseX > 305) && (mouseX < 475)) 
{
  //variables used for the filename timestamp
  int d = day();
  int m = month();
  int y= year();
  int h = hour();
  int min = minute();
  int s = second();
  String yearString = str(y);//converts year to string
    String sx=str((s));if(sx.length()==1){//converting data to string & adding "0" to single digit
  sx="0" +sx;
};
 
  String mx=str((min));if(mx.length()==1){
  mx="0" +mx;
};
String hx=str((h));if(hx.length()==1){
  hx="0" +hx;
};
  //variable as string under the data folder set as (mm-dd--hh-min-s.csv)
  filename = "data/" + str(m) + "-" + str(d) + "-" +yearString.substring(2)+"--"+ hx + "-" + mx + "-" + sx + ".csv";//substring writes year as 2 digits
  //save as a table in csv format(data/table - data folder name table)
  saveTable(table, filename);
  exit();
}}
