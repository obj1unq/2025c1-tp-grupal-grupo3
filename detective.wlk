import edificios.*
import direcciones.*
import cosas.*
import vecinos.*
import escenarios.*
import inventario.*
import animalSalvaje.*


object detective {
  var property position = game.at(20, 8)  
  var property escenarioActual = escenarioCentral
  var property estaVivo = true 

  method puedeMoverHacia(direccion) {
    const nuevaPos = direccion.siguientePosicion(position)
    return estaVivo && !escenarioActual.hayObstaculoEn(nuevaPos)              
  }

  method saleDeEscenario(posicion, escenario) {
    return !escenario.esParteDeEscenario(posicion)
  }

  method image() {
    return "detective.png"
  }

  method moverHacia(direccion) {            
    if (self.puedeMoverHacia(direccion)) {
      position = direccion.siguientePosicion(position)
    }
  }

  method mover(direccion) {
    const nuevaPos = direccion.siguientePosicion(position)
    return if (!self.saleDeEscenario(nuevaPos, escenarioActual)) 
              self.moverHacia(direccion)
            else 
              self.moverANuevoEscenarioEn(direccion)
  }

  method moverANuevoEscenarioEn(direccion){
       if (not escenarioActual.puedeCambiarseDeEscenario(direccion)){
          self.error("No hay nada en esa direccion")
       }else{
            self.cargarNuevoEscenarioEn(direccion)
       }
  }

  method cargarNuevoEscenarioEn(direccion) {
    escenarioActual.cargarEscenarioVecinoDeDireccion(direccion)
    self.actualizarEscenario(escenarioActual.escenarioEnDireccion(direccion))
    self.actualizarPosicionANuevoEscenario(direccion)
    //self.actualizarVisual()
  }


  method actualizarEscenario(escenario) {
    escenarioActual = escenario
  }

  method actualizarVisual() {  
    game.addVisual(self)
  }

  method  actualizarPosicionANuevoEscenario(direccion) {
    position = direccion.entradaAlEscenarioDesdeBorde(position)
  }


  // method interactuar() {
  //   if (not self.hayInteractuable())
  //       game.say(self, "No hay nada acá")
  //     else
  //      self.objetoEnPosicion().interactuarCon(self)
  // }

  // method hayInteractuable() {
  //   return game.getObjectsIn(self.position()).any({element => element != self})
  // }

  method interactuar() {
    if (not self.puedeInteractuar())
        self.error("No hay nada acá")
      else
       self.objetoInteractuableCercano().interactuarCon(self)
  }

  method puedeInteractuar() {
    return self.hayInteractuableCercano() and self.objetoInteractuableCercano().sePuedeInteractuar()
  }

  method objetoInteractuableCercano() {
    const objetosEnCelda = game.getObjectsIn(self.position()).filter({obj => obj != self && obj.esIntearactuable()})
    if (!objetosEnCelda.isEmpty())
        return objetosEnCelda.first()

    return self.objetoInteractuableLindante()
  }
  
  method objetoInteractuableLindante() {
    return [arriba, derecha, abajo, izquierda]
        .map({d => game.getObjectsIn(d.siguientePosicion(position))})
        .flatten()
        .find({obj => obj.esIntearactuable()})
  }

 


 
  method hayInteractuableCercano() {
    return game.getObjectsIn(self.position()).any({element => element != self})
            ||
          self.hayInteractuableLindante()
  }

  method hayInteractuableLindante() {
    return self.hayInteractuableHacia(arriba) || self.hayInteractuableHacia(derecha) || self.hayInteractuableHacia(abajo) || self.hayInteractuableHacia(izquierda)
  }

  method hayInteractuableHacia(direccion) {
    const newPos = direccion.siguientePosicion(position)
    return game.getObjectsIn(newPos).any({objeto => objeto.esIntearactuable()})
  }

  method objetoEnPosicion() {
    return game.uniqueCollider(self)
  }

  // method cantPistas() {
  //   return inventario.objetos.count({ objeto => objeto.esPista()})
  // }
  method cantPistas() {
    return inventario.cantObjetoPistaDelInventario()
  }


  method levantarObjeto(objeto) {
    escenarioActual.eliminarObjeto(objeto)
  }

  method tieneItem(item) {
    return inventario.tieneObjeto(item)
}
  method recibirItem(item) {
      inventario.agregar(item)
  }

  method descartarItem(item) {
      inventario.remover(item)
      inventario.refrescar()

  }

  method gameOver() {
    game.removeVisual(self)
    estaVivo = false
  }

  //method xPosicion() {
  //  return  position.x()
  //}
}


    

    
  




