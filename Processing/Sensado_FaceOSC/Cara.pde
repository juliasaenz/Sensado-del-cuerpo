import oscP5.*;

class Cara {
  // Encontró cara
  int hay;

  // Pose
  float poseScale;
  PVector posePosition = new PVector();
  PVector poseOrientation = new PVector();

  // Gestos
  float mouthHeight, mouthWidth;
  float eyeLeft, eyeRight;
  float eyebrowLeft, eyebrowRight;
  float jaw;
  float nostrils;

  //Puntos
  float[] rawArray;

  Cara() {
    rawArray = new float[132];
  }

  void dibujarCara() {
    if (hay > 0) {
      pushMatrix();
      fill(0);
      translate(posePosition.x, posePosition.y);
      scale(poseScale);
      ellipse(-20, eyeLeft * -9, 7, 7);
      ellipse(20, eyeRight * -9, 7, 7);
      ellipse(0, 20, mouthWidth* 3, mouthHeight * 3);
      ellipse(0, nostrils * -1, 5, 5);
      rectMode(CENTER);
      rect(-20, eyebrowLeft * -5, 25, 3);
      rect(20, eyebrowRight * -5, 25, 3);
      popMatrix();
    }
  }

  void dibujarPuntos() {
    /* Puntos */
    int nData = rawArray.length;
    for (int val=0; val<nData; val+=2) {
      noStroke();
      fill(255);
      ellipse(rawArray[val], rawArray[val+1], 8, 8);
    }
    /* Lineas */
    noFill(); 
    stroke(255);
    // Face outline
    beginShape();
    for (int i=0; i<34; i+=2) {
      vertex(rawArray[i], rawArray[i+1]);
    }
    for (int i=52; i>32; i-=2) {
      vertex(rawArray[i], rawArray[i+1]);
    }
    endShape(CLOSE);

    // Eyes
    beginShape();
    for (int i=72; i<84; i+=2) {
      vertex(rawArray[i], rawArray[i+1]);
    }
    endShape(CLOSE);
    beginShape();
    for (int i=84; i<96; i+=2) {
      vertex(rawArray[i], rawArray[i+1]);
    }
    endShape(CLOSE);

    // Upper lip
    beginShape();
    for (int i=96; i<110; i+=2) {
      vertex(rawArray[i], rawArray[i+1]);
    }
    for (int i=124; i>118; i-=2) {
      vertex(rawArray[i], rawArray[i+1]);
    }
    endShape(CLOSE);

    // Lower lip
    beginShape();
    for (int i=108; i<120; i+=2) {
      vertex(rawArray[i], rawArray[i+1]);
    }
    vertex(rawArray[96], rawArray[97]);
    for (int i=130; i>124; i-=2) {
      vertex(rawArray[i], rawArray[i+1]);
    }
    endShape(CLOSE);

    // Nose bridge
    beginShape();
    for (int i=54; i<62; i+=2) {
      vertex(rawArray[i], rawArray[i+1]);
    }
    endShape();

    // Nose bottom
    beginShape();
    for (int i=62; i<72; i+=2) {
      vertex(rawArray[i], rawArray[i+1]);
    }
    endShape();
  }



  boolean parseOSC(OscMessage m) {
    /* Recibe y analiza los datos que recibe de FaceOSC 
     Devuelve true si le llegó un mensaje */
    if (m.checkAddrPattern("/found")) {
      hay = m.get(0).intValue();
      return true;
    }          
    /* Pose */
    else if (m.checkAddrPattern("/pose/scale")) {
      /* Escala de la pose */
      poseScale = m.get(0).floatValue();
      return true;
    } else if (m.checkAddrPattern("/pose/position")) {
      /* Posición en X e Y */
      posePosition.x = m.get(0).floatValue();
      posePosition.y = m.get(1).floatValue();
      return true;
    } else if (m.checkAddrPattern("/pose/orientation")) {
      /* Orientación en X, Y y Z */
      poseOrientation.x = m.get(0).floatValue();
      poseOrientation.y = m.get(1).floatValue();
      poseOrientation.z = m.get(2).floatValue();
      return true;
    }
    /* Gestos */
    else if (m.checkAddrPattern("/gesture/mouth/width")) {
      /* Ancho de la boca */
      mouthWidth = m.get(0).floatValue();
      return true;
    } else if (m.checkAddrPattern("/gesture/mouth/height")) {
      /* Alto de la boca */
      mouthHeight = m.get(0).floatValue();
      return true;
    } else if (m.checkAddrPattern("/gesture/eye/left")) {
      /* Apertura de ojo izquierdo */
      eyeLeft = m.get(0).floatValue();
      return true;
    } else if (m.checkAddrPattern("/gesture/eye/right")) {
      /* Apertura de ojo derecjo */
      eyeRight = m.get(0).floatValue();
      return true;
    } else if (m.checkAddrPattern("/gesture/eyebrow/left")) {
      /* Altura de ceja izquierda */
      eyebrowLeft = m.get(0).floatValue();
      return true;
    } else if (m.checkAddrPattern("/gesture/eyebrow/right")) {
      /* Altura de ceja derecha */
      eyebrowRight = m.get(0).floatValue();
      return true;
    } else if (m.checkAddrPattern("/gesture/jaw")) {
      /* Altura de mandíbula */
      jaw = m.get(0).floatValue();
      return true;
    } else if (m.checkAddrPattern("/gesture/nostrils")) {
      /* Altura de fosas nasales */
      nostrils = m.get(0).floatValue();
      return true;
    }

    return false;
  }

  public void rawData(float[] raw) {
    rawArray = raw; // stash data in array
  }

  String toString() {
    /* Pasar todos los datos de la pose como un string */
    return "hay: " + hay + "\n"
      + "pose" + "\n"
      + " scale: " + poseScale + "\n"
      + " position: " + posePosition.toString() + "\n"
      + " orientation: " + poseOrientation.toString() + "\n"
      + "gesture" + "\n"
      + " mouth: " + mouthWidth + " " + mouthHeight + "\n"
      + " eye: " + eyeLeft + " " + eyeRight + "\n"
      + " eyebrow: " + eyebrowLeft + " " + eyebrowRight + "\n"
      + " jaw: " + jaw + "\n"
      + " nostrils: " + nostrils + "\n";
  }

  // Fin clase
};
