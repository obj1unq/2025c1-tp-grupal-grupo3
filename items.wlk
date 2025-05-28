
import interactuable.*

class Item inherits Interactuable{
  const usoInfinito = false
  var property duracion = 0
  const position = game.at(1,1)
  const image = "cosa.png"
  const texto = "¡Encontre una cosa :p!"
  const esPista = true
  
  method position() {
    return position
  }

  method image() {
    return image
  }

  method puedeUsar() {
    return (usoInfinito || self.tieneDuracion())
  }

  method tieneDuracion() {
   return duracion > 0
  }

  override method interactuarCon(detective) {
    game.say(detective, texto)
    inventario.agregar(self)
    game.removeVisual(self)
  }

  method esPista() {
    return esPista
  }
}