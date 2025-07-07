import inventario.*
import edificios.*
import detective.*
import cosas.*
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
  override method puedeInteractuarObjetoInvisibleCon(detective) {
    return detective.tieneItem(linterna)
  }

  override method interactuarConObjetoInvisibleCon(detective){
    game.say(self, texto)
    inventario.agregar(pelos)
  }

  
}

