import interactuable.*
import detective.*
import inventario.*
import escenarios.*


class Item inherits Interactuable {
  var property position 
  const property imagenParaInventario
  var property imagen
  const texto  
  var property durabilidad 
  const property esPista  
  
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

  override method sePuedeInteractuar() {
    return not detective.tieneItem(self)
  }
}

class ItemConInformacion inherits Item {
  const property imgagenAMostrar 

  override method usar(){
    if (not imgagenAMostrar.estaVisible()){
        super()
        game.addVisual(imgagenAMostrar)
        imgagenAMostrar.ponerVisible()
    }else{
        game.removeVisual(imgagenAMostrar)
        imgagenAMostrar.ponerInvisible()
    }
  }

}

class ItemEspecial inherits Item {
  override method sePuedeInteractuar() {
    return detective.tieneItem(bocadillos) and detective.tieneItem(transportadoraVacia)
  }

  override method interactuarCon(detective) {
    self.sacarObjetosNecesario()
    super(detective)
  }

  method sacarObjetosNecesario() {
    inventario.remover(bocadillos)
    inventario.remover(transportadoraVacia)
  }

  override method usar() {
    game.say(detective, "Lo tengo que llevar con la dueña")
  }
}

class ImagenAMostrar {
  const property image
  const property position 
  var property esVisible = false  

  method estaVisible() {
    return esVisible
  }

  method ponerVisible(){
    esVisible = true
  }
  method ponerInvisible(){
    esVisible = false
  }

}



const lupa = new Item (position = game.at(10,10), 
                          imagenParaInventario = "lupaFINAL.png",
                          texto = "una lupa",
                          imagen = "lupaFINAL.png",
                          durabilidad = 10000,
                          esPista = false)

const blockNotas = new Item (position = game.at(15,6), 
                            imagenParaInventario = "blockDeNotasFINAL.png", 
                            texto = "un block de notas",
                            imagen = "blockDeNotasFINAL.png",
                            durabilidad = 10000,
                            esPista = true)
 
const collar = new Item (position = game.at(7,8), 
                        imagenParaInventario = "collarFINAL.png",
                        texto = "un collar celeste",
                        imagen = "collarFINAL.png",
                        durabilidad = 10000,
                        esPista = true)

    
const miel = new Item (position = game.at(9,9), 
                      imagenParaInventario = "mielFINAL.png", 
                      texto = "miel",
                      imagen = "mielFINAL.png",
                      durabilidad = 10,
                      esPista = false)
         
const dni = new Item (position = game.at(10,10),
                      imagenParaInventario = "dniFINAL.png",
                      texto = "un dni usado",
                      imagen = "dniFINAL.png",
                      durabilidad = 10000,
                      esPista = false)

const llave = new Item (position = game.at(10,10),
                      imagenParaInventario = "llaveFINAL.png",
                      texto = "una llave usada",
                      imagen = "llaveFINAL.png",
                      durabilidad = 10000,
                      esPista = false)

const linterna = new Item (position = game.at(10,10),
                      imagenParaInventario = "linternaFINAL.png",
                      texto = "una linterna usada",
                      imagen = "linternaFINAL.png",
                      durabilidad = 10000,
                      esPista = false)

const puaGuitarra = new Item (position = game.at(8,6),
                      imagenParaInventario = "puaInventarioFINAL.png",
                      texto = "la pua de Rami",
                      imagen = "puaFINAL.png",
                      durabilidad = 10000,
                      esPista = false)

const transportadoraVacia = new Item (position = game.at(10,10),
                      imagenParaInventario = "transportadoraVaciaFINAL.png",
                      texto = "una transportadora vacía",
                      imagen = "transportadoraVaciaFINAL.png",
                      durabilidad = 10000,
                      esPista = true)

const burbujero = new Item (position = game.at(23,16),
                      imagenParaInventario = "burbujeroFINAL.png",
                      texto = "el burbujero de juli",
                      imagen = "burbujeroFINAL.png",
                      durabilidad = 10000,
                      esPista = false)

const hoja = new ItemConInformacion (position = game.at(10,10),
                      imagenParaInventario = "hojaFINAL.png",
                      texto = "el dibujo",
                      imagen = "hojaFINAL.png",
                      durabilidad = 10000,
                      esPista = true,
                      imgagenAMostrar = fotoGrande)
const fotoGrande = new ImagenAMostrar (image = "fotoGrande.png", position = game.at(13,1))

const caramelos = new Item (position = game.at(10,10),
                      imagenParaInventario = "caramelosFINAL.png",
                      texto = "unos caramelos",
                      imagen = "caramelosFINAL.png",
                      durabilidad = 10000,
                      esPista = false)

const moneda = new Item (position = game.at(10,10),
                      imagenParaInventario = "monedaFINAL.png",
                      texto = "una moneda",
                      imagen = "monedaFINAL.png",
                      durabilidad = 100000,
                      esPista = false)

const bocadillos = new Item (position = game.at(10,10),
                      imagenParaInventario = "bocadilloFINAL.png",
                      texto = "un bocadillo",
                      imagen = "bocadilloFINAL.png",
                      durabilidad = 100000,
                      esPista = true)

const pelos = new Item (position = game.at(10,10),
                      imagenParaInventario = "pelosDeMorenaFINAL.png",
                      texto = "pelos de gato",
                      imagen = "pelosDeMorenaFINAL.png",
                      durabilidad = 100000,
                      esPista = true)

const credencial = new Item (position = game.at(10,10),
                      imagenParaInventario = "credencialFINAL.png",
                      texto = "una credencial",
                      imagen = "credencialFINAL.png",
                      durabilidad = 100000,
                      esPista = false)

const morena = new ItemEspecial(position = posibleAparicion.randomized().first(),
                      imagenParaInventario = "transportadoraConMichiFINAL.png",
                      texto = "tengo a la gata, debo llevarla a su dueña",
                      imagen = "morenaFINAL.png",
                      durabilidad = 100000,
                      esPista = false)

const flores = new Item(position = null,
                        imagenParaInventario = "floresFINAL.png",
                        texto = "unas flores muy lindas",
                        imagen = "floresFINAL.png",
                        durabilidad = 11110,
                        esPista = false)

const arnes = new Item( position = null,
                        imagenParaInventario = "arnesFINAL.png",
                        texto = "un arnes azul",
                        imagen = "arnesFINAL.png",
                        durabilidad = 11110,
                        esPista = true)

const posibleAparicion = [game.at(1,17), game.at(32,17), game.at(26,11)]

const grafitiEscenarioEscolar = new Grafiti (position = game.at(3,6), texto = "Parece que hay huellas que van hacia el este")
const grafitiEscenarioCentral1 = new Grafiti (position = game.at(13,17), texto = "Las huellas parecen ir hacia el tacho de basura")
const grafitiEscenarioCentral2 = new Grafiti (position = game.at(35,7), texto = "Parece que hay huellas que van hacia el norte")
const basureroEscenarioCentral = new Basurero (position = game.at(28,17), texto = "Hay algo dentro del tacho de basura")



