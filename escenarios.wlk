import direcciones.*
import cosas.*
import vecinos.*
import interactuable.*
import edificios.*
import detective.*
import inventario.*


class Escenario {
	const property protagonista 
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
		
		self.agregarVisualesDeEscenario()
		//game.addVisual(mapCubiertas)
		//game.boardGround(map)
	}

	method agregarVisualesDeEscenario(){
		game.addVisual(map)
		self.agregarVisualesVecinos()
		self.agregarVisualesCosas()
		self.agregarVisualDetective()
		game.addVisual(mapCubiertas)
	}

	method agregarVisualesVecinos() {
		vecinos.forEach({vecino => game.addVisual(vecino)})
	}

	method agregarVisualesCosas() {
		objetos.forEach({objeto => game.addVisual(objeto)})
	}

	method agregarVisualDetective(){
		//game.addVisual(protagonista)
		protagonista.actualizarVisual()
	}

	method removerVisualesDeEscenario() {
		game.removeVisual(map)
		self.removerVisualesVecinos()
		self.removerVisualesCosas()
		self.removerVisualDetective()
		game.removeVisual(mapCubiertas)
	}

	method removerVisualesVecinos() {
		vecinos.forEach({vecino => game.removeVisual(vecino)})
	}

	method removerVisualesCosas() {
		objetos.forEach({objeto => game.removeVisual(objeto)})
	}

	method removerVisualDetective(){
		game.removeVisual(protagonista)
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
		self.removerVisualesDeEscenario()
		self.escenarioEnDireccion(direccion).configurar()
	}


	// method agregarVisualesDeEscenarioVecinoEn(direccion) {
	// 	return self.escenarioEnDireccion(direccion).configurar()
	// }

	method escenarioEnDireccion(direccion){
		return escenariosVecinos.find({escenario => escenario.direccion() == direccion}).escenario()
	}

	method hayEscenarioHaciaDireccion(direccion) {
		return escenariosVecinos.any({escenario => escenario.direccion() == direccion})
	}

	method eliminarObjeto(objeto) {
		game.removeVisual(objeto)
		objetos.remove(objeto)
	}

}

class EscenarioVecino {
	const property direccion
	const property escenario   
}

class Mapa {
	const property position = game.at(0,0)
	const property image 
}


object escenarioEscolar inherits Escenario (protagonista = detective, map = mapaEscenarioEscolar, mapCubiertas = escenarioEscolarCubiertas, edificios = [jardin, 
						rejaIzquierdaJardin, rejaAbajoJardin, rejaDerechaJardin1, rejaDerechaJardin2, rejaArribaJardin, arbustoParque, arbustoParque2, 
						casaAmarillaJardin, toboganParque1, toboganParque2, toboganParque3, toboganParque4, juegoParque, puenteParque, calesitaParque, 
						autosJardin, autosJardin2, colectivoJardin, arbolJardin2, arbustoJardin, arbustoJardin2, asientoJardin, escalerasJardin, 
						escuelaParteIzq, escuelaParteMedio, escuelaParteDer, rejaIzquierda, rejaDerecha, bandera, arbustoAbajoEscuela],
						objetos = [lupa, blockNotas, collar],
						vecinos = [lucia],
						escenariosVecinos = [new EscenarioVecino(direccion = derecha, escenario = escenarioCentral) ]
						) {} 

const mapaEscenarioEscolar = new Mapa (image = "EscenarioEscolar.png")
const escenarioEscolarCubiertas = new Mapa (image = "EscenarioEscolarSombras.png")

object escenarioCentral inherits Escenario (protagonista = detective, map = mapaEscenarioCentral, mapCubiertas = escenarioCentralCubiertas, edificios = [],
						objetos = [],
						vecinos = [lucia],
						escenariosVecinos = [new EscenarioVecino(direccion = izquierda, escenario = escenarioEscolar)]						
						) {}

const mapaEscenarioCentral = new Mapa (image = "mapaCentralFINAL.png")
const escenarioCentralCubiertas = new Mapa (image = ".png")







// 	override method hayEscenarioLindanteEn(posicion) {
// 		return posicion.x() < 0
// 	} 
// }