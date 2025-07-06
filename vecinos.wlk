import detective.*
import wollok.game.*
import interactuable.*
import cosas.*


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

  method dependeDeEscenario() {
    return true
  }

    
} 
class VecinoConMision inherits Vecino {
    var  puedeDarMision = true
    const property itemAEntregar
    const lineaIntermedio
    const lineaFinal

    // override method interactuarCon(detective){ 
    //    if(not detective.tieneItem(itemAEntregar)) {
    //        self.comenzarMision(detective)
    //      } else {
    //        self.cerrarMision(detective)
    //    }
    // }

    method puedeDarMision() {
      return puedeDarMision
    }
    override method interactuarCon(detective) {
        if(self.puedeDarMision()) {
            self.comenzarMision(detective)
        } else {
            self.cerrarMision(detective)
        }
    }

    method comenzarMision(detective) {
        self.hablar()
        self.dejarSinMisionesDisponibles()
    }

    method dejarSinMisionesDisponibles() {
        puedeDarMision = false
    }

    method cerrarMision(detective) {
        if( self.seCumpleMision(detective) ) {
            self.finalizarMision(detective)
        } else {
            self.decirIntermedio()
        }
    }

    method finalizarMision(detective) {
          self.decirFinal()
    }

    method seCumpleMision(detective) {
        return true
    }

    method decirIntermedio() {
       lineaIntermedio.hablar(self)
    }

    method decirFinal() {
      lineaFinal.hablar(self)
    }

    method darItem(detective) {
      detective.recibirItem(itemAEntregar)
    }
}
class VecinoPrincialMision inherits VecinoConMision {
    const property itemQueNecesita
    //var property tieneMisionCompletada 
    //const lineaMisionCompleta
    //const property recompensa 
    //const lineaAgradecimiento  

    override method seCumpleMision(detective) {
      return detective.tieneItem(itemQueNecesita)
    }
    // override method dejarSinMisionesDisponibles() {
    //     tieneMisionCompletada = true
    // }

    override method finalizarMision(detective) {
        // if(self.tieneMisionCompletada()) {
        //     self.decirMisionCompleta()
        // } else {
            super(detective)
            detective.descartarItem(itemQueNecesita)
            self.darItem(detective)
            //self.dejarSinMisionesDisponibles()
        
    }  

    // method decirMisionCompleta() {
    //     lineaMisionCompleta.hablar(self)
    // }
  
    // override method interactuarCon(detective) {
    //   if(not detective.tieneItem(itemQueNecesita)) {
    //     self.hablar()
    //   } else {
    //       detective.descartarItem(itemQueNecesita)
    //       self.decirFinDeMision()
    //       self.darRecompensa(detective)

    //   }
    // }


    // method decirFinDeMision() {
    //   lineaAgradecimiento.hablar(self)
    // }

    // method darRecompensa(detective) {
    //     detective.recibirItem(recompensa)
    // }
}

class VecinoSecundarioMision inherits VecinoConMision {
    //const property itemAEntregar
    //const lineaFinDeEntrega

    override method comenzarMision(detective) {
        super(detective)
        self.darItem(detective)
    }

    override method seCumpleMision(detective) {
      return true
    }
    // override method interactuarCon(detective) {
    //   if(not detective.tieneItem(itemAEntregar)) {
    //       self.hablar()
    //       self.darItem(detective)
    //   } else {
    //       self.decirFinDeEntrega()
    //   }
    // }

    // method darItem(detective) {
    //   detective.recibirItem(itemAEntregar)
    // }
    // method decirFinDeEntrega() {
    //   lineaFinDeEntrega.hablar(self)
    // }
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
const dialogoDelDoc = ["Vine al correo para enviar algo","Pero tengo un problema, olvide mi DNI","Podrias traerme mi DNI?","Lo tiene mi esposa","Ella esta en el hotel"]
const dialogoDeLaVete = ["Hola Detective","Veo que estás en busqueda","El camping es un buen lugar para buscar","¿Tenes todo lo necesario?"]
const dialogoDeMeli = ["Detective! siga las pistas!","Y no se olvide su lupa", "Voy por un helado"]
const dialogoNino = ["Mi mamá dice que estas buscando un gato","Yo vi uno en el camping"]
const dialogoDeVale = ["Buena suerte en el bosque, Detective"]
const dialogoDeIvan = ["jmm","Los animales son dificiles", "¿tenés comida?","Eso puede ayudar"]
const dialogoDeVane = ["Hola, ¿mi marido se olvido algo?", "Dile que no lo pierda"]
const dialogoAgradecimientoDeDoc = ["Muchas gracias por traerme el dni", "Te doy esto por tu ayuda"] 
const dialogoIntermedioDeDoc = ["¿No pudiste encontrar a mi esposa?"]
const dialogoFinalDeDoc = ["Gracias por tu ayuda"] 
const dialogoIntermedioDeVane= ["¿Le entregaste el dni a mi marido?"]
const dialogoFinEntregaDeVane = ["Gracias por ayudar a mi marido"]
const dialogoDePoliHombre = [""]

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
const dialogo13 = new Dialogo( lineasDelVecino = dialogoAgradecimientoDeDoc)
const dialogo14 = new Dialogo( lineasDelVecino = dialogoIntermedioDeDoc)
const dialogo15 = new Dialogo( lineasDelVecino = dialogoFinalDeDoc)
const dialogo16 = new Dialogo( lineasDelVecino  = dialogoIntermedioDeVane)
const dialogo17 = new Dialogo( lineasDelVecino = dialogoFinEntregaDeVane)
const dialogo18 = new Dialogo( lineasDelVecino = dialogoDePoliHombre)


//CREO A LUCIA COMO TAL LO QUE ES : UN VECINO 
const lucia = new Vecino (posicionDelVecino = game.at(2, 4), imagenDelVecino = "luciaRed.png", dialogo = dialogo1 )
const tomillo = new Vecino(posicionDelVecino = game.at(10,16), imagenDelVecino = "scoutRed.png", dialogo = dialogo2)
const juli = new Vecino(posicionDelVecino = game.at(27, 7),imagenDelVecino = "juliRed.png",dialogo = dialogo3)
const rami = new Vecino( posicionDelVecino = game.at(17,8), imagenDelVecino="rami.png", dialogo = dialogo4)
const juan = new Vecino( posicionDelVecino = game.at(11,15),imagenDelVecino ="juan.png", dialogo = dialogo5)
const doc = new VecinoPrincialMision(posicionDelVecino = game.at(30,3), imagenDelVecino="docRed.png" ,
                                    dialogo = dialogo6, itemQueNecesita = dni, itemAEntregar = miel, lineaFinal = dialogo13, lineaIntermedio = dialogo14)
// const doc = new VecinoConMision(posicionDelVecino = game.at(30,3), imagenDelVecino="docRed.png" , dialogo = dialogo6, itemAEntregar = miel, 
//                                 lineaFinal = dialogo13, lineaIntermedio = dialogo14)

// const poliHombre = new VecinoSecundarioMision (posicionDelVecino = game.at(15,2), imagenDelVecino = "policiaHombreFINAL.png", dialogo = dialogo18, 
//                                                itemAEntregar = llave, lineaFinal= , lineaIntermedio = )




//VecinoPrincialMision( posicionDelVecino = game.at(30,3), imagenDelVecino="docRed.png",dialogo = dialogo6, itemQueNecesita = dni, recompensa = miel, lineaAgradecimiento = dialogo13)
const vete = new Vecino( posicionDelVecino = game.at(33,16),imagenDelVecino = "veteRed.png", dialogo = dialogo7)
const meli = new Vecino( posicionDelVecino = game.at(29,8),imagenDelVecino = "meli.png", dialogo = dialogo8)
const nino = new Vecino( posicionDelVecino = game.at(25,6),imagenDelVecino = "nino.png", dialogo = dialogo9)
const vale = new Vecino( posicionDelVecino = game.at(7,14),imagenDelVecino = "vale.png", dialogo = dialogo10)
const ivan = new Vecino( posicionDelVecino = game.at(7, 5), imagenDelVecino ="ivan.png", dialogo = dialogo11)
const vane = new VecinoSecundarioMision( posicionDelVecino = game.at(30,3), imagenDelVecino ="vane.png", 
                                        dialogo = dialogo12, itemAEntregar = dni, lineaFinal = dialogo17, lineaIntermedio = dialogo16)
//VecinoSecundarioMision( posicionDelVecino = game.at(30,3), imagenDelVecino ="vane.png", dialogo = dialogo12, itemAEntregar = dni, lineaFinDeEntrega = dialogo15)