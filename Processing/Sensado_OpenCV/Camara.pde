import processing.video.*;
class Camara {
  /* Esta clase permite leer y mandar el feed de camara */
  Capture cam; // Cámara sin filtros
  Capture act; // Cámara que se usa
  String filtro = "color";

  Camara(Sensado_OpenCV sketch) {
    cam = new Capture(sketch, "pipeline:autovideosrc");
    act = cam;
    act.start();
  }

  void mostrarFeed() {
    if (act.available() == true) {
      act.read();
    } 
   
    /* Aplicar distintos filtros al feed */
    if (filtro == "color"){
      act = cam;
    } else if (filtro == "monocromo"){
      act.filter(GRAY);
    } else if (filtro == "threshold"){
      act.filter(THRESHOLD,0.7); 
    }
    image(act,0,0);
  }
  
  PImage enviarFeed(){
    return act;
  }

  void frenarFeed() {
    act.stop();
  }

  void filtros() {
     if (key == '1'){
       // color
       filtro = "color";
     } else if (key == '2') {
       filtro = "monocromo";
     } else if (key == '3') {
       filtro = "threshold";
     }
  }
  
  /* fin de clase */
}
