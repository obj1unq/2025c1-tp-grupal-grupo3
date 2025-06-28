import direcciones.*
import cosas.*
import vecinos.*
import interactuable.*
import edificios.*


class Escenario {
	
    const property objetos = [] 
    const property vecinos = [] 
    const property escenariosVecinos
	const property map 
	const property mapCubiertas 
	const property edificios = []

	
    method configurar(){ 	
	    game.width(38)
        game.height(20)
        game.cellSize(60) 
		game.addVisual(mapCubiertas) 
		game.boardGround(map)
	}


	// method saleDelJuego(posicion) {
	// 	return !self.esParteDeEscenario(posicion) && !self.hayEscenarioLindanteEn(posicion)
	// }

	// method existePosicion(posicion)	{
	// 	return self.existeX(posicion.x()) && self.existeY(posicion.y())
	// }

	method esParteDeEscenario(posicion)	{
		return self.existeX(posicion.x()) && self.existeY(posicion.y())
	}


	//method hayEscenarioLindanteEn(posicion)

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

	// method hayObstaculoEn(nuevaPos){
	// 	return self.hayObjetoInvisibleEn(nuevaPos) 
	// }

	method hayObstaculoEn(nuevaPos){
        return self.hayObjetoInvisibleEn(nuevaPos) || self.hayEdificio(nuevaPos)
    }

    method hayEdificio(position){
        return edificios.any({edificio => edificio.pertenece(position)})
      }

	method hayObjetoInvisibleEn(nuevaPos){
		return game.getObjectsIn(nuevaPos).any({objeto => objeto.esInvisible()})
	}


	method cargarEscenarioVecinoDeDireccion(direccion){
		self.limpiarEscenario()
		self.agregarVisualesDeEscenarioVecinoEn(direccion)
	}

	method limpiarEscenario() {
		//falta remover su propio visual de mapa 
	 //[objetos, vecinos].flatten().forEach({cosa => game.removeVisual(cosa)}) // esto hay que modificar
	}

	method agregarVisualesDeEscenarioVecinoEn(direccion) {
		return self.escenarioEnDireccion(direccion).configurar()
	}

	method escenarioEnDireccion(direccion){
		return escenariosVecinos.find({escenario => escenario.direccion() == direccion}).escenario()
	}

	method hayEscenarioHaciaDireccion(direccion) {
		return escenariosVecinos.any({escenario => escenario.direccion() == direccion})
	}

}

class EscenarioVecino {
	const property direccion
	const property escenario   
}


object escenarioEscolar inherits Escenario ( map = "EscenarioEscolar.png", mapCubiertas = escenarioEscolarCubiertas, edificios = [jardin, 
						rejaIzquierdaJardin, rejaAbajoJardin, rejaDerechaJardin1, rejaDerechaJardin2, rejaArribaJardin, arbustoParque, arbustoParque2, 
						casaAmarillaJardin, toboganParque1, toboganParque2, toboganParque3, toboganParque4, juegoParque, puenteParque, calesitaParque, 
						autosJardin, autosJardin2, colectivoJardin, arbolJardin2, arbustoJardin, arbustoJardin2, asientoJardin, escalerasJardin, 
						escuelaParteIzq, escuelaParteMedio, escuelaParteDer, rejaIzquierda, rejaDerecha, bandera, arbustoAbajoEscuela],
						objetos = [lupa, blockNotas, collar],
						vecinos = [lucia],
						escenariosVecinos = [new EscenarioVecino(direccion = derecha, escenario = escenarioCentral) ]
						) {} 

object escenarioEscolarCubiertas {
	method position() {
		return game.at(0,0)
	}
	method image() {
		return "EscenarioEscolarSombras.png"
	}
}

object escenarioCentral inherits Escenario ( map = "escenarioCentral.png", mapCubiertas = escenarioCentralCubiertas, edificios = [],
						objetos = [lupa, blockNotas, collar],
						vecinos = [lucia],
						escenariosVecinos = [new EscenarioVecino(direccion = izquierda, escenario = escenarioEscolar)]						

						) {}

object escenarioCentralCubiertas {
	method position() {
		return game.at(0,0)
	}
	method image() {
		return ".png"
	}
}



// 	override method hayEscenarioLindanteEn(posicion) {
// 		return posicion.x() < 0
// 	} 
// }