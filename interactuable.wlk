import detective.*
class Interactuable {
  method interactuarCon(detective) {}
  method sePuedeMostarEnInventario() { return false}
  
}

class ObjetoInvisible {
  const property posicion
  
  method esInvisible(){
    return true
  }

  method image() {
    return "objetoinvisible.png"
  }

  method position() {
    return posicion
  }
}


class Edificio {
  var  vertice = game.at(1,2) 
  var  alto = 3
  var  ancho = 4

  method pertenece(posicion){
    return self.perteneceX(posicion.x()) and self.perteneceY(posicion.y()) 
  } 

  method perteneceX(x){return x.between(vertice.x(), vertice.x() + (ancho -1))}

  method perteneceY(y){return y.between(vertice.y() , vertice.y() + (alto - 1))}
}
object panaderia inherits Edificio(vertice = game.at(1,2), alto = 3, ancho = 4) {}

object pizzeria inherits Edificio(vertice = game.at(3,2), alto = 2, ancho = 5) {}

object inventarioVisual inherits Edificio(vertice = game.at(15,0),alto = 1,ancho = 9){}

object gimnasio inherits Edificio(vertice = game.at(12,1.5), alto = 3 , ancho = 8 ){}

object casetaTelefono inherits Edificio(vertice = game.at(22,1.5), alto = 2, ancho = 1) {}

object casaAmarilla inherits Edificio(vertice = game.at(25,1.5), alto = 3.5, ancho = 2){}

object heladeria inherits Edificio(vertice = game.at(29,1.5), alto = 4, ancho = 5) {}

object plazaHeladeria inherits Edificio(vertice = game.at(33,1.5), alto = 2, ancho = 3  ){}

object ciudad {
  const edificiosDeLaCiudad = [panaderia,pizzeria,inventarioVisual,gimnasio,casetaTelefono,casaAmarilla,heladeria,plazaHeladeria]

  method puedoIr(position){
    return not edificiosDeLaCiudad.any({edificio => edificio.pertenece(position)})
  }

}


