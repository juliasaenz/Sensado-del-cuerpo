Camara c;
openCVd o;

void setup() {
  size(640, 480);
  background(0);

  c = new Camara(this);
  o = new openCVd(this, "C:/Users/Julia/Documents/GitHub/InterfacezNoTactiles/detector_openCV/Hand.Cascade.1.xml");

}
void draw() {
  c.mostrarFeed();
  o.medicion(c.enviarFeed());
  println(frameRate);
}

void keyPressed() {
  c.filtros();
}
