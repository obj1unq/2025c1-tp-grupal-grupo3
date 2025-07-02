import interactuable.*
import detective.*
import inventario.*

class ItemEnMapa inherits Interactuable {
  var property position 
  const property itemParaInventario 
  const property imagen
  const texto = "¡Encontré"  + "!"
  //var estaEnElMapa = true
 
  method setPosition(pos) {
    position = pos
  }

  method image() {
    return imagen
  }

  method esInvisible(){
    return false
  }

  override method interactuarCon(detective) {
    //self.validarSiSePuedeInteractuarCon(detective)
    game.say(detective, texto)
    inventario.agregar(itemParaInventario)
    detective.levantarObjeto(self)
    
  }


}

class ItemEnInventario inherits Interactuable{
  var property durabilidad 
  var property position 
  const property itemDeMapa
  const property imagen  
  const texto = "¡Encontré"  + "!"
  
  method setPosition(pos) {
    position = pos
  }

  method image() {
    return imagen
  }

  override method interactuarCon(detective) {
    game.say(detective, texto)
    inventario.agregar(self)
    game.removeVisual(self)
   
  }

  method usar() {
    self.actualizarDurabilidad()
    self.actualizarEstadoDe()
    game.say(detective, "Usaste " + texto)
  }

  method actualizarEstadoDe() {
    if (durabilidad == 0)
      inventario.remover(self) 
  }

  method actualizarDurabilidad() {
    durabilidad = durabilidad - 1
  }


  method usoInfinito(){
    return true
  }
}
 
object lupa inherits ItemEnMapa (position = game.at(10,10), 
                                itemParaInventario = lupaDeInventario,
                                texto = "Encontraste una lupa",
                                imagen = "lupa.png"){}  

object lupaDeInventario inherits ItemEnInventario (durabilidad = 1, 
                                                  position = game.at(10,10), 
                                                  itemDeMapa = lupa, 
                                                  texto = "lupa",
                                                  imagen = "lupa2.png"){}
    
object blockNotas inherits ItemEnMapa (position = game.at(10,6), 
                                      itemParaInventario = blockDeInventario, 
                                      texto = "Encontraste un block de notas",
                                      imagen = "blockDeNotas.png"){}

object blockDeInventario inherits ItemEnInventario (durabilidad = 100, 
                                                    position = game.at(10,10), 
                                                    itemDeMapa = blockNotas, 
                                                    texto = "block usado",
                                                    imagen = "blockDeNotas2.png"){}
      
object collar inherits ItemEnMapa (position = game.at(7,8), 
                                  itemParaInventario = collarInventario,
                                  texto = "Encontraste un collar",
                                  imagen = "collar.png"){}

object collarInventario inherits ItemEnInventario (durabilidad = 1, 
                                                  position = game.at(10,10), 
                                                  itemDeMapa = collar, 
                                                  texto = "collar usado",
                                                  imagen = "collar2.png"){}
    
object bocadillo inherits ItemEnMapa (position = game.at(9,9), 
                                    itemParaInventario = bocadilloEnInventario, 
                                    texto = "Encontraste un bocadillo",
                                    imagen = "bocadillo.png"){}
       
object bocadilloEnInventario inherits ItemEnInventario (durabilidad = 1, 
                                                      position = game.at(10,10), 
                                                      itemDeMapa = bocadillo, 
                                                      texto = "bocadillo usado",
                                                      imagen = "bocadillo2.png"){}
      





