import interactuable.*
import detective.*
import inventario.*


class Item inherits Interactuable {
  var property position 
  const property imagenParaInventario
  var property imagen
  const texto  
  var property durabilidad 
  var property enInventario 
  
  method setPosition(pos) {
    position = pos
  }

  method image() {
    return imagen
  }

  method cambiarImagenParaInventario() {
    imagen = imagenParaInventario
  }


  method esInvisible(){
    return false
  }

  override method interactuarCon(detective) {
    game.say(detective, "Encontré " + texto)
    detective.levantarObjeto(self)
    inventario.agregar(self)
    self.marcarComoEnInventario()
  }

  method marcarComoEnInventario() {
    enInventario = true
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

  override method puedeInteractuar() {
    return not enInventario
  }
}


const lupa = new Item (position = game.at(10,10), 
                          imagenParaInventario = "lupa.png",
                          texto = "una lupa",
                          imagen = "lupa.png",
                          durabilidad = 1,
                      enInventario = false)

const blockNotas = new Item (position = game.at(15,6), 
                            imagenParaInventario = "blockDeNotas.png", 
                            texto = "un block de notas",
                            imagen = "blockDeNotas.png",
                            durabilidad = 10,
                      enInventario = false)
 
const collar = new Item (position = game.at(7,8), 
                        imagenParaInventario = "collar.png",
                        texto = "un collar",
                        imagen = "collar.png",
                        durabilidad = 1,
                      enInventario = false)

    
const miel = new Item (position = game.at(9,9), 
                      imagenParaInventario = "mielFINAL.png", 
                      texto = "miel",
                      imagen = "mielFINAL.png",
                      durabilidad = 1,
                      enInventario = false)
         
const dni = new Item (position = game.at(10,10),
                      imagenParaInventario = "dniFINAL.png",
                      texto = "un dni usado",
                      imagen = "dniFINAL.png",
                      durabilidad = 1,
                      enInventario = false)

const llave = new Item (position = game.at(10,10),
                      imagenParaInventario = "llaveFINAL.png",
                      texto = "un dni usado",
                      imagen = "llaveFINAL.png",
                      durabilidad = 1,
                      enInventario = false)

const linterna = new Item (position = game.at(10,10),
                      imagenParaInventario = "linternaFINAL.png",
                      texto = "un dni usado",
                      imagen = "linternaFINAL.png",
                      durabilidad = 1,
                      enInventario = false)

const puaGuitarra = new Item (position = game.at(8,6),
                      imagenParaInventario = "puaInventarioFINAL.png",
                      texto = "la pua de Rami",
                      imagen = "puaFINAL.png",
                      durabilidad = 1,
                      enInventario = false)

const transportadora = new Item (position = game.at(10,10),
                      imagenParaInventario = "transportadoraVaciaFINAL.png",
                      texto = "un dni usado",
                      imagen = "transportadoraVaciaFINAL.png",
                      durabilidad = 1,
                      enInventario = false)

const burbujero = new Item (position = game.at(23,16),
                      imagenParaInventario = "burbujeroInventarioFINAL.png",
                      texto = "el burbujero de juli",
                      imagen = "burbujeroFINAL.png",
                      durabilidad = 1,
                      enInventario = false)

const hoja = new Item (position = game.at(10,10),
                      imagenParaInventario = "hojaFINAL.png",
                      texto = "un dni usado",
                      imagen = "hojaFINAL.png",
                      durabilidad = 1,
                      enInventario = false)

const caramelos = new Item (position = game.at(10,10),
                      imagenParaInventario = "caramelosFINAL.png",
                      texto = "un dni usado",
                      imagen = "caramelosFINAL.png",
                      durabilidad = 1,
                      enInventario = false)

const moneda = new Item (position = game.at(10,10),
                      imagenParaInventario = "monedaFINAL.png",
                      texto = "un dni usado",
                      imagen = "monedaFINAL.png",
                      durabilidad = 1,
                      enInventario = false)

const credencial = new Item (position = game.at(10,10),
                      imagenParaInventario = "credencial.png",
                      texto = "una credencial",
                      imagen = "credencial.png",
                      durabilidad = 100000,
                      enInventario = true)

