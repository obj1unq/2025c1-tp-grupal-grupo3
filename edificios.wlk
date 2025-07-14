import wollok.game.*
import detective.*
import direcciones.*
import cosas.*
import vecinos.*
import interactuable.*
import escenarios.*


class Edificio {
  const property vertice
  const property  alto 
  const property  ancho 

  method pertenece(posicion){
    return self.perteneceX(posicion.x()) and self.perteneceY(posicion.y()) 
  } 

  method perteneceX(x){return x.between(vertice.x(), vertice.x() + (ancho -1))}

  method perteneceY(y){return y.between(vertice.y() , vertice.y() + (alto - 1))}

  method dependeDeEscenario() {
    return true
  }
}

  

//Escenario parque-jardin
object jardin inherits Edificio(vertice = game.at(2, 16), alto = 3, ancho = 4) {}
object rejaIzquierdaJardin inherits Edificio(vertice = game.at(2, 13), alto = 3, ancho = 1) {}
object rejaAbajoJardin inherits Edificio(vertice = game.at(4, 13), alto = 1, ancho = 10) {}
object rejaDerechaJardin1 inherits Edificio(vertice = game.at(13, 14), alto = 2, ancho = 1) {}
object rejaDerechaJardin2 inherits Edificio(vertice = game.at(13, 17), alto = 2, ancho = 1) {}
object rejaArribaJardin inherits Edificio(vertice = game.at(5, 18), alto = 1, ancho = 8) {}
object arbustoParque inherits Edificio(vertice = game.at(2,2), alto = 1, ancho = 11) {}
object arbustoParque2 inherits Edificio(vertice = game.at(12,4), alto = 4, ancho = 1) {}
object casaAmarillaJardin inherits Edificio(vertice = game.at(8,17), alto = 1, ancho = 1) {}
object toboganParque1 inherits Edificio(vertice = game.at(9,5), alto = 1, ancho = 3) {}
object toboganParque2 inherits Edificio(vertice = game.at(4,4), alto = 1, ancho = 1) {}
object toboganParque3 inherits Edificio(vertice = game.at(3,6), alto = 1, ancho = 1) {}
object toboganParque4 inherits Edificio(vertice = game.at(4,9), alto = 1, ancho = 2) {}
object juegoParque inherits Edificio(vertice = game.at(9,7), alto = 1, ancho = 2) {}
object puenteParque inherits Edificio(vertice = game.at(7,9), alto = 1, ancho = 4) {}
object calesitaParque inherits Edificio(vertice = game.at(6,6), alto = 1, ancho = 1) {}
object arbolParque inherits Edificio(vertice = game.at(2,12), alto = 1, ancho = 1) {}
object autosJardin inherits Edificio(vertice = game.at(19,2), alto = 1, ancho = 4) {}
object autosJardin2 inherits Edificio(vertice = game.at(19,6), alto = 2, ancho = 4) {}
object colectivoJardin inherits Edificio(vertice = game.at(28,6), alto = 1, ancho = 3) {}
object arbolJardin2 inherits Edificio(vertice = game.at(18,9), alto = 8, ancho = 1) {} 
object arbustoJardin inherits Edificio(vertice = game.at(19,9), alto = 1, ancho = 4) {} 
object arbustoJardin2 inherits Edificio(vertice = game.at(33,9), alto = 1, ancho = 2) {} 
object asientoJardin inherits Edificio(vertice = game.at(18,12), alto = 3, ancho = 1) {}
object escalerasJardin inherits Edificio(vertice = game.at(27,10), alto = 1, ancho = 5) {} 
object escuelaParteIzq inherits Edificio(vertice = game.at(20,12), alto = 4, ancho = 3) {} 
object escuelaParteMedio inherits Edificio(vertice = game.at(23,13), alto = 3, ancho = 2) {} 
object escuelaParteDer inherits Edificio(vertice = game.at(24,12), alto = 6, ancho = 12) {} 
object bandera inherits Edificio(vertice = game.at(23,10), alto = 1, ancho = 1) {} 
object rejaIzquierda inherits Edificio(vertice = game.at(19,17), alto = 1, ancho = 10) {} 
object rejaDerecha inherits Edificio(vertice = game.at(35,9), alto = 3, ancho = 1) {} 
object arbustoAbajoEscuela inherits Edificio(vertice = game.at(28,1), alto = 1, ancho = 8) {}

//Escenario Centro (principal)
object arbustoAbajoIzq inherits Edificio(vertice = game.at(2,1), alto = 1, ancho = 5) {}
object autosPolicia inherits Edificio(vertice = game.at(8,1), alto = 3, ancho = 4) {}
object estacionDePolicia inherits Edificio(vertice = game.at(2,5), alto = 5, ancho = 10) {}
object arbustoAbajoMedio inherits Edificio(vertice = game.at(13,3), alto = 1, ancho = 3) {}
object paradaDeColectivo inherits Edificio(vertice = game.at(17,3), alto = 1, ancho = 4) {}
object arbustoAbajoDerecho inherits Edificio(vertice = game.at(22,3), alto = 1, ancho = 4) {}
object colectivo inherits Edificio(vertice = game.at(23,2), alto = 1, ancho = 4) {}
object fuentePlaza inherits Edificio(vertice = game.at(19,7), alto = 1, ancho = 1) {}
object rejaPlazaAbajoIzq inherits Edificio(vertice = game.at(13,5), alto = 2, ancho = 5) {}
object rejaPlazaArribaIzq inherits Edificio(vertice = game.at(13,8), alto = 2, ancho = 5) {}
object rejaPlazaArribaDer inherits Edificio(vertice = game.at(21,8), alto = 2, ancho = 5) {}
object rejaPlazaAbajoDer inherits Edificio(vertice = game.at(21,5), alto = 2, ancho = 5) {}
object cocheCorreo inherits Edificio(vertice = game.at(32,2), alto = 1, ancho = 4) {}
object correo inherits Edificio(vertice = game.at(30,5), alto = 4, ancho = 5) {}
object arbolesCorreo inherits Edificio(vertice = game.at(35,5), alto = 2, ancho = 1) {}
object arbolCorreo inherits Edificio(vertice = game.at(35,8), alto = 1, ancho = 1) {}
object semaforoArribaDer inherits Edificio(vertice = game.at(35,12), alto = 1, ancho = 1) {}
object cocheNaranja inherits Edificio(vertice = game.at(32,12), alto = 1, ancho = 3) {}
object arbustosArribaMedioDer inherits Edificio(vertice = game.at(26,12), alto = 1, ancho = 5) {}
object cochesAmarilloVioleta inherits Edificio(vertice = game.at(18,12), alto = 1, ancho = 7) {}
object arbustoArribaMedioIzq inherits Edificio(vertice = game.at(14,12), alto = 1, ancho = 4) {}
object cochesArribaIzq inherits Edificio(vertice = game.at(4,12), alto = 1, ancho = 9) {}
object edificiosArribaIzq inherits Edificio(vertice = game.at(3,15), alto = 4, ancho = 7) {}
object heladeria inherits Edificio(vertice = game.at(10,16), alto = 3, ancho = 3) {}
object mesaHeladeria inherits Edificio(vertice = game.at(12,15), alto = 1, ancho = 1) {}
object panaderia inherits Edificio(vertice = game.at(15,16), alto = 3, ancho = 4) {}  
object pescaderia inherits Edificio(vertice = game.at(23,16), alto = 3, ancho = 4) {}  
object carniceria inherits Edificio(vertice = game.at(28,16), alto = 3, ancho = 4) {}  
object edificio inherits Edificio(vertice = game.at(32,15), alto = 3, ancho = 3) {}
object muroArribaIzq inherits Edificio(vertice = game.at(2,18), alto = 1, ancho = 18) {}  
object muroArribaDer inherits Edificio(vertice = game.at(22,18), alto = 1, ancho = 14) {}  


//Escenario Camping
object autosAbajoIzq inherits Edificio(vertice = game.at(2,1), alto = 2, ancho = 3) {}  
object autosAbajoIzqMedio inherits Edificio(vertice = game.at(9,1), alto = 2, ancho = 6) {}  
object autosAbajoDerMedio inherits Edificio(vertice = game.at(24,1), alto = 2, ancho = 3) {}  
object autosAbajoRaro inherits Edificio(vertice = game.at(28,1), alto = 2, ancho = 3) {}  
object autosAbajoDer inherits Edificio(vertice = game.at(33,1), alto = 2, ancho = 3) {}  
object carritoAbajo inherits Edificio(vertice = game.at(37,1), alto = 1, ancho = 1) {}  
object carritoMedio inherits Edificio(vertice = game.at(37,4), alto = 1, ancho = 1) {}
object carritoArriba inherits Edificio(vertice = game.at(37,6), alto = 1, ancho = 1) {}
object juegoEstacionamiento1 inherits Edificio(vertice = game.at(4,4), alto = 2, ancho = 2) {}
object juegoEstacionamiento2 inherits Edificio(vertice = game.at(8,4), alto = 1, ancho = 3) {}
object cartel inherits Edificio(vertice = game.at(7,3), alto = 1, ancho = 1) {}
object mesa inherits Edificio(vertice = game.at(2,7), alto = 1, ancho = 2) {}
object caldera inherits Edificio(vertice = game.at(7,7), alto = 1, ancho = 1) {}
//object escalera inherits Edificio(vertice = game.at(11,8), alto = 1, ancho = 1) {}
object casa1 inherits Edificio(vertice = game.at(1,9), alto = 1, ancho = 3) {}
object casa2 inherits Edificio(vertice = game.at(6,9), alto = 1, ancho = 3) {}
object casa3 inherits Edificio(vertice = game.at(11,9), alto = 1, ancho = 4) {}
object arbolesBarreraIzq inherits Edificio(vertice = game.at(0,10), alto = 1, ancho = 15) {}
object arbolesBarreraDer inherits Edificio(vertice = game.at(20,10), alto = 1, ancho = 18) {}
object mesa3 inherits Edificio(vertice = game.at(20,4), alto = 1, ancho = 2) {}
object mesa4 inherits Edificio(vertice = game.at(24,4), alto = 1, ancho = 1) {}
object mesa5 inherits Edificio(vertice = game.at(27,4), alto = 1, ancho = 2) {}
object mesa6 inherits Edificio(vertice = game.at(29,4), alto = 1, ancho = 1) {}
object mesa7 inherits Edificio(vertice = game.at(30,4), alto = 1, ancho = 2) {}
object mesa8 inherits Edificio(vertice = game.at(33,4), alto = 1, ancho = 2) {}
object cocheComida inherits Edificio(vertice = game.at(20,6), alto = 1, ancho = 3) {}
object puesto1 inherits Edificio(vertice = game.at(27,6), alto = 1, ancho = 2) {}
object puesto2 inherits Edificio(vertice = game.at(30,6), alto = 1, ancho = 2) {}
object puesto3 inherits Edificio(vertice = game.at(33,6), alto = 1, ancho = 2) {}
object cocheComida2 inherits Edificio(vertice = game.at(20,9), alto = 1, ancho = 4) {}
object mesa9 inherits Edificio(vertice = game.at(24,9), alto = 1, ancho = 3) {}
object cocheComida3 inherits Edificio(vertice = game.at(28,9), alto = 1, ancho = 3) {}
object mesa10 inherits Edificio(vertice = game.at(32,9), alto = 1, ancho = 2) {}
object pizzeria inherits Edificio(vertice = game.at(34,9), alto = 1, ancho = 3) {}
object colectivosEstacionados inherits Edificio(vertice = game.at(8,13), alto = 3, ancho = 5) {}
object casitaPolicia inherits Edificio(vertice = game.at(0,16), alto = 2, ancho = 3) {}
object bañosPublicos inherits Edificio(vertice = game.at(3,17), alto = 1, ancho = 2) {}
object paradaColectivo inherits Edificio(vertice = game.at(9,17), alto = 1, ancho = 2) {}
object arbolesArribaIzq inherits Edificio(vertice = game.at(0,18), alto = 2, ancho = 16) {}
object arbolesArribaDer inherits Edificio(vertice = game.at(19,18), alto = 1, ancho = 19) {}
object tachosGasolinera inherits Edificio(vertice = game.at(20,17), alto = 1, ancho = 2) {}
object faroDeLuz inherits Edificio(vertice = game.at(20,13), alto = 1, ancho = 1) {}
object cartelGasolinera inherits Edificio(vertice = game.at(21,13), alto = 1, ancho = 1) {}
object gasolinera inherits Edificio(vertice = game.at(22,16), alto = 2, ancho = 8) {}
object repostarGasolinera inherits Edificio(vertice = game.at(24,14), alto = 1, ancho = 4) {}
object autoArribaDer inherits Edificio(vertice = game.at(34,15), alto = 2, ancho = 2) {}
object autoESquinaDer inherits Edificio(vertice = game.at(37,15), alto = 2, ancho = 1) {}

//escenario bosque

//arbolesParedAbajoIzq, arbolesParedAbajoDer, arbolesParedIzq, arbolesParedDer, arbolesParedArriba, arbolSolitario1, grupoArbolIzq,
//montaña1, montaña2, filaArbolesAbajoIzq, filaArbolesAbajoDer, columnaArbolesAbajoIzq, columnaArbolesAbajoDer, arbolSolitario2
//columnaArbolesAbajoDer,
object arbolesParedAbajoIzq inherits Edificio(vertice = game.at(0,0), alto = 1, ancho = 15) {}
object arbolesParedAbajoDer inherits Edificio(vertice = game.at(24,0), alto = 1, ancho = 14) {}
object arbolesParedIzq inherits Edificio(vertice = game.at(0,1), alto = 19, ancho = 1) {}
object arbolesParedDer inherits Edificio(vertice = game.at(37,1), alto = 19, ancho = 1) {}
object arbolesParedArriba inherits Edificio(vertice = game.at(1,19), alto = 1, ancho = 36) {}
object arbolSolitario1 inherits Edificio(vertice = game.at(30,18), alto = 1, ancho = 1) {}
object grupoArbolIzq inherits Edificio(vertice = game.at(1,13), alto = 2, ancho = 6) {}
object montaña1 inherits Edificio(vertice = game.at(7,15), alto = 1, ancho = 5) {}
object montaña2 inherits Edificio(vertice = game.at(18,15), alto = 1, ancho = 6) {}
object filaArbolesAbajoIzq inherits Edificio(vertice = game.at(6,3), alto = 1, ancho = 10) {}
object filaArbolesAbajoDer inherits Edificio(vertice = game.at(21,3), alto = 1, ancho = 12) {}
object columnaArbolesAbajoIzq inherits Edificio(vertice = game.at(6,4), alto = 6, ancho = 1) {}
object arbolSolitario2 inherits Edificio(vertice = game.at(10,6), alto = 1, ancho = 1) {}
object columnaArbolesAbajoDer inherits Edificio(vertice = game.at(32,4), alto = 3, ancho = 1) {}
// sigo
//desnivel1, desnivel2, arbolSolitario3, filaArbolMedioIzq, columnaArbolMedioIzq, columnaArbolMedioDer, filaArbolMedioDer, columnaArbolDer1,
//filaArbolArribaDer, carpas1, columnaArbolDer, carpas2, denivel3, denivel4, camas, arboles
object desnivel1 inherits Edificio(vertice = game.at(11,7), alto = 1, ancho = 18) {}
object desnivel2 inherits Edificio(vertice = game.at(30,7), alto = 1, ancho = 7) {}
object arbolSolitario3 inherits Edificio(vertice = game.at(15,8), alto = 1, ancho = 1) {}
object filaArbolMedioIzq inherits Edificio(vertice = game.at(7,9), alto = 1, ancho = 5) {}
object columnaArbolMedioIzq inherits Edificio(vertice = game.at(11,10), alto = 3, ancho = 1) {}
object columnaArbolMedioDer inherits Edificio(vertice = game.at(18,10), alto = 3, ancho = 1) {}
object filaArbolMedioDer inherits Edificio(vertice = game.at(19,9), alto = 1, ancho = 7) {}
object columnaArbolDer1 inherits Edificio(vertice = game.at(25,10), alto = 4, ancho = 1) {}
object filaArbolArribaDer inherits Edificio(vertice = game.at(26,13), alto = 1, ancho = 11) {}
object carpas1 inherits Edificio(vertice = game.at(26,11), alto = 1, ancho = 4) {}
object columnaArbolDer inherits Edificio(vertice = game.at(31,9), alto = 4, ancho = 1) {}
object carpas2 inherits Edificio(vertice = game.at(32,11), alto = 1, ancho = 5) {}
object denivel3 inherits Edificio(vertice = game.at(12,12), alto = 1, ancho = 3) {}
object denivel4 inherits Edificio(vertice = game.at(16,12), alto = 1, ancho = 2) {}
object camas inherits Edificio(vertice = game.at(23,11), alto = 2, ancho = 1) {}
object arboles inherits Edificio(vertice = game.at(24,14), alto = 2, ancho = 1) {}
object arboles1 inherits Edificio(vertice = game.at(30,14), alto = 1, ancho = 1) {}
object carpas4 inherits Edificio(vertice = game.at(32,17), alto = 1, ancho = 4) {}
object casaRodante inherits Edificio(vertice = game.at(1,17), alto = 1, ancho = 3) {}

//escenarioSuper
//arbustosAbajo1, maquina, paradaColectivo1, arbustosAbajo2, faro, pozo, floresAbajo, floresAbajo2, pozo2, hotel, hotelArriba, paredIzq
//paredDer, edificio1, entradaEstacionamiento, carritos, supermercado, arbolSupermercado, basuraSupermercado, elevador
object arbustosAbajo1 inherits Edificio(vertice = game.at(3,1), alto = 1, ancho = 3) {}
object maquina inherits Edificio(vertice = game.at(8,1), alto = 1, ancho = 1) {}
object paradaColectivo1 inherits Edificio(vertice = game.at(15,1), alto = 1, ancho = 2) {}
object arbustosAbajo2 inherits Edificio(vertice = game.at(17,1), alto = 1, ancho = 4) {}
object faro inherits Edificio(vertice = game.at(26,1), alto = 1, ancho = 1) {}
object pozo inherits Edificio(vertice = game.at(27,2), alto = 1, ancho = 2) {}
object floresAbajo inherits Edificio(vertice = game.at(27,1), alto = 1, ancho = 3) {}
object floresAbajo2 inherits Edificio(vertice = game.at(34,1), alto = 1, ancho = 3) {}
object pozo2 inherits Edificio(vertice = game.at(34,2), alto = 1, ancho = 2) {}
object hotel inherits Edificio(vertice = game.at(27,4), alto = 4, ancho = 9) {}
object hotelArriba inherits Edificio(vertice = game.at(27,14), alto = 3, ancho = 9) {}
object paredIzq inherits Edificio(vertice = game.at(1,5), alto = 1, ancho = 9) {}
object paredDer inherits Edificio(vertice = game.at(11,5), alto = 1, ancho = 10) {}
object edificio1 inherits Edificio(vertice = game.at(2,4), alto = 1, ancho = 4) {}
object entradaEstacionamiento inherits Edificio(vertice = game.at(15,13), alto = 2, ancho = 4) {}
object carritos inherits Edificio(vertice = game.at(4,12), alto = 2, ancho = 2) {}
object supermercado inherits Edificio(vertice = game.at(4,15), alto = 3, ancho = 8) {}
object arbolSupermercado inherits Edificio(vertice = game.at(1,14), alto = 1, ancho = 1) {}
object basuraSupermercado inherits Edificio(vertice = game.at(3,16), alto = 2, ancho = 1) {}
object elevador inherits Edificio(vertice = game.at(12,17), alto = 1, ancho = 2) {}