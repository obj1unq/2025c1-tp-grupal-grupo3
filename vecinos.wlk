import detective.*
import wollok.game.*

class Vecino{
    const posicionDelVecino
    const  imagenDelVecino 
    const dialogoDelVecino 

    method position() {
      return posicionDelVecino
    } 

    method image() {
      return imagenDelVecino
    }

    method dialogoDelVecino() {
      return dialogoDelVecino
    }
  
  method hablar() { // ????
     Dialogo.hablar() }
}

class Dialogo {
  const dialogoDelVecino = []
  var indice = 0

  method dialogoDelVecino(){
    return dialogoDelVecino
  }

  method hablar() {
     //Necesito cambiar cada tres segundos el dialogo hasta finalizar
     game.onTick(3000, "hablar", {self. cambiarDialogo()})
  }

  method cambiarDialogo() {
      if (indice < dialogoDelVecino.size()){
        game.say(self,(dialogoDelVecino.get(indice)))
        indice += 1 }
      else {
         game.removeTickEvent("hablar")
      }      
  }
}

const dialogosDeLucia = ["Hola, Necesito tu ayuda", "Se perdió MICHI, mi gatito", "No puedo estar sin Michi", "Michi tiene un collar celeste", "Te agradeceria que lo encuentres"] 
     // tengo el dialogo completo 

const dialogo1 = new Dialogo (dialogoDelVecino = dialogosDeLucia)

const lucia = new Vecino (posicionDelVecino = game.at(1, 2), imagenDelVecino = "lucia1.png", dialogoDelVecino = dialogo1 )