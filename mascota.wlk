import detective.*
import cosas.*

class Mascota {
  const position = game.at(1,1)
  const image = "cosa.png"
  const texto = "¡Encontre una cosa :p!"
  const comida = bocadisho

  method position() {
    return position
  }

  method image() {
    return image
  }

  method interactuarCon(detective) {
    game.say(detective, texto)
    game.removeVisual(self)
  }

  method comidaFavorita() {
    return comida
  }

  
}