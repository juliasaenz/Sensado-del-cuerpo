class Mano {
  /* 
   0: Base palma
   1-4: Pulgar
   5-8: Índice
   9-12: Medio
   13-16: Anular
   17-20: Meñique  
   */
  float[] landmarks;
  float[] x;
  float[] y;
  float confianza;
  float[] box;
  boolean debug = false;

  Mano() {
    landmarks = new float[63];
    x = new float[21]; // posición en x de landmarks mapeado al ancho
    y = new float[21]; // posición en y de landmarks mapeado al alto
    box = new float [4];
  }

  void dibujarLandmarks() {
    /* Puntos */
    for (int i = 0; i < x.length; i ++) {
      ellipse(x[i], y[i], 8, 8);
      text(i, x[i] + 10, y[i]);
    }
    /* Líneas */
    for (int i = 4; i < x.length; i+= 4) {
      int j;
      for (j = i; j > i-3; j--) {
        stroke(255);
        line(x[j], y[j], x[j-1], y[j-1]);
      }
      if (i < 21) {
        line(x[0], y[0], x[j], y[j]);
      }
    }
    text("confianza: "+confianza, 20, height-50);
  }

  void dibujarBox() {
    /* No funciona porque los datos no están bien mapeados*/
    rectMode(CORNER);
    stroke(255, 0, 0);
    noFill();
    println(box);
    //rect(box[0], box[1], box[2], box[3]);
  }

  void getLandmarks(float [] l) {
    landmarks = l;
    int j = 0;
    for (int i = 0; i < landmarks.length; i += 3) {
      x[j] = map(landmarks[i], 0, 800, width, 0);
      y[j] = map(landmarks[i+1], 0, 600, 0, height);
      j++;
    }
  }

  void getTopLeft(float[] tl) {
    box[0] = tl[0];
    box[1] = tl[1];
  }

  void getBottomRight(float[] br) {
    box[2] = br[0]; 
    box[3] = br[1];
  }

  void getConfianza(float c) {
    confianza = c;
  }

  //fin clase
}
