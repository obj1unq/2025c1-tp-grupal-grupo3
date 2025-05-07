import direcciones.*
import cosas.*
import vecinos.*
//import obstaculo.*

object nivel{
	// const npcs = #{viudaNegra} 
  // const objetos = #{correa, comidaDeGAto, comidaDePerro}
	
	method configurarTablero(){
	game.title("Detective de mascotas")
    game.boardGround("city.png") 	
	game.width(20)
    game.height(20)
    game.cellSize(50)
		//search assets in assets folder, for example, for the background
		//game.ground("fondo.jpg") //Este pone la imagen de fondo en cada celda.
	}

	// method finalizar(){
	// 	game.schedule(2000, { game.stop() })
	// }
	
	method existe(posicion)	{
		return self.existeX(posicion.x()) && self.existeY(posicion.y())
	}

	method enLimite(coord, max){
		return coord.between(0, max - 1) 
	}

	method existeX(x){
		return self.enLimite(x, game.width())
		// x >= 0 && x <= game.width() - 1
	} 

	method existeY(y){
		return self.enLimite(y, game.height())
		//y.between(0, game.height() - 1) 
		// x >= 0 && x <= game.width() - 1
	} 
}


object detective {
  var property position = game.at(0, 0)  // El detective empieza en (3, 3)

  method puedeMover(direccion) {
    const nuevaPos = direccion.siguientePosicion(position)
    return nivel.existe(nuevaPos)
}

  method image() {
    return "detective.png"
  }

  method mover(direccion) {
    if(self.puedeMover(direccion)) {
      position = direccion.siguientePosicion(position)
    }
  }

  method interactuar() {
    //const objetoEnPosicion = self.objetoEnPosicion()
    self.validarHayObjeto()
    self.objetoEnPosicion().interactuarCon(self)
  }
 
  method validarHayObjeto() {
    if(not self.hayObjeto()) {
      game.say(self, "No hay nada acá")
    }
  }

  method hayObjeto() {
    return game.getObjectsIn(self.position()).any({element => element != self})
  }

  // method interactuar() {
  //   const objetoEnPosicion = self.objetoEnPosicion()
  //   objetoEnPosicion.interactuarCon(self)
  // }

  method objetoEnPosicion() {
    return game.uniqueCollider(self)
  }

  method cantPistas() {
    return 
  }


}




