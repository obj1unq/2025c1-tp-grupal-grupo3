import detective.*
import escenarios.*
import cosas.*
import mascota.*



// object inventario {
//   const property objetos = []
//   const property position = game.at(12, 0)
//   var posicionSlotDisponible = 15 

//   method agregar(item) {
//     self.validarAgregar()
//     self.agregarVisual(item)
//     objetos.add(item)
//     self.incrementarPosicionSlotDisponible()
//   }

//   method esInvisible(){
//     return false
//   }

//   method agregarVisual(item) {
//     item.setPosition(game.at(posicionSlotDisponible, 0))
//     game.addVisual(item)
//   }

//   method validarAgregar() {
//     if (not self.haySlotDisponible())
//       self.error("No hay lugar en el inventario")
//   }

//   method haySlotDisponible() {
//     return posicionSlotDisponible <= 10
//   }
//   method incrementarPosicionSlotDisponible() {
//     posicionSlotDisponible = posicionSlotDisponible + 1
//   }

//   method remover(item) {
//     objetos.remove(item)
//     game.removeVisual(item)
//     self.actualizarPosicionDisponible()
//   }

//   method actualizarPosicionDisponible() {
//     posicionSlotDisponible = posicionSlotDisponible - 1
//   }

//   method usarObjetoEn(_posicionSlotDisponible) {
//     self.validarSiHayObjetoEnPosicion(_posicionSlotDisponible)
//     self.interactuarConItemDeInventarioEn(self.itemDeInventarioEn(_posicionSlotDisponible))

//   }

//   method validarSiHayObjetoEnPosicion(_posicionSlotDisponible) {
//     if (not self.hayObjetoEn(_posicionSlotDisponible))
//       self.error("No tengo ningún objeto en ese slot")
//   }

//   method hayObjetoEn(_posicionSlotDisponible) {
//     return not game.getObjectsIn(game.at(_posicionSlotDisponible, 0)).isEmpty()
//   }

//   method interactuarConItemDeInventarioEn(item) {
//     item.usar()
//   }

//   method itemDeInventarioEn(_posicionSlotDisponible) {
//     return game.getObjectsIn(game.at(_posicionSlotDisponible, 0)).first()
//   }

//   method refrescar() {
//       objetos.forEach({ objeto =>
//         game.removeVisual(objeto)
//         game.addVisual(objeto)
//       })
//   }
// }



object inventario {
  const property objetos = []
  var indice = 15 

  

  method agregar(item) {
    
    objetos.add(item)
    item.cambiarImagenParaInventario()
    item.setPosition(game.at(indice, 0))

    indice = indice + 1
    self.refrescar()
  }

  method esInvisible(){
    return false
  }

  // method usarObjetoEn(posicionSlot) {
  //   self.validarSiHayObjetoEnPosicion(posicionSlot)
  //   self.interactuarConItemDeInventarioEn(self.objetoEn(posicionSlot))
  // }

  method usarObjetoEn(_posicionSlotDisponible) {
    self.validarSiHayObjetoEnPosicion(_posicionSlotDisponible)
    self.interactuarConItemDeInventarioEn(self.itemDeInventarioEn(_posicionSlotDisponible))
  }



  method refrescar() {
      objetos.forEach({objeto =>
        game.removeVisual(objeto)
        game.addVisual(objeto)
      })
  }

  method validarSiHayObjetoEnPosicion(posicionSlot) {
    if (not self.hayObjetoEn(posicionSlot))
      //self.error("No tengo ningún objeto en ese slot")
      game.say(detective, "No tengo ningún objeto en ese slot")
  }

  method hayObjetoEn(posicionSlot) {
    return not game.getObjectsIn(game.at(posicionSlot, 0)).isEmpty()
    
  }


  method objetoEn(posicionSlot) {
    return objetos.get(posicionSlot)
  }

  method interactuarConItemDeInventarioEn(item) {
    item.usar()
    self.remover(item)
    
  }

  

  method actualizarPosicionDisponible() {
    indice = indice - 1
  }

  method itemDeInventarioEn(_posicionSlotDisponible) {
    return game.getObjectsIn(game.at(_posicionSlotDisponible, 0)).first()
  }

  method remover(item) {
    objetos.remove(item)
    game.removeVisual(item)
    
    self.refrescar()
  }


  // method agregarVisual(item) {
  //   item.setPosition(game.at(posicionSlotDisponible, 0))
  //   game.addVisual(item)
  // }

  // method validarAgregar() {
  //   if (not self.haySlotDisponible())
  //     self.error("No hay lugar en el inventario")
  // }

  // method haySlotDisponible() {
  //   return posicionSlotDisponible <= 10
  // }
  // method incrementarPosicionSlotDisponible() {
  //   posicionSlotDisponible = posicionSlotDisponible + 1
  // }

  // method remover(item) {
  //   objetos.remove(item)
  //   game.removeVisual(item)
  //   self.actualizarPosicionDisponible()
  // }

  // method actualizarPosicionDisponible() {
  //   posicionSlotDisponible = posicionSlotDisponible - 1
  // }

  // method usarObjetoEn(_posicionSlotDisponible) {
  //   self.validarSiHayObjetoEnPosicion(_posicionSlotDisponible)
  //   self.interactuarConItemDeInventarioEn(self.itemDeInventarioEn(_posicionSlotDisponible))

  // }

  // method validarSiHayObjetoEnPosicion(_posicionSlotDisponible) {
  //   if (not self.hayObjetoEn(_posicionSlotDisponible))
  //     self.error("No tengo ningún objeto en ese slot")
  // }

  // method hayObjetoEn(_posicionSlotDisponible) {
  //   return not game.getObjectsIn(game.at(_posicionSlotDisponible, 0)).isEmpty()
  // }

  // method interactuarConItemDeInventarioEn(item) {
  //   item.usar()
  // }

  // method itemDeInventarioEn(_posicionSlotDisponible) {
  //   return game.getObjectsIn(game.at(_posicionSlotDisponible, 0)).first()
  // }

  

}