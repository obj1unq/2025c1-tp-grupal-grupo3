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

  
  method agregar(item) {
    objetos.add(item)
    item.cambiarImagenParaInventario()
    item.setPosition(game.at(self.indiceDe(item) + 15, 0))
  
    game.addVisual(item)
    self.refrescar()
  }

  method esInvisible(){
    return false
  }

  method indiceDe(objetoBuscado) {
    return   (0..objetos.size() - 1).find({objeto => objetos.get(objeto) == objetoBuscado})  
  }

 

  method usarObjetoEn(slot) {
    self.validarSiHayObjetoEnPosicion(slot)
  
    self.interactuarConItem(self.objetoEn(slot))
  }

  method refrescar() {
      objetos.forEach({objeto =>
        game.removeVisual(objeto)
        game.addVisual(objeto)
        objeto.setPosition(game.at(self.indiceDe(objeto) + 15, 0))
      })
  }

  method validarSiHayObjetoEnPosicion(posicion) {
    if (not self.hayObjetoEn(posicion))
      self.error("No tengo ningún objeto en ese slot")
      //game.say(detective, "No tengo ningún objeto en ese slot")
  }

  method hayObjetoEn(slot) {
    return objetos.size()  > slot
  }

  method objetoEn(indice) {
    return objetos.get(indice)
  }

  method interactuarConItem(item) {
    item.usar()
    self.remover(item) 
    self.refrescar()
  }


  method itemDeInventarioEn(posicion) {
    return game.getObjectsIn(game.at(posicion, 0))//.first()
  }

  method remover(item) {
    objetos.remove(item)
    game.removeVisual(item)
   
  }




}