import detective.*
import wollok.game.*

class Vecino{
    const posicionDelVecino
    const  imagenDelVecino 
    const dialogo 

    method position() {
      return posicionDelVecino
    } 

    method image() {
      return imagenDelVecino
    }

    method dialogo() {
      return dialogo.hablar()
    }

    
} 

class Dialogo {
  const lineasDelVecino = []
  var indice = 0

  method hablar() {
     //Necesito cambiar cada tres segundos el dialogo hasta finalizar
        return {game.onTick(3000, "hablar", {self. cambiarDialogo()})}
    }

  method cambiarDialogo() {
      if (indice < lineasDelVecino.size()){
        game.say(self,(lineasDelVecino.get(indice)))
        indice += 1 }
      else {
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

