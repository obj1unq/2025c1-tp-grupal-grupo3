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
   

//CREO EL DIALOGO COMO INSTANCIA DE LA CLASE A LA QUE PERTENECE
const dialogo1 = new Dialogo (lineasDelVecino = dialogosDeLucia)

//CREO A LUCIA COMO TAL LO QUE ES : UN VECINO 
const lucia = new Vecino (posicionDelVecino = game.at(1, 2), imagenDelVecino = "lucia1.png", dialogo = dialogo1 )