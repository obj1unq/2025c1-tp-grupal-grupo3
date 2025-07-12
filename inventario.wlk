import detective.*
import escenarios.*
import cosas.*
import mascota.*

object inventario {
  const property objetos = [lupa]

  method agregar(item) {
    self.validarSiSePuedeAgregarAlInventario(item)
    self.agregarAInventarioConSlotDisponibles(item)
  }

  method validarSiSePuedeAgregarAlInventario(item) {
    if (not self.haySlotDisponible())
      self.error("No puedo llevar mas objetos")
  }

  method haySlotDisponible() {
    return self.cantidadDeObjetos() < 10
  }
  method cantidadDeObjetos() {
    return objetos.size()
  }

  method agregarAInventarioConSlotDisponibles(item) {
    game.removeVisual(item)
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

  method abrir() {
    objetos.forEach({item => item.prepararParaSoltar()})
    game.say(detective, "El inventario está abierto")
  }

  method cerrar() {
    return objetos.forEach({item => item.fijarAInventario()})
  }

  method interactuarEnPosicion(slot) {
    if (self.itemEn(slot).estaPreparadoParaSoltar()){
        self.soltarObjetoEn(slot)
        self.cerrar()
    }else{
      self.usarObjetoEn(slot)
    }   
  }

  method itemEn(slot) {
    return self.objetoEn(slot)
  }

  method usarObjetoEn(slot) {
    self.validarSiHayObjetoEnPosicion(slot)
    self.interactuarConItem(self.objetoEn(slot))
  }

  method refrescar() {
      objetos.forEach({objeto =>
        game.removeVisual(objeto)
        objeto.setPosition(game.at(self.indiceDe(objeto) + 15, 0))
        game.addVisual(objeto)
        
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
    //self.remover(item) 
    self.refrescar()
  }

  method itemDeInventarioEn(posicion) {
    return game.getObjectsIn(game.at(posicion, 0))//.first()
  }

  method remover(item) {
    objetos.remove(item)
    game.removeVisual(item)
    self.refrescar()
   
  }

  method tieneObjeto(objeto) {
    return objetos.contains(objeto)
  }

  method cantObjetoPistaDelInventario() {
    return objetos.count({objeto => objeto.esPista()})
  }

  method soltarObjetoEn(slot) {
    self.validarSiHayObjetoEnPosicion(slot)
    self.tirar(self.objetoEn(slot))
  }

  method tirar(item) {
    self.remover(item)
    item.setPosition(detective.position())
    detective.objetosDeEscenarioActual().add(item)
    game.addVisual(item)
    self.refrescar()
  }

}