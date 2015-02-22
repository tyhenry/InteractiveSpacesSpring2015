class FloorLine {
  //starting point, destination point, line begin point, line end point
  PVector start, dest, posA, posB;
  color c;
  //time to display line, time line started displaying
  int displayStart, displayCounter;
  int crossTime, stayTime; //amounts

  FloorLine(PVector _start, PVector _dest, color _c){
    
    start = new PVector(_start.x, _start.y); //start position
    dest = new PVector(_dest.x, _dest.y); //destination position
    
    //set current positions to start
    posA = new PVector(_start.x,_start.y); 
    posB = new PVector(_start.x,_start.y);

    c = _c; //set line color
    
    displayStart = millis(); //get line start time (in seconds)
    displayCounter = 0;
    
    crossTime = 5000; //line takes 5 seconds to cross floor
    stayTime = 10000; //line stays solid for 10 seconds
    
    println("new floor line!");
    println("start: "+ start.x +", "+start.y);
    println("dest: "+ dest.x +", "+dest.y);
  }
  
  void display() {    
    pushStyle(); //starts a new style
    strokeWeight(10);
    stroke(c);
    strokeCap(SQUARE);
    line(posA.x,posA.y,posB.x,posB.y);
    popStyle();
    
    //if line should be starting
    //grow from start to destination
    if (displayCounter < crossTime){ 
      //set line posB to display perecentage based on time (0-30 seconds)
      float _x = map(displayCounter, 0, crossTime, start.x, dest.x);
      float _y = map(displayCounter, 0, crossTime, start.y, dest.y);
      posB.set(_x,_y);
    } 
    
    //if line should be ending
    //shrink from start to destination
    else if (displayCounter > stayTime+crossTime){
      //set line posA to display perecentage based on time (180-210 seconds)
      float _x = map(displayCounter, stayTime+crossTime, stayTime+crossTime*2, start.x, dest.x);
      float _y = map(displayCounter, stayTime+crossTime, stayTime+crossTime*2, start.y, dest.y);
      posA.set(_x,_y);
    }
    
    displayCounter = millis() - displayStart;

  }
    
}
      
    
