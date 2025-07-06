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

const dialogoDeJuli         = ["Podria darte una pista", "Pero solo te ayudare","Si me traes mi burbujero perdido", 
                               "No me movi de esta zona", "Asi que tiene que estar por aca"]
const dialogoFinalJuli      = ["Que bueno que lo trajiste", "Pense que no podrias encontrarlo", "Mira mi dibujo, quizas te guste"]
const dialogoIntermedioJuli = ["Hasta que no me traigas mi burbujero", "No te hablare"]

const dialogoDeRami         = ["Hey dectective, estoy triste", "No puedo encontrar la pua de mi guitarra",
                               "¿Podrias ayudarme a buscarla?", "Recuerdo haber tocado una cancion", "En la plaza de los niños"]
const dialogoFinalRami      = ["Muchisimas gracias!", "Sé que estas buscando una mascota", "Esta transportadora podria servirte", 
                               "La usaba para TRANSPORTAR a mi gata","¿Pediste ayuda en la policia?", "Escuché que son buenos ayudando"]
const dialogoIntermedioRami = ["Todavia no encontre mi pua :("]

const dialogoDeJuan = ["Rami te dijo de ir a la policia","Eso es bueno", "Pero si vas al camping","andá con cuidado","Es temporada de osos"]

const dialogoDelDoc              = ["Vine al correo para enviar algo","Pero tengo un problema, olvide mi DNI","Podrias traerme mi DNI?",
                                    "Lo tiene mi esposa","Ella esta en el hotel"]
const dialogoAgradecimientoDeDoc = ["Muchas gracias por traerme el dni", "Te doy esto por tu ayuda"] 
const dialogoIntermedioDeDoc     = ["¿No pudiste encontrar a mi esposa?"] 


const dialogoDeLaVete       = ["Hola Detective","¿Podrias llevarle los caramelos a mi hijo?", "Me olvide por completo"]
const dialogoFinalVete      = ["Gracias por ayudarnos", "Espero que te sirva la moneda"]
const dialogoIntermedioVete = ["¿Ya comio los caramelos mi hijo?"]

const dialogoDeMeli = ["Estaba acariciando un gatito blanco", "Pero luego se fue corriendo al bosque", "Voy por un helado"] 

const dialogoNino           = ["Mi mamá se olvidó de darme mis caramelos","Los compro en el SUPERMERCADO"]
const dialogoFinalNino      = ["Gracias!! Ya queria comerlos", "Me encontre una moneda", "Te la regalo, quizas puedas comprar algo"]
const dialogoIntermedioNino = ["Quiero comer mis caramelos :("]

const dialogoDeVale = ["Buena suerte en el bosque, Detective"]
const dialogoDeIvan = ["jmm","Los animales son dificiles", "¿tenés comida?","Eso puede ayudar"]

const dialogoDeVane           = ["Hola, ¿mi marido se olvido algo?", "Dile que no lo pierda"]
const dialogoIntermedioDeVane = ["¿Le entregaste el dni a mi marido?"]
const dialogoFinEntregaDeVane = ["Gracias por ayudar a mi marido"]

const dialogoDePoliHombre           = ["Sabia que mi compañera se olvidaba algo", "No pierdas la llave"]
const dialogoFinalDePoliHombre      = ["Muchas gracias por ayudarnos"]
const dialogoIntermedioDePoliHombre = ["¿Le diste la llave?"]

const dialogoDePoliMujer           = ["Buenos dias detective", "Preciso su ayuda", "Mi compañero que esta en el camping", 
                                      "Se olvido de darme la llave de mi casillero","¿Podrias alcanzarme la llave?"]
const dialogoFinalDePoliMujer      = ["Muchas gracias detective", "Tome esta linterna, puede servirle", "No se olvide que con la linterna y la lupa", 
                                      "Puede encontrar pistas", "En lugares donde hayan GRAFITIS", "Debe buscar bien los GRAFITIS, estan ESCONDIDOS"]
const dialogoIntermedioDePoliMujer = ["¿Conseguiste la llave?"]



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
const dialogo16 = new Dialogo( lineasDelVecino  = dialogoIntermedioDeVane)
const dialogo17 = new Dialogo( lineasDelVecino = dialogoFinEntregaDeVane)
const dialogo18 = new Dialogo( lineasDelVecino = dialogoDePoliHombre)
const dialogo19 = new Dialogo( lineasDelVecino = dialogoFinalDePoliHombre) 
const dialogo20 = new Dialogo( lineasDelVecino = dialogoIntermedioDePoliHombre)
const dialogo21 = new Dialogo( lineasDelVecino = dialogoDePoliMujer)
const dialogo22 = new Dialogo( lineasDelVecino = dialogoFinalDePoliMujer)
const dialogo23 = new Dialogo( lineasDelVecino = dialogoIntermedioDePoliMujer)
const dialogo24 = new Dialogo( lineasDelVecino = dialogoFinalRami)
const dialogo25 = new Dialogo( lineasDelVecino = dialogoIntermedioRami)
const dialogo26 = new Dialogo( lineasDelVecino = dialogoFinalJuli)
const dialogo27 = new Dialogo( lineasDelVecino = dialogoIntermedioJuli)
const dialogo28 = new Dialogo( lineasDelVecino = dialogoFinalNino)
const dialogo29 = new Dialogo( lineasDelVecino = dialogoIntermedioNino)
const dialogo30 = new Dialogo( lineasDelVecino = dialogoFinalVete)
const dialogo31 = new Dialogo( lineasDelVecino = dialogoIntermedioVete)



//CREO A LUCIA COMO TAL LO QUE ES : UN VECINO 
const lucia = new Vecino (posicionDelVecino = game.at(2, 4), imagenDelVecino = "luciaRed.png", dialogo = dialogo1 )
const tomillo = new Vecino(posicionDelVecino = game.at(10,16), imagenDelVecino = "scoutRed.png", dialogo = dialogo2)

const juli = new VecinoPrincialMision(posicionDelVecino = game.at(27, 7), imagenDelVecino = "juliRed.png", dialogo = dialogo3,
                                      itemQueNecesita = burbujero, itemAEntregar = hoja, 
                                      lineaFinal = dialogo26, lineaIntermedio = dialogo27)

const rami = new VecinoPrincialMision( posicionDelVecino = game.at(16,4), imagenDelVecino ="rami.png", dialogo = dialogo4, 
                                       itemQueNecesita = puaGuitarra, itemAEntregar = transportadora, 
                                       lineaFinal = dialogo24, lineaIntermedio = dialogo25)

const juan = new Vecino( posicionDelVecino = game.at(11,15),imagenDelVecino ="juan.png", dialogo = dialogo5)

const doc = new VecinoPrincialMision( posicionDelVecino = game.at(30,3), imagenDelVecino="docRed.png" ,
                                      dialogo = dialogo6, itemQueNecesita = dni, itemAEntregar = miel, 
                                      lineaFinal = dialogo13, lineaIntermedio = dialogo14)

const poliHombre = new VecinoSecundarioMision( posicionDelVecino = game.at(2,15), imagenDelVecino = "policiaHombreFINAL.png",
                                               dialogo = dialogo18, itemAEntregar = llave, 
                                               lineaFinal= dialogo19, lineaIntermedio = dialogo20)

const poliMujer = new VecinoPrincialMision(posicionDelVecino = game.at(4,4), imagenDelVecino="policiaMujerFINAL.png" ,dialogo = dialogo21, 
                                           itemQueNecesita = llave, itemAEntregar = linterna, 
                                           lineaFinal = dialogo22, lineaIntermedio = dialogo23)

const vete = new VecinoSecundarioMision( posicionDelVecino = game.at(11,14), imagenDelVecino = "veteRed.png", 
                                         dialogo = dialogo7, itemAEntregar = caramelos,
                                         lineaFinal = dialogo30, lineaIntermedio = dialogo31)

const meli = new Vecino( posicionDelVecino = game.at(29,8),imagenDelVecino = "meli.png", dialogo = dialogo8)

const nino = new VecinoPrincialMision( posicionDelVecino = game.at(25,6),imagenDelVecino = "nino.png", dialogo = dialogo9,
                                       itemQueNecesita = caramelos, itemAEntregar = moneda,
                                       lineaFinal = dialogo28, lineaIntermedio = dialogo29)

const vale = new Vecino( posicionDelVecino = game.at(7,14),imagenDelVecino = "vale.png", dialogo = dialogo10)

const ivan = new Vecino( posicionDelVecino = game.at(7, 5), imagenDelVecino ="ivan.png", dialogo = dialogo11)

const vane = new VecinoSecundarioMision( posicionDelVecino = game.at(30,3), imagenDelVecino ="vane.png", 
                                        dialogo = dialogo12, itemAEntregar = dni, 
                                        lineaFinal = dialogo17, lineaIntermedio = dialogo16)
//VecinoSecundarioMision( posicionDelVecino = game.at(30,3), imagenDelVecino ="vane.png", dialogo = dialogo12, itemAEntregar = dni, lineaFinDeEntrega = dialogo15)