import oscP5.*;

OscP5 oscP5;
Mano m;

void setup() {
  size(640, 480);
  background(0);

  oscP5 = new OscP5(this, 8008);

  m = new Mano();
  oscP5.plug(m,"getLandmarks","/landmarks");
  oscP5.plug(m,"getTopLeft","/boundingBox/topLeft");
  oscP5.plug(m,"getBottomRight","/boundingBox/bottomRight");
  oscP5.plug(m,"getConfianza","/handInViewConfidence");
}

void draw () {
  background(100);

  m.dibujarLandmarks(); 
  m.dibujarBox();
}

void oscEvent(OscMessage men) {
  //println(m);

  //println(men.addrPattern());
}
