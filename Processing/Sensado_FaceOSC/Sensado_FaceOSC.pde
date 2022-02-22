import oscP5.*;
OscP5 oscP5;

// our FaceOSC tracked face dat
Cara cara;


void setup() {
  size(640, 480);
  frameRate(30);

  cara = new Cara();
 
  oscP5 = new OscP5(this, 8338);
  oscP5.plug(cara, "rawData", "/raw");
}

void draw() {  
  background(200);  
  //cara.dibujarCara();
  cara.dibujarPuntos();

}

// OSC CALLBACK FUNCTIONS

void oscEvent(OscMessage m) {
  cara.parseOSC(m);
}
