import direcciones.*
import cosas.*
import vecinos.*
import interactuable.*
import edificios.*
import detective.*
import inventario.*
import animalSalvaje.*


class Escenario {
	const property protagonista 
    const property objetos = [] 
    const property vecinos = [] 
    const property escenariosVecinos
	const property map 
	const property mapCubiertas 
	const property edificios = []
	const property iniciables = #{}

	
    method configurar(){ 	
	    game.width(38)
        game.height(20)
        game.cellSize(60) 
		
		self.agregarVisualesDeEscenario()
		//game.addVisual(mapCubiertas)
		//game.boardGround(map)
	}


	method iniciarIniciables() {
		iniciables.forEach({iniciable => iniciable.iniciar()})
	}

	method finalizarIniciables() {
		iniciables.forEach({iniciable => iniciable.finalizar()})
	}

	method agregarVisualesDeEscenario(){
		game.addVisual(map)
		self.agregarVisualesVecinos()
		self.agregarVisualesCosas()
		self.agregarVisualDetective()
		game.addVisual(mapCubiertas)
		inventario.refrescar()
		self.iniciarIniciables()
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
		self.finalizarIniciables()
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


const escenarioEscolar = new Escenario (protagonista = detective, map = mapaEscenarioEscolar, mapCubiertas = escenarioEscolarCubiertas, edificios = [jardin, 
						rejaIzquierdaJardin, rejaAbajoJardin, rejaDerechaJardin1, rejaDerechaJardin2, rejaArribaJardin, arbustoParque, arbustoParque2, 
						casaAmarillaJardin, toboganParque1, toboganParque2, toboganParque3, toboganParque4, juegoParque, puenteParque, calesitaParque, 
						autosJardin, autosJardin2, colectivoJardin, arbolJardin2, arbustoJardin, arbustoJardin2, asientoJardin, escalerasJardin, 
						escuelaParteIzq, escuelaParteMedio, escuelaParteDer, rejaIzquierda, rejaDerecha, bandera, arbustoAbajoEscuela],
						objetos = [lupa, blockNotas, collar],
						vecinos = [lucia,tomillo,juli],
						escenariosVecinos = [escenarioALaDerechaDeEscolar]
						) 
const mapaEscenarioEscolar = new Mapa (image = "EscenarioEscolar.png")
const escenarioEscolarCubiertas = new Mapa (image = "EscenarioEscolarSombras.png")
const escenarioALaDerechaDeEscolar = new EscenarioVecino (direccion = derecha, escenario = escenarioCentral)


const escenarioCentral = new Escenario (protagonista = detective, map = mapaEscenarioCentral, mapCubiertas = escenarioCentralCubiertas, 
						edificios = [arbustoAbajoIzq, autosPolicia, estacionDePolicia, arbustoAbajoMedio, paradaDeColectivo, arbustoAbajoDerecho, colectivo, fuentePlaza, 
						rejaPlazaAbajoIzq, rejaPlazaArribaIzq, rejaPlazaArribaDer, rejaPlazaAbajoDer, cocheCorreo, correo, arbolesCorreo, arbolCorreo, semaforoArribaDer, cocheNaranja, 
						arbustosArribaMedioDer, cochesAmarilloVioleta, arbustoArribaMedioIzq, cochesArribaIzq, edificiosArribaIzq, heladeria, mesaHeladeria, 
						panaderia, pescaderia, carniceria, edificio, muroArribaIzq, muroArribaDer],
						objetos = [],
						vecinos = [rami,juan,doc,vane],
						escenariosVecinos = [escenarioAIzquierdaDeCentral, escenarioANorteDeCentral]						
						) 
const mapaEscenarioCentral = new Mapa (image = "mapaCentralFINAL.png")
const escenarioCentralCubiertas = new Mapa (image = ".png")
const escenarioAIzquierdaDeCentral = new EscenarioVecino (direccion = izquierda, escenario = escenarioEscolar)
const escenarioANorteDeCentral = new EscenarioVecino (direccion = arriba, escenario = escenarioCamping)
const escenarioDerechaDeCentral = new EscenarioVecino (direccion = derecha, escenario = escenarioMercado)


const escenarioCamping = new Escenario (protagonista = detective, map = mapaEscenarioCamping, mapCubiertas = escenarioCampingCubiertas, 
										edificios = [autosAbajoIzq, autosAbajoIzqMedio, autosAbajoDerMedio, autosAbajoRaro, autosAbajoDer, carritoAbajo, 
						carritoMedio, carritoArriba, juegoEstacionamiento1, juegoEstacionamiento2, cartel, mesa, caldera /*, escalera*/, casa1, casa2, 
						casa3, arbolesBarreraIzq, arbolesBarreraDer, mesa3, mesa4, mesa5, mesa6, mesa7, mesa8, cocheComida, puesto1, puesto2, puesto3, 
						cocheComida2, mesa9, cocheComida3, mesa10, pizzeria, colectivosEstacionados, casitaPolicia, bañosPublicos, paradaColectivo, 
						arbolesArribaIzq, arbolesArribaDer, tachosGasolinera, faroDeLuz, cartelGasolinera, gasolinera, repostarGasolinera, 
						autoArribaDer, autoESquinaDer],
										objetos = [],
										vecinos = [vete,meli,nino,vale,ivan],
										escenariosVecinos = [escenarioAlSurDeCamping,escenarioAlNorteDeCamping])
const mapaEscenarioCamping = new Mapa (image = "escenarioCampingFINAL.png")
const escenarioCampingCubiertas = new Mapa (image = ".png")
const escenarioAlSurDeCamping = new EscenarioVecino (direccion = abajo, escenario = escenarioCentral)
const escenarioAlNorteDeCamping = new EscenarioVecino (direccion = arriba, escenario = escenarioBosque)


const escenarioBosque = new Escenario (protagonista = detective, map = mapaEscenarioBosque, mapCubiertas = escenarioCampingCubiertas, 
										edificios = [arbolesParedAbajoIzq, arbolesParedAbajoDer, arbolesParedIzq, arbolesParedDer, arbolesParedArriba, arbolSolitario1, 
						grupoArbolIzq, montaña1, montaña2, filaArbolesAbajoIzq, filaArbolesAbajoDer, columnaArbolesAbajoIzq, columnaArbolesAbajoDer, 
						arbolSolitario2, columnaArbolesAbajoDer, desnivel1, desnivel2, arbolSolitario3, filaArbolMedioIzq, columnaArbolMedioIzq, 
						columnaArbolMedioDer, filaArbolMedioDer, columnaArbolDer1, filaArbolArribaDer, carpas1, columnaArbolDer, carpas2, denivel3, 
						denivel4, camas, arboles, arboles1, carpas4, casaRodante],
										objetos = [oso],
										vecinos = [],
										escenariosVecinos = [escenarioAlSurDeBosque],
										iniciables = #{oso})
const mapaEscenarioBosque = new Mapa (image = "escenarioBosqueFINAL.png")
const escenarioBosqueCubiertas = new Mapa (image = ".png")
const escenarioAlSurDeBosque = new EscenarioVecino (direccion = abajo, escenario = escenarioCamping)

const escenarioMercado = new Escenario (protagonista = detective, map = mapaEscenarioMercado, mapCubiertas = escenarioMercadoCubiertas,
										edificios = [arbustosAbajo1, maquina, paradaColectivo1, arbustosAbajo2, faro, pozo, floresAbajo, floresAbajo2, pozo2, hotel, hotelArriba, paredIzq,
						paredDer, edificio1, entradaEstacionamiento, carritos, supermercado, arbolSupermercado, basuraSupermercado, elevador],
										objetos = [],
										vecinos = [],
										escenariosVecinos = [escenarioAlOesteDeMercado])

const mapaEscenarioMercado = new Mapa(image = "escenarioSuperFINAL.png")
const escenarioMercadoCubiertas = new Mapa (image = ".png")
const escenarioAlOesteDeMercado = new EscenarioVecino(direccion = izquierda, escenario = escenarioCentral)



// 	override method hayEscenarioLindanteEn(posicion) {
// 		return posicion.x() < 0
// 	} 
// }