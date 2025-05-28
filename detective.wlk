import direcciones.*
import cosas.*
import vecinos.*
import escenarios.*
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

  method puedeMover(direccion) {
    const nuevaPos = direccion.siguientePosicion(position)
    return escenarioCentro.existe(nuevaPos)
}

  method image() {
    return "detective.png"
  }

  method mover(direccion) {
    if(self.puedeMover(direccion)) {
      position = direccion.siguientePosicion(position)
    }
  }


  // IMPLEMENTACION DE OBSTACULOS Y ESCENARIOS (
  // method mover(direccion) {
  //   if (not self.hayCondicionesParaCambiarEscenario(direccion)) {
  //     const posicion = self.position()
  //     nivel.cambiarEscenario(direccion)
  //     self.ubicarADetectiveEnEscenario(posicion) //posicionar al detective en la entrada de dicho escenario 
  //   } else {
  //     self.validarMoverADireccion(direccion)
  //   }
  // }

  // method ubicarADetectiveEnEscenario(posicion) {
  //   position = nivel.bordeOpuestoDe(posicion)
  // }

  // method hayCondicionesParaCambiarEscenario(direccion) {
  //   return self.estaEnElBorde(direccion) and nivel.hayEscenarioEnDireccion(direccion)
  // }

  // method estaEnElBorde(direccion) {
  //   return not self.puedeMover(direccion)
  // }

  // method validarMoverADireccion(direccion) {
  //   if (self.puedeMover(direccion)) {
  //     position = direccion.siguientePosicion(position)
  //   }
  // }
  
  // method puedeMover(direccion) {
  //   return nivel.hayCondicionesParaMover(self, direccion.siguientePosicion(position))
  // }
  // )


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

}

object inventario {
  const property objetos = []
  const property position = game.at(12, 0)

   method agregar(cosa) {
     objetos.add(cosa)
  }

  method remover(cosa) {
    objetos.remove(cosa)
  }

  method visualizarInventario() {
    var indice = 0
    objetos.forEach({ cosa =>
      self.visualizarEnInventario(cosa, indice)
      indice = indice + 1
    })
  }

  method usarObjetoEn(indice) {
    if (indice < objetos.size()) {
      const objeto = objetos.get(indice)
    if (objeto.puedeUsar()) {
      objeto.usar()
    } else {
      game.say(detective, "Este objeto no se puede usar ahora.")
    }
  } else {
    game.say(detective, "No hay objeto en ese lugar.")
  }
}


// [[], [],[] ] const espadaActual = find(espada)
// count(objeto espada)add(espadaActual)
// remove(espadaActual
// espadaActual = 0
// mostrar(espada)
// cosa().mostrar()

// ocultar() // indice += 1 mostrar
// )
 /* game.addVisual(espada)
  espada.image() espada.text()""*/

  method visualizarEnInventario(cosa, indice) {
    const copiaVisual = object {
    const position = game.at(indice +  15, 0)

    method position() { return position }
    method image() { return cosa.mostrarEnInventario() }
  }
  game.addVisual(copiaVisual)
}

/*method text() = "(" + position.x() + ", " + position.y() + ")"
method color() = "#ff0378"*/
  // method image() {
  //     return "inventario.png"
  // }
}
/*method text() = "(" + position.x() + ", " + position.y() + ")"
method color() = "#ff0378"*/
    

    
  




