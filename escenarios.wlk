import direcciones.*
import cosas.*
import vecinos.*
import interactuable.*


class Escenario {
	// const nombre = "nombre"
    // var objetos = [] // lista de objetos del propio escenario
    // var vecinos = [] // lista de vecinos del propio escenario
    // var escenariosVecinos = []
    // var dirSiguienteEscenario = []
	const property map = "mapa.png"

	
    method configurar(){ 	
	    game.width(38)
        game.height(20)
        game.cellSize(60) 
		//search assets in assets folder, for example, for the background
		//game.ground("fondo.jpg") //Este pone la imagen de fondo en cada celda.
		game.boardGround(map)
	}

    method existePosicion(posicion)	{
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

	method hayObstaculoEn(nuevaPos){
		return self.hayObjetoInvisibleEn(nuevaPos)
	}

	method hayObjetoInvisibleEn(nuevaPos){
		return game.getObjectsIn(nuevaPos).any({objeto => objeto.esInvisible()})
	}

	// method limpiarEscenario() {
	// 	falta remover su propio visual de mapa 
	//  [objetos, vecinos].flatten().forEach({cosa => game.removeVisual(cosa)})
	// }

	// method agregarVisualsDeEscenario() {
	// falta agregar su propio visual de mapa
	// 	[objetos, vecinos].flatten().forEach({cosa => game.addVisual(cosa)})
	// }
}

object escenarioCentro inherits Escenario (map = "map.png") { 	
		   
}

object escenarioDos inherits Escenario () { 	
		   
}