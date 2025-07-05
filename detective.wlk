import direcciones.*
import cosas.*
import vecinos.*
import escenarios.*
import inventario.*
import animalSalvaje.*


object detective {
  var property position = game.at(17, 9)  
  var property escenarioActual = escenarioBosque

  method puedeMoverHacia(direccion) {
    const nuevaPos = direccion.siguientePosicion(position)
    return !escenarioActual.hayObstaculoEn(nuevaPos)              
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
       if (not escenarioActual.hayEscenarioHaciaDireccion(direccion)){
          game.say(self, "No hay nada en esa direccion")
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


  method interactuar() {
    //const objetoEnPosicion = self.objetoEnPosicion()
    // self.validarSiHayInteractuable()
    // self.objetoEnPosicion().interactuarCon(self)
    if (not self.hayInteractuable())
        game.say(self, "No hay nada acá")
      else
       self.objetoEnPosicion().interactuarCon(self)
  }
 
  // method validarSiHayInteractuable() {
  //   if(not self.hayInteractuable()) {
  //     game.say(self, "No hay nada acá")
  //   }
  // }

  method hayInteractuable() {
    return game.getObjectsIn(self.position()).any({element => element != self})
  }

  
  method objetoEnPosicion() {
    return game.uniqueCollider(self)
  }

  method cantPistas() {
    return inventario.objetos.sum({ objeto => objeto.esPista()})
  }

  method levantarObjeto(objeto) {
    escenarioActual.eliminarObjeto(objeto)
  }

  method tieneMiel() {
    //return inventario.objetos().contains(miel)
    return false
}

  //method xPosicion() {
  //  return  position.x()
  //}
}


    

    
  




