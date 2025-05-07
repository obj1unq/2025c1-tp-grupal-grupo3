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

class Objecto {
  const usoInfinito = false
  var property duracion = 0
  var property position = game.at(1,1)

  method puedeUsar() {
    return (usoInfinito || self.tieneDuracion())
  }

  method tieneDuracion() {
    return duracion > 0
  }
}

object lupa {
  const property usoInfinito = true
  const property duracion = 1
  const position = game.at(1, 2)

  method position() {
    return position
  }

  method image() {
    return "lupa.png"
  }

  method interactuar() {
    // Código para interactuar con la lupa
    game.say(self, "¡Encontraste una lupa!")
  }

  method puedeUsar() {
    return (usoInfinito || self.tieneDuracion())
  }

  method tieneDuracion() {
    return duracion > 0
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

  method interactuar() {
    //interactuar
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

  method interactuar() {
    //interactuar
  }

  method puedeUsar() {
    return (usoInfinito || self.tieneDuracion())
  }

  method tieneDuracion() {
    return duracion > 0
  }
}
