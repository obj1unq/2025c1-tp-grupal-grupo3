import direcciones.*
import cosas.*
import vecinos.*
import escenarios.*
import inventario.*
import animalSalvaje.*

//import obstaculo.*

//object nivel{
	// const npcs = #{viudaNegra} 
  // const objetos = #{correa, comidaDeGAto, comidaDePerro}
	
// 	method configurarTablero(){
// 	  game.title("Detective de mascotas")
//     game.boardGround("mapa.png") 	
// 	  game.width(38)
//     game.height(20)
//     game.cellSize(60)
// 		//search assets in assets folder, for example, for the background
// 		//game.ground("fondo.jpg") //Este pone la imagen de fondo en cada celda.
// 	}

// 	// method finalizar(){
// 	// 	game.schedule(2000, { game.stop() })
// 	// }
	
// 	method existe(posicion)	{
// 		return self.existeX(posicion.x()) && self.existeY(posicion.y())
// 	}

// 	method enLimite(coord, max){
// 		return coord.between(0, max - 1) 
// 	}

// 	method existeX(x){
// 		return self.enLimite(x, game.width())
// 		// x >= 0 && x <= game.width() - 1
// 	} 

// 	method existeY(y){
// 		return self.enLimite(y, game.height())
// 		//y.between(0, game.height() - 1) 
// 		// x >= 0 && x <= game.width() - 1
// 	}
// } 


  // CONDICIONES PARA ESCENARIO (
  // method hayEscenarioEnDireccion(direccion) {
  //   return escenarioActual.tieneVecinoAl(direccion)
  // }


  // method cambiarEscenarioA(direccion) {
  //   const escenarioAPoner = self.escenarioEnDireccion(direccion)
  //   escenarioActual.limpiarEscenario() //sacar visuals del escenario
  //   escenarioAPoner.agregarVisualsDeEscenario() //agregar visuals del nuevo escenario
  // }

  // method escenarioEnDireccion(direccion) {
  //   return vecinos.identificarEscenarioACambiar(self, direccion)
  // }
  //)


  // UBICAR A DETECTIVE EN ESCEANRIO (
  // method bordeOpuestoDe(coordenada) {
  //   if (not self.existeX(coordenada)) {
  //     return self.opuestoDeBordeY(coordenada)
  //   } else {
  //     return self.opuestoDeBordeX(coordenada)
  //   }
  // }

  // method opuestoDeBordeY(coordenada) {
  //   return game.at(coordenada.x(), game.height() - coordenada.y())
  // }

  // method opuestoDeBordeX(coordenada) {
  //   return game.at(game.width() - coordenada.x(), coordenada.y())
  // }
  //)

  // CONDICIONES CONTEMPLANDO OBSTACULOS (
  // method hayCondicionesParaMover(personaje, posicion) {
  //   return self.existe(posicion) and self.puedeTransitar(personaje, posicion)
  // }

  // method puedeTransitar(personaje, posicion) {
  //   return game.getObjectsIn(posicion).copyWithout(personaje).all({visual => visual.esTransitable()}) // el copyWithout personaje lo saca de la lista de objetos que hay en la posicion dada
  // }
  // )
//}


object detective {
  var property position = game.at(17, 9)  // El detective empieza en (3, 3)
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
       if (escenarioActual.hayEscenarioHaciaDireccion(direccion))
          escenarioActual.cargarEscenarioVecinoDeDireccion(direccion)
          self.actualizarEscenario(escenarioActual.escenarioEnDireccion(direccion))
          self.actualizarPosicionANuevoEscenario(direccion)
          self.actualizarVisual()
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
    self.validarSiHayInteractuable()
    self.objetoEnPosicion().interactuarCon(self)
  }
 
  method validarSiHayInteractuable() {
    if(not self.hayInteractuable()) {
      game.say(self, "No hay nada acá")
    }
  }

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

  //method xPosicion() {
  //  return  position.x()
  //}
}


    

    
  




