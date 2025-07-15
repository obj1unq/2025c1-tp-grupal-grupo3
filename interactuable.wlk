import audioManager.*
import inventario.*
import edificios.*
import detective.*
import cosas.*
import escenarios.*
class Interactuable {
  var property esIntearactuable = true

  method interactuarCon(detective) 
 
  method cambiarANoInteractuable() {
    esIntearactuable = false
  }

  method cambiarAInteractuable() {
    esIntearactuable = true
  }

  method sePuedeInteractuar()

}

class ObjetoInvisible inherits Interactuable{
  const property position
  const property texto
  const property image = "objetoinvisible.png"
  
  method image() {
    return image
  }

  method position() {
    return position
  }

  override method sePuedeInteractuar() {
    return true
  }

  override method interactuarCon(detective){
    //game.say(detective, "Necesito algo para ver mejor")
    self.validarSiPuedeInteractuarObjetoInvisibleCon(detective) 
    self.interactuarConObjetoInvisibleCon(detective)  
  }

  method validarSiPuedeInteractuarObjetoInvisibleCon(detective){
    if ( not self.puedeInteractuarObjetoInvisibleCon(detective))
      self.error("No se puede interactuar con este objeto")
  }

  method puedeInteractuarObjetoInvisibleCon(detective)

  method interactuarConObjetoInvisibleCon(detective){
    game.say(self, texto)
  }
}

class Grafiti inherits ObjetoInvisible {

  override method puedeInteractuarObjetoInvisibleCon(detective) {
    return detective.tieneItem(lupa)
  }
}

class Basurero inherits ObjetoInvisible {
  const property itemAEntregar  
  override method puedeInteractuarObjetoInvisibleCon(detective) {
    return detective.tieneItem(linterna) && not detective.tieneItem(itemAEntregar)
  }

  override method interactuarConObjetoInvisibleCon(detective){
    game.say(self, texto)
    inventario.agregar(itemAEntregar)
    inventario.refrescar()
  }
}

class Imagen {
  const property image
  
  method mostrar() {
    game.addVisual(image)
  }

  method ocultar() {
    game.removeVisual(image)
  }  
}

class ImagenDeInicio inherits Imagen {
  var property esVisible = true 
  const property imagenContex =  imagenContexto
  var property musicaInicioActiva = true
  var property juegoIniciado = false


  // override  method ocultar() {
  //   if (self.estaVisible()) {
  //       super()
  //       self.ponerInvisible()
  //       audioContexto.shouldLoop(false)
  //       audioContexto.volume(0.5)
  //       audioContexto.play()
  //   }else{
  //       game.removeVisual(imagenContex)
  //       //musicaIntro.stop()
  //       self.detenerMusicaInicio()
  //       // audioContexto.stop()
  //       // audioContexto.shouldLoop(false)
  //       // audioContexto.volume(0.5)
  //       self.detenerAudioContexto()
  //       musicaPrincipal.play()      
  //   }
  // }
    // override method ocultar() {
    //     if (self.estaVisible()) {
    //         self.ocultarPantallaDeInicio()
    //     } else {
    //         self.ocultarPantallaDeContextoYPasarAlJuego()
    //     }
    // }
  override method ocultar() {
    if (not self.juegoYaIniciado())
      self.realizarOcultamientoCorrespondiente()
  }

  method realizarOcultamientoCorrespondiente() {
    if (self.estaVisible()) {
        self.ocultarPantallaDeInicio()
    } else {
      self.ocultarPantallaDeContextoYPasarAlJuego()
    }
  }
  
  // method ocultarPantallaDeInicio() {
  //     game.removeVisual(image)
  //     self.ponerInvisible()

  //     audioContexto.shouldLoop(false)
  //     audioContexto.volume(0.5)
  //     audioContexto.play()
  // }

  // method ocultarPantallaDeContextoYPasarAlJuego() {
  //     game.removeVisual(imagenContex)

  //     self.detenerMusicaInicio()
  //     self.detenerAudioContexto()

  //     audioManager.iniciarMusicaPrincipal()
  //     //detective.escenarioActual().configurar()
  //     detective.escenarioActual().configurar()
  //     audioManager.reproducirPara(detective.escenarioActual()) 
  // }
  method ocultarPantallaDeInicio() {
      game.removeVisual(image)
      self.ponerInvisible()

      audioContexto.shouldLoop(false)
      audioContexto.volume(0.5)
      audioContexto.play()
  }

  method ocultarPantallaDeContextoYPasarAlJuego() {
    game.removeVisual(imagenContex)

    self.detenerMusicaInicio()
    self.detenerAudioContexto()

    audioManager.reproducirPara(detective.escenarioActual())
    detective.escenarioActual().configurar()
  
    self.marcarJuegoComoIniciado()
  }

  method marcarJuegoComoIniciado() {
    juegoIniciado = true
  }

  method juegoYaIniciado() {
    return juegoIniciado
  }



  method detenerMusicaInicio() {
    if (musicaIntro.played()) {
        musicaIntro.stop()
    }
 }
  



  // method detenerMusicaInicio() {
  //   if (musicaInicioActiva) {
  //     musicaIntro.stop()
  //     musicaInicioActiva = false
  //   }
  // }

  method detenerAudioContexto() {
    if (audioContexto.played()) {
      audioContexto.stop()
      audioContexto.shouldLoop(false)
      audioContexto.volume(0.5)
    }
  }


  method estaVisible() {
    return esVisible
  }
  method ponerInvisible() {
    esVisible = false
  }
}

// object audioManager {
//   var property musicaActual = null

//   const property musicaPrincipal = new Sound(file = "musicaMain.mp3")
//   const property musicaBosque = new Sound(file = "musicaBosque.mp3")

//   method iniciarMusicaPrincipal() {
//     if (musicaActual != musicaPrincipal) {
//       self.detenerMusicaActual()

//       musicaPrincipal.shouldLoop(true)
//       musicaPrincipal.volume(0.5)
//       musicaPrincipal.play()

//       musicaActual = musicaPrincipal
//     }
//   }

//   method iniciarMusicaBosque() {
//     if (musicaActual != musicaBosque) {
//       self.detenerMusicaActual()

//       musicaBosque.shouldLoop(true)
//       musicaBosque.volume(0.5)
//       musicaBosque.play()

//       musicaActual = musicaBosque
//     }
//   }

//   method detenerMusicaActual() {
//     if (musicaActual != null && musicaActual.played()) {
//       musicaActual.stop()
//     }
//   }
// }








const pantallaInicio = new ImagenDeInicio(image = imageDeInicio)
const imageDeInicio = new Mapa (image = "PantallaInicial.png")
const imagenContexto = new Mapa ( image = "pantallaContexto.png")
const musicaIntro = new Sound(file = "musicaIntro.mp3")
const musicaPrincipal = new Sound(file = "musicaMain.mp3")
const audioContexto = new Sound(file = "audioContexto.mp3")



