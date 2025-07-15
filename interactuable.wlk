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


  override  method ocultar() {
    if (self.estaVisible()) {
        super()
        self.ponerInvisible()
        musicaPrincipal.stop()
        audioContexto.shouldLoop(false)
        audioContexto.volume(0.5)
        audioContexto.play()
    }else{
        game.removeVisual(imagenContex)
        musicaIntro.stop()
        audioContexto.stop()
        audioContexto.shouldLoop(false)
        audioContexto.volume(0.5)
        musicaPrincipal.play()
        
    }
  }

  method estaVisible() {
    return esVisible
  }
  method ponerInvisible() {
    esVisible = false
  }
}

const pantallaInicio = new ImagenDeInicio(image = imageDeInicio)
const imageDeInicio = new Mapa (image = "PantallaInicial.png")
const imagenContexto = new Mapa ( image = "pantallaContexto.png")
const musicaIntro = new Sound(file = "musicaIntro.mp3")
const musicaPrincipal = new Sound(file = "musicaMain.mp3")
const audioContexto = new Sound(file = "audioContexto.mp3")



