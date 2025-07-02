import detective.*
import escenarios.*
import cosas.*
import mascota.*



object inventario {
  const property objetos = []
  const property position = game.at(12, 0)
  var posicionSlotDisponible = 15 

  method agregar(item) {
    self.validarAgregar()
    self.agregarVisual(item)
    objetos.add(item)
    self.incrementarPosicionSlotDisponible()
  }

  method esInvisible(){
    return false
  }

  method agregarVisual(item) {
    item.setPosition(game.at(posicionSlotDisponible, 0))
    game.addVisual(item)
  }

  method validarAgregar() {
    if (not self.haySlotDisponible())
      self.error("No hay lugar en el inventario")
  }

  method haySlotDisponible() {
    return posicionSlotDisponible <= 1000
  }
  method incrementarPosicionSlotDisponible() {
    posicionSlotDisponible = posicionSlotDisponible + 1
  }

  method remover(item) {
    objetos.remove(item)
    game.removeVisual(item)
    self.actualizarPosicionDisponible()
  }

  method actualizarPosicionDisponible() {
    posicionSlotDisponible = posicionSlotDisponible - 1
  }

  method usarObjetoEn(_posicionSlotDisponible) {
    self.validarSiHayObjetoEnPosicion(_posicionSlotDisponible)
    self.interactuarConItemDeInventarioEn(self.itemDeInventarioEn(_posicionSlotDisponible))

  }

  method validarSiHayObjetoEnPosicion(_posicionSlotDisponible) {
    if (not self.hayObjetoEn(_posicionSlotDisponible))
      self.error("No tengo ningún objeto en ese slot")
  }

  method hayObjetoEn(_posicionSlotDisponible) {
    return not game.getObjectsIn(game.at(_posicionSlotDisponible, 0)).isEmpty()
  }

  method interactuarConItemDeInventarioEn(item) {
    item.usar()
  }

  method itemDeInventarioEn(_posicionSlotDisponible) {
    return game.getObjectsIn(game.at(_posicionSlotDisponible, 0)).first()
  }

}