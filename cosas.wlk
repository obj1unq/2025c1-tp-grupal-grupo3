import interactuable.*
import detective.*
import inventario.*

// class ItemEnMapa inherits Interactuable {
//   var property position 
//   const property itemParaInventario 
//   const property imagen
//   const texto = "¡Encontré"  + "!"
//   //var estaEnElMapa = true
 
//   method setPosition(pos) {
//     position = pos
//   }

//   method image() {
//     return imagen
//   }

//   method esInvisible(){
//     return false
//   }

//   override method interactuarCon(detective) {
//     //self.validarSiSePuedeInteractuarCon(detective)
//     game.say(detective, texto)
//     inventario.agregar(itemParaInventario)
//     detective.levantarObjeto(self)
    
//   }


// }

// class ItemEnInventario inherits Interactuable{
//   var property durabilidad 
//   var property position 
//   const property itemDeMapa
//   const property imagen  
//   const texto = "¡Encontré"  + "!"
  
//   method setPosition(pos) {
//     position = pos
//   }

//   method image() {
//     return imagen
//   }

//   override method interactuarCon(detective) {
//     game.say(detective, texto)
//     inventario.agregar(self)
//     game.removeVisual(self)
   
//   }

//   method usar() {
//     self.actualizarDurabilidad()
//     self.actualizarEstadoDe()
//     game.say(detective, "Usaste " + texto)
//   }

//   method actualizarEstadoDe() {
//     if (durabilidad == 0)
//       inventario.remover(self) 
//   }

//   method actualizarDurabilidad() {
//     durabilidad = durabilidad - 1
//   }


//   method usoInfinito(){
//     return true
//   }

//   method dependeDeEscenario() {
//     return true
//   }
// }
 
// object lupa inherits ItemEnMapa (position = game.at(10,10), 
//                                 itemParaInventario = lupaDeInventario,
//                                 texto = "Encontraste una lupa",
//                                 imagen = "lupa.png"){}  

// object lupaDeInventario inherits ItemEnInventario (durabilidad = 1, 
//                                                   position = game.at(10,10), 
//                                                   itemDeMapa = lupa, 
//                                                   texto = "lupa",
//                                                   imagen = "lupa.png"){}
    
// object blockNotas inherits ItemEnMapa (position = game.at(10,6), 
//                                       itemParaInventario = blockDeInventario, 
//                                       texto = "Encontraste un block de notas",
//                                       imagen = "blockDeNotas.png"){}

// object blockDeInventario inherits ItemEnInventario (durabilidad = 100, 
//                                                     position = game.at(10,10), 
//                                                     itemDeMapa = blockNotas, 
//                                                     texto = "block usado",
//                                                     imagen = "blockDeNotas.png"){}
      
// object collar inherits ItemEnMapa (position = game.at(7,8), 
//                                   itemParaInventario = collarInventario,
//                                   texto = "Encontraste un collar",
//                                   imagen = "collar.png"){}

// object collarInventario inherits ItemEnInventario (durabilidad = 1, 
//                                                   position = game.at(10,10), 
//                                                   itemDeMapa = collar, 
//                                                   texto = "collar usado",
//                                                   imagen = "collar.png"){}
    
// object miel inherits ItemEnMapa (position = game.at(9,9), 
//                                     itemParaInventario = mielDeInventario, 
//                                     texto = "Encontraste miel",
//                                     imagen = "miel.png"){}
       
// object mielDeInventario inherits ItemEnInventario (durabilidad = 1, 
//                                                       position = game.at(10,10), 
//                                                       itemDeMapa = miel, 
//                                                       texto = "miel usada",
//                                                       imagen = "mielDeInventario.png"){}
      
// object dni inherits ItemEnInventario ( durabilidad = 1,
//                                        position = game.at(10,10),
//                                        itemDeMapa = miel,
//                                        texto = "dni usado",
//                                        imagen = "dniDeInventario.png") {}


class Item inherits Interactuable {
  var property position 
  const property imagenParaInventario
  var property imagen
  const texto  
  //const textoParaInventario = "zzzzzz!"
  var property durabilidad 
  //var estaEnElMapa = true
 
  method setPosition(pos) {
    position = pos
  }

  method image() {
    return imagen
  }

  method cambiarImagenParaInventario() {
    imagen = imagenParaInventario
  }


  // method cambiarATextoParaInventario() {
  //   texto = textoParaInventario
  // }


  method esInvisible(){
    return false
  }

  override method interactuarCon(detective) {
    game.say(detective, "Encontré " + texto)
    detective.levantarObjeto(self)
    inventario.agregar(self)
    
  }


  method usar() {
    self.actualizarDurabilidad()
    self.actualizarEstadoDe()
    game.say(detective, "Usé " + texto)
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

  method dependeDeEscenario() {
    return true
  }
}


const lupa = new Item (position = game.at(10,10), 
                          imagenParaInventario = "lupa.png",
                          texto = "una lupa",
                          imagen = "lupa.png",
                          durabilidad = 1)

const blockNotas = new Item (position = game.at(15,6), 
                            imagenParaInventario = "blockDeNotas.png", 
                            texto = "un block de notas",
                            imagen = "blockDeNotas.png",
                            durabilidad = 10)
 
const collar = new Item (position = game.at(7,8), 
                        imagenParaInventario = "collar.png",
                        texto = "un collar",
                        imagen = "collar.png",
                        durabilidad = 1)

    
const miel = new Item (position = game.at(9,9), 
                      imagenParaInventario = "mielFINAL.png", 
                      texto = "miel",
                      imagen = "mielFINAL.png",
                      durabilidad = 1)
         
const dni = new Item (position = game.at(10,10),
                      imagenParaInventario = "dniFINAL.png",
                      texto = "un dni usado",
                      imagen = "dniFINAL.png",
                      durabilidad = 1)

const llave = new Item (position = game.at(10,10),
                      imagenParaInventario = "llaveFINAL.png",
                      texto = "un dni usado",
                      imagen = "llaveFINAL.png",
                      durabilidad = 1)

const linterna = new Item (position = game.at(10,10),
                      imagenParaInventario = "linternaFINAL.png",
                      texto = "un dni usado",
                      imagen = "linternaFINAL.png",
                      durabilidad = 1)

const puaGuitarra = new Item (position = game.at(8,6),
                      imagenParaInventario = "puaInventarioFINAL.png",
                      texto = "la pua de Rami",
                      imagen = "puaFINAL.png",
                      durabilidad = 1)

const transportadora = new Item (position = game.at(10,10),
                      imagenParaInventario = "transportadoraVaciaFINAL.png",
                      texto = "un dni usado",
                      imagen = "transportadoraVaciaFINAL.png",
                      durabilidad = 1)

const burbujero = new Item (position = game.at(23,16),
                      imagenParaInventario = "burbujeroInventarioFINAL.png",
                      texto = "el burbujero de juli",
                      imagen = "burbujeroFINAL.png",
                      durabilidad = 1)

const hoja = new Item (position = game.at(10,10),
                      imagenParaInventario = "hojaFINAL.png",
                      texto = "un dni usado",
                      imagen = "hojaFINAL.png",
                      durabilidad = 1)

const caramelos = new Item (position = game.at(10,10),
                      imagenParaInventario = "caramelosFINAL.png",
                      texto = "un dni usado",
                      imagen = "caramelosFINAL.png",
                      durabilidad = 1)

const moneda = new Item (position = game.at(10,10),
                      imagenParaInventario = "monedaFINAL.png",
                      texto = "un dni usado",
                      imagen = "monedaFINAL.png",
                      durabilidad = 1)



