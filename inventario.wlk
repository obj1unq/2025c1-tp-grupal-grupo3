import detective.*
import escenarios.*
import cosas.*
import mascota.*

object inventario {
  const property objetos = [lupa]

  
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

  method cantObjetoPistaDelInventario(){ return objetos.count{objeto => objeto.esPista()}
  }


}