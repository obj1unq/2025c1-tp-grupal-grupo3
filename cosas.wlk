import interactuable.*
import detective.*



class Item inherits Interactuable{
  var property durabilidad = 0
  var property position = game.at(1,1)
  const imagenEnMapa = "cosa.png"
  const imagenEnInventario = "cosa2.png"
  const texto = "¡Encontré"  + "!"
  const usoInfinito = true
  
  
  method setPosition(pos) {
    position = pos
  }

  method image() {
    return imagenEnMapa
  }

  override method interactuarCon(detective) {
    game.say(detective, texto)
    inventario.agregar(self)
    game.removeVisual(self)
    inventario.visualizarInventario()
  }

  method mostrarEnInventario(){
    return imagenEnInventario

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

  method respuestaItem()  //PREGUNTAR
  
}
 



object lupa inherits Item (position = game.at(10,10), imagenEnMapa = "lupa.png", imagenEnInventario = "lupaMaisGrandeDuMundo.png", texto = "Encontraste una lupa"){

  override method respuestaItem() {
    game.addVisual("huella.png")
  }

}  

object blockNotas inherits Item(position = game.at(0,0), imagenEnMapa = "blockDeNotas.png", texto = "Encontraste un block de notas") {

  override method respuestaItem() {

  }
}

object collar inherits Item(position = game.at(7,8), imagenEnMapa = "collar.png", texto = "Encontraste un collar"){

  override method respuestaItem() { // que hago en este caso?
    
  }
}

object bocadillo inherits Item(position = game.at(9,9), imagenEnMapa = "collar.png", texto = "Encontraste un bocadillo"){

  override method respuestaItem(){

  }
}





