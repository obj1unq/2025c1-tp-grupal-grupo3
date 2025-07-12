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

const pantallaInicio = new Imagen(image = imageDeInicio)
const imageDeInicio = new Mapa (image = "PantallaInicial.png")


