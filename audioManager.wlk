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

  method reproducir(unSonido) {
    if (musicaActual != unSonido) {
        self.detenerMusicaActualSiCorresponde()
        unSonido.shouldLoop(true)
        unSonido.volume(0.1)
        unSonido.play()
        musicaActual = unSonido
    }
  }

  method detenerMusicaActualSiCorresponde() {
    if (musicaActual != null && musicaActual.played())
      self.detenerMusica()
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

  method detenerMusica() {
    musicaActual.stop()
  }
}