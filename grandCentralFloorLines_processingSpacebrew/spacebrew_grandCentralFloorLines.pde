/*
 * Base Example 
 *
 *   Sketch that features the basic building blocks of a Spacebrew client app.
 * 
 */

import spacebrew.*;

String server="sandbox.spacebrew.cc";
String name="grandCentral";
String description ="Listens to a button press to display a line across the floor";

Spacebrew sb;


/* floor lines */
ArrayList<FloorLine> floorLines;

int bg = 0;

void setup() {
  size(800, 600);

  // instantiate the sb variable
  sb = new Spacebrew( this );

  // add each thing you publish to
  //sb.addPublish( "buttonPress", "boolean", false ); //what you're sending

  // add each thing you subscribe to
  sb.addSubscribe( "lineColor", "string" ); //what you're receiving
  sb.addSubscribe( "ticketWindow", "range" ); //what you're receiving
  //sb.addSubscribe( "buttonPress", "boolean" ); //what you're receiving


  // connect to spacebrew
  sb.connect(server, name, description);
  
  //instantiate floorLines arrayList
  floorLines = new ArrayList<FloorLine>();
}


void draw() {
  background(0);
  
  for (int i=0; i < floorLines.size (); i++) {
    FloorLine tempFL = floorLines.get(i);
    tempFL.display();
  }
}

//the following get called automatically when spacebrew sends something

void onRangeMessage( String name, int value ) {
  println("got range message " + name + " : " + value);
    PVector start = new PVector(-10, (height/8)*value);
    PVector dest = new PVector(width+10, random(0,height));
    color c = color(random(0,255),random(0,255),random(0,255));
    floorLines.add(new FloorLine(start, dest, c));
}

void onBooleanMessage( String name, boolean value ) { 
  println("got boolean message " + name + " : " + value);

  if (value) {
    PVector start = new PVector(-10, random(0,height));
    PVector dest = new PVector(width+10, random(0,height));
    color c = color(random(0,255),random(0,255),random(0,255));
    floorLines.add(new FloorLine(start, dest, c));
  }
}

void onStringMessage( String name, String value ) {
  println("got string message " + name + " : " + value);
  PVector start = new PVector(-10, random(0,height));
  PVector dest = new PVector(width+10, random(0,height));
  color c = (color(255,255,255));
  if (value.equals("green")){
      c = color(0,255,0);
  } else if (value.equals("blue")){
      c = color(0,0,255);
  } else if (value.equals("red")){
      c = color(255,00,0);
  } else if (value.equals("purple")){
      c = color(199,0,186);
  } else if (value.equals("orange")){
      c = color(255,149,0);
  }
  floorLines.add(new FloorLine(start, dest, c));

  
}

void onCustomMessage( String name, String type, String value ) {
  println("got " + type + " message " + name + " : " + value);
}


void keyPressed() {
  if (key == ' ') {
    PVector start = new PVector(-10, random(0,height));
    PVector dest = new PVector(width+10, random(0,height));
    color c = color(random(0,255),random(0,255),random(0,255));
    floorLines.add(new FloorLine(start, dest, c));
  }
}

