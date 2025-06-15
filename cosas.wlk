import interactuable.*
import detective.*

class ItemEnMapa inherits Interactuable {
  var property position 
  const property itemParaInventario 
  const texto = "¡Encontré"  + "!"
  //var estaEnElMapa = true
 
  method setPosition(pos) {
    position = pos
  }

  method image() 

  override method interactuarCon(detective) {
    //self.validarSiSePuedeInteractuarCon(detective)
    game.say(detective, texto)
    inventario.agregar(itemParaInventario)
    game.removeVisual(self)
    
    //self.estaEnElMapa(false)
  }

  // method validarSiSePuedeInteractuarCon(detective) {
  //   if (not self.fueRemovidoDelMapa())
  // }

  // method estaEnElMapa() {
  //   return estaEnElMapa
  // }

  // method estaEnElMapa(_estado) {
  //   estaEnElMapa = _estado
  // }

}

class ItemEnInventario inherits Interactuable{
  var property durabilidad 
  var property position 
  const property itemDeMapa 
  const texto = "¡Encontré"  + "!"
  const usoInfinito 
  
  method setPosition(pos) {
    position = pos
  }

  method image()

  override method interactuarCon(detective) {
    game.say(detective, texto)
    inventario.agregar(self)
    game.removeVisual(self)
   
  }

  method puedeUsar() {
    return usoInfinito || durabilidad > 0
  }

  method usar() {
    game.say(detective, "Usaste " + texto)
    if (self.puedeUsar()) {
      durabilidad = durabilidad - 1
      inventario.remover(self)
    }
  }

  method usoInfinito(){
    return usoInfinito
  }

}
 
object lupa inherits ItemEnMapa (position = game.at(10,10), itemParaInventario = lupaDeInventario,
                    texto = "Encontraste una lupa"){               
      override method image(){
        return "lupa.png"
      }
}  

object lupaDeInventario inherits ItemEnInventario (durabilidad = 100, usoInfinito = true, position = game.at(10,10), itemDeMapa = lupa, 
                                texto = "lupa usada" ){
      override method image(){
        return "lupa2.png"
      }
}


object blockNotas inherits ItemEnMapa (position = game.at(0,0), itemParaInventario = blockDeInventario, 
                           texto = "Encontraste un block de notas"){
      override method image(){
        return "blockDeNotas.png"
      }
}

object blockDeInventario inherits ItemEnInventario (durabilidad = 100, usoInfinito = true, position = game.at(10,10), itemDeMapa = blockNotas, 
                                texto = "block usado"){
      override method image(){
        return "blockDeNotas2.png"
      }
}

object collar inherits ItemEnMapa(position = game.at(7,8), itemParaInventario = collarInventario,
                       texto = "Encontraste un collar"){
      override method image(){
        return "collar.png"
      }    
}

object collarInventario inherits ItemEnInventario (durabilidad = 100, usoInfinito = true, position = game.at(10,10), itemDeMapa = collar, 
                                texto = "collar usado"){
      override method image(){
        return "collar2.png"
      }  
}


// object bocadillo inherits ItemEnMapa(position = game.at(9,9), imagenEnMapa = "collar.png", texto = "Encontraste un bocadillo"){
// }





