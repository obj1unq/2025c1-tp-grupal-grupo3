import detective.*
import cosas.*
import interactuable.*
import escenarios.*

class Mascota inherits Interactuable{
  const position = game.at(10,10)
  const image = "mascota1.png"
  const texto = "¡!"
  const comida
  const property escenarioActual = escenarioBosque

  method position() {
    return position
  }

  method image() {
    return image
  }

  override method interactuarCon(detective) {
    game.say(detective, texto)
    game.removeVisual(self)
  }

  method comidaFavorita() {
    return comida
  }

  method sePuedeMostarEnInventario() {
    return false
  }

  method puedeInteractuar() {
    return true
  }
}

//const morena = new Mascota( )