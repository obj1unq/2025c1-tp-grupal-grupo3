import detective.*
import wollok.game.*
import interactuable.*

class Vecino inherits Interactuable{
    const posicionDelVecino
    const  imagenDelVecino 
    const dialogo 
    var property text = ""


    method position() {
      return posicionDelVecino
    } 

    method image() {
      return imagenDelVecino
    }

    method hablar() {
      dialogo.hablar(self)
    }

    override method interactuarCon(detective) {
    self.hablar()
  }
  
    // override method sePuedeMostarEnInventario() {
    //   return false
    // }

  method esInvisible(){
    return false
  }

    
} 

class Dialogo {
  const lineasDelVecino = []
  var indice = 0
  var vecino = null

  method hablar(_vecino) {
     //Necesito cambiar cada tres segundos el dialogo hasta finalizar
      indice = 0
      vecino = _vecino
      self.cambiarDialogo()
      game.onTick(3000, "hablar", {self. cambiarDialogo()})
    }

  method cambiarDialogo() {
      if (indice < lineasDelVecino.size()){
        game.say(vecino,(lineasDelVecino.get(indice)))
        //vecino.text(lineasDelVecino.get(indice))
        indice += 1 }
      else {
         vecino.text("")
         game.removeTickEvent("hablar")
        }      
    }
}


//DEFINICION DEL DIALOGO EN LUCIA:
const dialogosDeLucia = ["Hola, Necesito tu ayuda", "Se perdió MICHI, mi gatito", "No puedo estar sin Michi", "Michi tiene un collar celeste", "Te agradeceria que lo encuentres"] 
const dialogoDeTomillo = ["Hola,soy Tomillo", "Pero me dice Tomi", "¿Estas buscando una mascota?", "Podrias ir al Camping para ver", "Capaz encontras algo"] 
const dialogoDeJuli = ["No molestes", "No me importan tus busquedas","Andá a un veterinario"]
const dialogoDeRami = ["¿Ya pediste ayuda en la policia?", "Escuché que son buenos ayudando"]
const dialogoDeJuan = ["Rami te dijo de ir a la policia","Eso es bueno", "Pero si vas al camping","andá con cuidado","Es temporada de osos"]
const dialogoDelDoc = ["Vine al correo para enviar algo","Que bueno que te encuentro","Lucia me dijo que estás buscando","A su querido gato","Ese gato es travieso y le gusta la basura"]
const dialogoDeLaVete = ["Hola Detective","Veo que estás en busqueda","El camping es un buen lugar para buscar","¿Tenes todo lo necesario?"]
const dialogoDeMeli = ["Detective! siga las pistas!","Y no se olvide su lupa", "Voy por un helado"]
const dialogoNino = ["Mi mamá dice que estas buscando un gato","Yo vi uno en el camping"]
const dialogoDeVale = ["Buena suerte en el bosque, Detective"]
const dialogoDeIvan = ["jmm","Los animales son dificiles", "¿tenés comida?","Eso puede ayudar"]
const dialogoDeVane = ["Hola Dect","¿Necesita informacion?", "¿Una licencia?"]

//CREO EL DIALOGO COMO INSTANCIA DE LA CLASE A LA QUE PERTENECE
const dialogo1 = new Dialogo(lineasDelVecino = dialogosDeLucia)
const dialogo2 = new Dialogo( lineasDelVecino = dialogoDeTomillo)
const dialogo3 = new Dialogo( lineasDelVecino = dialogoDeJuli)
const dialogo4 = new Dialogo( lineasDelVecino = dialogoDeRami)
const dialogo5 = new Dialogo( lineasDelVecino = dialogoDeJuan)
const dialogo6 = new Dialogo( lineasDelVecino = dialogoDelDoc)
const dialogo7 = new Dialogo( lineasDelVecino = dialogoDeLaVete)
const dialogo8 = new Dialogo( lineasDelVecino = dialogoDeMeli)
const dialogo9 = new Dialogo( lineasDelVecino = dialogoNino)
const dialogo10 = new Dialogo( lineasDelVecino = dialogoDeVale)
const dialogo11 = new Dialogo( lineasDelVecino = dialogoDeIvan)
const dialogo12 = new Dialogo( lineasDelVecino = dialogoDeVane)

//CREO A LUCIA COMO TAL LO QUE ES : UN VECINO 
const lucia = new Vecino (posicionDelVecino = game.at(2, 4), imagenDelVecino = "luciaRed.png", dialogo = dialogo1 )
const tomillo = new Vecino(posicionDelVecino = game.at(10,16), imagenDelVecino = "scoutRed.png", dialogo = dialogo2)
const juli = new Vecino(posicionDelVecino = game.at(27, 7),imagenDelVecino = "juliRed.png",dialogo = dialogo3)
const rami = new Vecino( posicionDelVecino = game.at(17,8), imagenDelVecino="rami.png", dialogo = dialogo4)
const juan = new Vecino( posicionDelVecino = game.at(11,15),imagenDelVecino ="juan.png", dialogo = dialogo5)
const doc = new Vecino( posicionDelVecino = game.at(30,3),imagenDelVecino="docRed.png",dialogo = dialogo6)
const vete = new Vecino( posicionDelVecino = game.at(33,16),imagenDelVecino = "veteRed.png", dialogo = dialogo7)
const meli = new Vecino( posicionDelVecino = game.at(29,8),imagenDelVecino = "meli.png", dialogo = dialogo8)
const nino = new Vecino( posicionDelVecino = game.at(25,6),imagenDelVecino = "nino.png", dialogo = dialogo9)
const vale = new Vecino( posicionDelVecino = game.at(7,14),imagenDelVecino = "vale.png", dialogo = dialogo10)
const ivan = new Vecino( posicionDelVecino = game.at(7, 5), imagenDelVecino ="ivan.png", dialogo = dialogo11)
const vane = new Vecino( posicionDelVecino = game.at(4, 3), imagenDelVecino ="vane.png", dialogo = dialogo12)