import detective.*

object inventario {
  const property objetos = #{lupa, foto, blockNotas}

  method agregar(cosa) {
    objetos.add(cosa)
  }

  method interactuar(cosa) {
    if (not self.puedeInteractuar(cosa) ) {
      game.say(cosa, "No podes interactuar con esto ahora")
    } else {
        cosa.interactuar()
    }
  }

  method puedeInteractuar(cosa) {
    return (self.tieneAlgun(cosa) && cosa.puedeUsar())
  }

  method tieneAlgun(cosa) {
    return (objetos.any({objeto => objeto == cosa}))
  }

}

// class Objeto {
//   const usoInfinito = false
//   var property duracion = 0
//   var property position = game.at(1,1)

//   method puedeUsar() {
//     return (usoInfinito || self.tieneDuracion())
//   }

//   method tieneDuracion() {
//     return duracion > 0
//   }
// }

object lupa {
  const property usoInfinito = true
  const property duracion = 1
  const position = game.at(1, 5)

  method position() {
    return position
  }

  method image() {
    return "lupa.png"
  }

  method puedeUsar() {
    return (usoInfinito || self.tieneDuracion())
  }

  method tieneDuracion() {
    return duracion > 0
  }

  method interactuarCon(detective) {
    game.say(detective, "¡Encontre una lupa!")
    inventario.agregar(self)
    game.removeVisual(self)
  }
}

object foto {
  const property usoInfinito = true
  const property duracion = 1
  const position = game.at(10, 2)

  method position() {
    return position
  }

  method image() {
    return "foto.png"
  }

  method interactuarCon(detective) {
    game.say(detective, "¡Encontre una foto!")
    inventario.agregar(self)
    game.removeVisual(self)
  }

  method puedeUsar() {
    return (usoInfinito || self.tieneDuracion())
  }

  method tieneDuracion() {
    return duracion > 0
  }
}

object blockNotas {
  const property usoInfinito = true
  const property duracion = 1
  const position = game.at(1, 4)

  method position() {
    return position
  }

  method image() {
    return "blockNotas.png"
  }

  method interactuarCon(detective) {
    game.say(detective, "¡Encontre un block de notas!")
    inventario.agregar(self)
    game.removeVisual(self)
  }

  method puedeUsar() {
    return (usoInfinito || self.tieneDuracion())
  }

  method tieneDuracion() {
    return duracion > 0
  }
}
