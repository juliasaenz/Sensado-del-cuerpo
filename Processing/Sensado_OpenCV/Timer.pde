class Timer {
  int espera; // Cantidad de segundos del timer
  int time;

  Timer(int espera_) {
    espera = espera_*1000;
  }

  void guardarTiempo() {
    // Guarda el tiempo actual. Reinicia el timer
    time = millis();
  }

  boolean pasoElTiempo() {
    // Si paso el tiempo de "espera" desde la ultima vez que se guardo el tiempo
    if (millis() - time >= espera) {
      return true;
    }
    return false;
  }

  ////
}
