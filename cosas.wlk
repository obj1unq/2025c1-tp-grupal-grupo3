import detective.*

object inventario {
  const property objetos = #{}

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

class Item {
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

  method interactuarCon(detective) {
    game.say(detective, texto)
    inventario.agregar(self)
    game.removeVisual(self)
  }

  method esPista() {
    return esPista
  }
}

const lupa = new Item( usoInfinito = true, duracion = 1, position = game.at(10,10), image = "lupa.png", texto = "Encontraste una lupa", esPista = false)

const blockNotas = new Item( usoInfinito = true, duracion = 1, position = game.at(5,5), image = "blockDeNotas.png", texto = "Encontraste un block de notas", esPista = false)

const collar = new Item( usoInfinito = true, duracion = 1, position = game.at(7,8), image = "collar.png", texto = "Encontraste un collar", esPista = true)

const bocadisho = new Item( usoInfinito = false, duracion = 1, position = game.at(9,9), image = "collar.png", texto = "Encontraste un bocadisho", esPista = true)
// object lupa {
//   const property usoInfinito = true
//   const property duracion = 1
//   const position = game.at(1, 5)

//   method position() {
//     return position
//   }

//   method image() {
//     return "lupa.png"
//   }

//   method puedeUsar() {
//     return (usoInfinito || self.tieneDuracion())
//   }

//   method tieneDuracion() {
//     return duracion > 0
//   }

//   method interactuarCon(detective) {
//     game.say(detective, "¡Encontre una lupa!")
//     inventario.agregar(self)
//     game.removeVisual(self)
//   }
// }

// object collar {
//   const property usoInfinito = true
//   const property duracion = 1
//   const position = game.at(10, 2)

//   method position() {
//     return position
//   }

//   method image() {
//     return "collar.png"
//   }

//   method interactuarCon(detective) {
//     game.say(detective, "¡Encontre una collar!")
//     inventario.agregar(self)
//     game.removeVisual(self)
//   }

//   method puedeUsar() {
//     return (usoInfinito || self.tieneDuracion())
//   }

//   method tieneDuracion() {
//     return duracion > 0
//   }
// }

// object blockNotas {
//   const property usoInfinito = true
//   const property duracion = 1
//   const position = game.at(1, 4)

//   method position() {
//     return position
//   }

//   method image() {
//     return "blockDeNotas.png"
//   }

//   method interactuarCon(detective) {
//     game.say(detective, "¡Encontre un block de notas!")
//     inventario.agregar(self)
//     game.removeVisual(self)
//   }

//   method puedeUsar() {
//     return (usoInfinito || self.tieneDuracion())
//   }

//   method tieneDuracion() {
//     return duracion > 0
//   }
// }
