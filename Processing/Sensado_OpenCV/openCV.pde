import gab.opencv.*;
import java.awt.*;

class openCVd {
  OpenCV opencv ;
  Timer timer;
  float x, y= -1;
  float easing = .08;

  openCVd(Sensado_OpenCV sketch, String ruta) {
    opencv = new OpenCV(sketch, 640, 480);

    opencv.loadCascade (OpenCV.CASCADE_FRONTALFACE); //cascada existente
    //opencv.loadCascade(ruta, true); // cascada propia

    timer = new Timer(2); //límite para dejar de detectar
  }

  void medicion(PImage feed) {
    opencv.loadImage(feed); // cargar feed

    /* Parámetros:
     - ScaleFactor: Cantidad de veces que pasa el filtro (número entre 1 y 1.2)
     - MinNeighbour: Exigencia para devolver positivo
     - flags: antiguo (default 0)
     - minSize: Tamaño mínimo en pixeles de la detección
     - maxSize: Tamaño máximo en pixeles de la detección 
     */
    Rectangle [] deteccion = opencv.detect(1.15, 20, 0, 20, 250);
    if (deteccion.length > 0) {
      // si se detecta algo
      int i = rectMasGrande(deteccion);
      puntoMedio(deteccion, i);
      timer.guardarTiempo(); // reseteo de timer
      mostrarDeteccion(deteccion);
    } else {
      // si pasó el tiempo sin detección se oculta el punto medio
      if (timer.pasoElTiempo()) {
        x = -1;
        y = -1;
      }
    }
  }

  private int rectMasGrande(Rectangle[] det) {
    /* De todos los rectangulos, se queda con el más grande */
    int max = -1;
    int max_tam = -1;
    for (int i= 0; i<det.length; i++) {
      if (det[i].width > max_tam) {
        max = i;
        max_tam = det[i].width;
      }
    }
    return max;
  }

  private void puntoMedio(Rectangle[] det, int max) {
    /* Guardar el punto medio del rectangulo con suavizado de movimiento */
    float ax = (det[max].x + det[max].width/2) - x;
    float ay = (det[max].y + det[max].height/2 + 20) - y;
    x += ax * easing;
    y += ay * easing;
    /* Vizualizar punto medio */
    pushStyle();
    noStroke();
    fill(255, 0, 0);
    ellipse(x, y, 15, 15);
    popStyle();
  }

  private void mostrarDeteccion(Rectangle[] det) {
    /* muestra todas las instancias detectadas en tiempo real (para calibración) */
    for (int i=0; i < det.length; i++) {
      noFill();
      strokeWeight(3);
      stroke(0, 255, 0);
      rect(det[i].x, det[i].y, det[i].width, det[i].height);
    }
  }
  /* fin de clase*/
}
