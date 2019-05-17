class Rec1 {//this is the class for temprature class 
  //define variables
  int x;
  int y;
  int d;
  float sensorValue;
  float threshold;
  String text;
  
  //class constructor
  Rec1(int x, int y, int d,float threshold, String text){
    this.x = x;
    this.y = y;
    this.d = d;
    this.threshold = threshold;
    this.text = text;
  }  
  void setSensorValue(float sensorValue){
     this.sensorValue = sensorValue;    
  }
  
  void displayRec1(){    //drawing an rect
    noStroke();
    fill(255,255,255);
    rect(this.x, this.y, this.d, 400);
    
    float mappedSensorValue = map(sensorValue,-20,threshold,0, 400);
    if(this.sensorValue>=0 && this.sensorValue<(this.threshold*0.25)){
    fill(#11F5C9);//turquoise
    
      }
      else if(this.sensorValue>=(this.threshold*0.25) && this.sensorValue<(0.50 * this.threshold)){
    fill (#23F511);//green
      }
    else if(this.sensorValue>=(this.threshold*0.50) && this.sensorValue<(0.75 * this.threshold)){
    fill(#F1FF36);//yellow
      }
    else{
      fill(#F51130);//red
      }
      
   noStroke();
    
    rect(this.x,400-mappedSensorValue,this.d, 400);//makes graph go from bottom to top 
    
   //changes sensorValue and text (float) with  color
   if(this.sensorValue>=0 && this.sensorValue<(this.threshold*0.25)){
    fill(#11F5C9);//turquoise
      }
      else if(this.sensorValue>=(this.threshold*0.25) && this.sensorValue<(0.50 * this.threshold)){
    fill(#23F511);//green
      }
    else if(this.sensorValue>=(this.threshold*0.50) && this.sensorValue<(0.75 * this.threshold)){
    fill(#F1FF36);//yellow
      }
    else{
    fill(#F51130);//red
      }
    textSize(35);
    text(int(sensorValue),305,200);
    textSize(25);
    text(char(176)+text,350,200);
    
    
  }
}
