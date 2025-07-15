import interactuable.*
import wollok.game.*
import detective.*
import direcciones.*
import cosas.*  
import vecinos.*
import escenarios.*
import inventario.*
import animalSalvaje.*


object audioManager {
  var property musicaActual = null
//   const property musicaPrincipal = new Sound(file = "musicaMain.mp3")
//   const property musicaBosque = new Sound(file = "musicaBosque.mp3")

  method reproducir(unSound) {
    if (musicaActual != unSound) {
        self.detenerMusicaActualSiCorresponde()
        unSound.shouldLoop(true)
        unSound.volume(0.2)
        unSound.play()
        musicaActual = unSound
    }
  }

  method detenerMusicaActualSiCorresponde() {
    if (musicaActual != null && musicaActual.played())
      musicaActual.stop()
  }

  method iniciarMusicaPrincipal() { 
    self.reproducir(musicaPrincipal)
  }
  method iniciarMusicaBosque(){ 
    self.reproducir(musicaBosque)
  }

  method reproducirPara(escenario) {
    self.reproducir(escenario.musicaDeseada())
  }
}