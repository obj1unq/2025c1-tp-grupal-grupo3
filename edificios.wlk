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