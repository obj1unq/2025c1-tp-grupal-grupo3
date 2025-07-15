import audioManager.*
import inventario.*
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
    const sonido = new Sound(file = "QuestLogOpen.mp3")
    sonido.play()
  }

  override method interactuarCon(detective) {
    self.hablar()
    // const sonido = new Sound(file = "QuestLogOpen.mp3")
    // sonido.play()
  }

  method esInvisible(){
    return false
  }

  method dependeDeEscenario() {
    return true
  }
  
  override method sePuedeInteractuar() {
    return true
  }
} 

class VecinoConMision inherits Vecino{
    const property itemAEntregar 
    const lineaFinal
    const lineaIntermedio
    var property tieneMisionDisponible =  true


  override method interactuarCon(detective) {
    self.validarSiPuedeInteractuarCon(detective)
    self.empezarInteraccion(detective)
  }

  method validarSiPuedeInteractuarCon(detective) {
    return if (not self.esIntearactuable())
              self.error("No hay nada interactuable acá")
  }

  method empezarInteraccion(detective) {
    if(self.tieneMisionSinIniciar(detective)) {
           self.comenzarMision(detective)
        } else {
          self.cerrarMision(detective)
        }
  }

  method tieneMisionSinIniciar(detective) {
    return  tieneMisionDisponible
  }

  method comenzarMision(detective) {
    self.hablar()
    tieneMisionDisponible = false
    // const sonido = new Sound(file = "QuestLogOpen.mp3")
    // sonido.play()
  }

  method cerrarMision(detective) {
    if (self.sePuedeFinalizarMision(detective)) {
       self.finalizarMision(detective)
    } else {
        self.decirIntermedio()
    }
  }

  method sePuedeFinalizarMision(detective) 

  method finalizarMision(detective) {
    self.decirFinal()
    self.darItem(detective)
    self.cambiarANoInteractuable()
  }

  method decirFinal() {
    lineaFinal.hablar(self)
    // const sonido = new Sound(file = "QuestLogOpen.mp3")
    // sonido.play()
    }

  method darItem(detective) {
      detective.recibirItem(itemAEntregar)
      
    }

  method decirIntermedio() {
    lineaIntermedio.hablar(self)
    // const sonido = new Sound(file = "QuestLogOpen.mp3")
    // sonido.play()
  }

}

class VecinoEspecialConMision inherits VecinoConMision {

  override method sePuedeFinalizarMision(detective) {
      return detective.cantPistas() >= 5
  }

  override method finalizarMision(detective) {
      super(detective)
      detective.descartarItem(lupa)

  }
}

class VecinoSolitarioConMision inherits VecinoConMision {
    const property itemQueNecesita

    override method sePuedeFinalizarMision(detective) {
        return detective.tieneItem(itemQueNecesita)
    }

    override method finalizarMision(detective) {
      super(detective)
      detective.descartarItem(itemQueNecesita)
    }
}

class VecinoPrincipal inherits VecinoSolitarioConMision {
  const property item = blockNotas 

  override method comenzarMision(detective) {
    self.hablar()
    detective.recibirItem(item)
    tieneMisionDisponible = false
    // const sonido = new Sound(file = "QuestLogOpen.mp3")
    // sonido.play()
  }

  override method finalizarMision(detective) {
    super(detective)
    game.addVisual(misionCompletada)
    detective.gameOver()
  }
}


class VecinoPrincipalConMision inherits VecinoSolitarioConMision {
  const property vecinoSecundario

  override method comenzarMision(detective) {
    super(detective)
    vecinoSecundario.cambiarAInteractuable()
  }
  
  override method finalizarMision(detective) {
      super(detective)
      vecinoSecundario.cambiarANoInteractuable()
  }

}

class VecinoSecundarioConMision inherits VecinoConMision {

  override method comenzarMision(detective) {
    super(detective)
    self.darItem(detective)
  }

  override method finalizarMision(detective) {
    self.decirFinal()
  }

  override method sePuedeFinalizarMision(detective) {
    return not detective.tieneItem(itemAEntregar)
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


class ChatBox inherits ImagenAMostrar {

  var property visible = false
  var property tokenActual = ""

  method hablar(vecino) {
    chatManager.mostrar(self)
    self.mostrarSiEsNecesario(vecino)
    self.agendarOcultar()
    const sonidoDeDiaologo = new Sound(file = "QuestLogOpen.mp3")
    sonidoDeDiaologo.play()
  }

  method mostrarSiEsNecesario(vecino) {
    if (not visible) {
      visible = true
      game.addVisual(self)
    }
  }

  method agendarOcultar() {
    const nuevoToken = "cb" + game.currentTime()
    tokenActual = nuevoToken
    game.onTick(10000, nuevoToken, {self.ocultarSiEsTokenValido(nuevoToken)})
  }

  method ocultarSiEsTokenValido(token) {
    if (tokenActual == token) {
      game.removeVisual(self)
      visible = false
    }
  }

  method ocultarManual() {
  if (visible) {
    game.removeVisual(self)
    visible = false
    game.removeTickEvent(tokenActual) // evita que el onTick lo vuelva a ocultar luego
  }
}


}

class ChatBoxLargo inherits ChatBox {
  override method agendarOcultar() {
    const nuevoToken = "cb" + game.currentTime()
    tokenActual = nuevoToken
    game.onTick(20000, nuevoToken, {self.ocultarSiEsTokenValido(nuevoToken)})
  }
}

class ChatBoxCorto inherits ChatBox {
  override method agendarOcultar() {
    const nuevoToken = "cb" + game.currentTime()
    tokenActual = nuevoToken
    game.onTick(7000, nuevoToken, {self.ocultarSiEsTokenValido(nuevoToken)})
  }
}

class ChatBoxSuperCorto inherits ChatBox {
  override method agendarOcultar() {
    const nuevoToken = "cb" + game.currentTime()
    tokenActual = nuevoToken
    game.onTick(4000, nuevoToken, {self.ocultarSiEsTokenValido(nuevoToken)})
  }
}

object chatManager {
  var chatBoxActivo = null

  method mostrar(chatBox) {
    chatBoxActivo = chatBox
  }

  method ocultar() {
    if (chatBoxActivo != null) {
      chatBoxActivo.ocultarManual()
      chatBoxActivo = null
    }
  }
}



object misionCompletada {
  const property image = "misionCumplida.png" 
  const property position = game.at(10, 0) 
}


//DEFINICION DEL DIALOGO EN LUCIA:
const dialogoDeFernanda = ["Necesitaba salir a tomar aire fresco", "El día esta muy lindo"]

const dialogoDeJuan = ["Rami te dijo de ir a la policia","Eso es bueno", "Pero si vas al camping","andá con cuidado","Es temporada de osos"]

const dialogoDeMeli = ["Estaba acariciando un gatito blanco", "Pero luego se fue corriendo al bosque", "Voy por un helado"]

const dialogoDeVale = ["Buena suerte en el bosque, Detective"]

const dialogoDeIvan = ["jmm","Los animales son dificiles", "¿tenés comida?","Eso puede ayudar"]

const dialogoDeAna = ["Ultimamente la gente pierde sus cosas"]

const dialogoDeAzula = ["Yo perdi mi cabeza", "Mis pensamientos estan en cualquier lado"]

const dialogoDeAbuelito = ["Estoy cansado", "Quiero llegar a mi casa"]

const dialogoDeAbuelita = ["Pobre Lucia", "Escuche que perdio a Morena", "Ojala la encuentre"]

const dialogoDeGruda = ["Vivan las ofertas!!", "Pude comprar muchas cosas"]

const dialogoDeNene = ["No hablo con extraños"]

const dialogoDeMaestra = ["Hoy fue un día agotador de trabajo", "Los niños prestaron atencion a mi clase"]

const dialogoDeMetalero = ["Viva RAMMSTEIN carajo"]

const dialogosDeLucia        = ["Hola, Necesito tu ayuda", "Se perdió Morena, mi gatita", "No puedo estar sin Morena", 
                                "Morena tiene un collar celeste", "Ella es blanquita", "Te agradeceria que la encuentres"] 
const dialogoFinalLucia      = ["AAAAA Morena!!!", "Muchas gracias por encontrarla!!", "La extrañaba mucho"]
const dialogoIntermedioLucia = ["Espero que Morena este bien", "¿Encontraste alguna pista?"]

const dialogoDeTomillo         = ["Hola, soy Tomillo", "¿Te gustaria comprarme unos bocadillos?", "Son para gato", 
                                  "Si los queres necesito que me des una moneda"] 
const dialogoFinalTomillo      = ["Gracias por tu compra", "Espero que te sirvan los bocadillos"]
const dialogoIntermedioTomillo = ["¿Conseguiste la moneda?", "Quizas si ayudas a alguien", "Te de una monda como recompensa"]

const dialogoDeJuli         = ["Podria darte una pista", "Pero solo te ayudare","Si me traes mi burbujero perdido", 
                               "No me movi de esta zona", "Asi que tiene que estar por aca"]
const dialogoFinalJuli      = ["Que bueno que lo trajiste", "Pense que no podrias encontrarlo", "Mira mi dibujo, quizas te guste"]
const dialogoIntermedioJuli = ["Hasta que no me traigas mi burbujero", "No te hablare"]

const dialogoDeRami         = ["Hey dectective, estoy triste", "No puedo encontrar la pua de mi guitarra",
                               "¿Podrias ayudarme a buscarla?", "Recuerdo haber tocado una cancion", "En la plaza de los niños"]
const dialogoFinalRami      = ["Muchisimas gracias!", "Sé que estas buscando una mascota", "Esta transportadora podria servirte", 
                               "La usaba para TRANSPORTAR a mi gata","¿Pediste ayuda en la policia?", "Escuché que son buenos ayudando"]
const dialogoIntermedioRami = ["Todavia no encontre mi pua :("]

const dialogoDelDoc              = ["Vine al correo para enviar algo","Pero tengo un problema, olvide mi DNI","Podrias traerme mi DNI?",
                                    "Lo tiene mi esposa","Ella esta en el hotel"]
const dialogoAgradecimientoDeDoc = ["Muchas gracias por traerme el dni", "Te doy esto por tu ayuda", "Dicen que la miel es buena para los OSOS"] 
const dialogoIntermedioDeDoc     = ["¿No pudiste encontrar a mi esposa?"] 


const dialogoDeLaVete       = ["Hola Detective","¿Podrias llevarle los caramelos a mi hijo?", "Me olvide por completo"]
const dialogoFinalVete      = ["Gracias por ayudarnos", "Espero que te sirva la moneda"]
const dialogoIntermedioVete = ["¿Ya comio los caramelos mi hijo?"] 

const dialogoNino           = ["Mi mamá se olvidó de darme mis caramelos","Los compro en el SUPERMERCADO"]
const dialogoFinalNino      = ["Gracias!! Ya queria comerlos", "Me encontre una moneda", "Te la regalo, quizas puedas comprar algo"]
const dialogoIntermedioNino = ["Quiero comer mis caramelos :("]

const dialogoDeVane           = ["Hola, ¿mi marido se olvido algo?", "Dile que no lo pierda"]
const dialogoIntermedioDeVane = ["¿Le entregaste el dni a mi marido?"]
const dialogoFinEntregaDeVane = ["Gracias por ayudar a mi marido"]

const dialogoDePoliHombre           = ["Sabia que mi compañera se olvidaba algo", "No pierdas la llave"]
const dialogoFinalDePoliHombre      = ["Muchas gracias por ayudarnos"]
const dialogoIntermedioDePoliHombre = ["¿Le diste la llave?"]

const dialogoDePoliMujer           = ["Buenos dias detective", "Preciso su ayuda", "Mi compañero que esta en el camping", 
                                      "Se olvido de darme la llave de mi casillero","¿Podrias alcanzarme la llave?"]
const dialogoFinalDePoliMujer      = ["Muchas gracias detective", "Tome esta linterna, puede servirle", "No se olvide que con la linterna y la lupa", 
                                      "Puede encontrar pistas", "En lugares donde hayan GRAFITIS", "Debe buscar bien los GRAFITIS, estan ESCONDIDOS", 
                                      "Creo que no todos te van a dar PISTAS", "Preste ATENCION a las PISTAS"]
const dialogoIntermedioDePoliMujer = ["¿Conseguiste la llave?"]

const dialogoDeGuardaBosque = ["No te puedo dejar pasar", "Si no tenes una CREDENCIAL",
                               "Yo te puedo dar la CREDENCIAL", "Pero debes demostrar si sos un buen detective", 
                               "Si encontraste 5 PISTAS o más", "Te daré la credencial"]
const dialogoFinalDeGuardaBosque = ["Eres un buen detective", "Toma la credencial", "Mucha suerte"]
const dialogoIntermedioDeGuardaBosque = ["Te aconsejo que entres preparado", "Esta peligroso el bosque"]


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
const dialogo32 = new Dialogo( lineasDelVecino = dialogoFinalTomillo)
const dialogo33 = new Dialogo( lineasDelVecino = dialogoIntermedioTomillo)
const dialogo34 = new Dialogo( lineasDelVecino = dialogoFinalLucia)
const dialogo35 = new Dialogo( lineasDelVecino = dialogoIntermedioLucia)
const dialogo36 = new Dialogo( lineasDelVecino = dialogoDeFernanda)
const dialogo37 = new Dialogo( lineasDelVecino = dialogoDeGuardaBosque)
const dialogo38 = new Dialogo( lineasDelVecino = dialogoFinalDeGuardaBosque)
const dialogo39 = new Dialogo( lineasDelVecino = dialogoIntermedioDeGuardaBosque)
const dialogo40 = new Dialogo( lineasDelVecino = dialogoDeAna)
const dialogo41 = new Dialogo( lineasDelVecino = dialogoDeAzula)
const dialogo42 = new Dialogo( lineasDelVecino = dialogoDeAbuelito)
const dialogo43 = new Dialogo( lineasDelVecino = dialogoDeAbuelita)
const dialogo44 = new Dialogo( lineasDelVecino = dialogoDeGruda)
const dialogo45 = new Dialogo( lineasDelVecino = dialogoDeNene)
const dialogo46 = new Dialogo( lineasDelVecino = dialogoDeMaestra)
const dialogo47 = new Dialogo( lineasDelVecino = dialogoDeMetalero)


//CREO A LUCIA COMO TAL LO QUE ES : UN VECINO 
const fernanda = new Vecino( posicionDelVecino = game.at(2, 4), imagenDelVecino = "luciaRed.png", dialogo = dialogo36)
const juan     = new Vecino( posicionDelVecino = game.at(11,15),imagenDelVecino ="juan.png", dialogo = dialogo5)
const meli     = new Vecino( posicionDelVecino = game.at(29,8),imagenDelVecino = "meli.png", dialogo = dialogo8)
const vale     = new Vecino( posicionDelVecino = game.at(7,14),imagenDelVecino = "vale.png", dialogo = dialogo10)
const ivan     = new Vecino( posicionDelVecino = game.at(7, 5), imagenDelVecino ="ivan.png", dialogo = dialogo11)
const abuela   = new Vecino( posicionDelVecino = game.at(22, 4), imagenDelVecino = "abuelitaFINAL.png", dialogo = dialogo43)
const ana      = new Vecino( posicionDelVecino = game.at(16, 17), imagenDelVecino = "AnaFINAL.png", dialogo = dialogo40)
const azula    = new Vecino( posicionDelVecino = game.at(17, 17), imagenDelVecino = "azulaFINAL.png", dialogo = dialogo41)
const abuelo   = new Vecino( posicionDelVecino = game.at(23, 18), imagenDelVecino = "abuelitoFinal.png", dialogo = dialogo42)
const gruda    = new Vecino( posicionDelVecino = game.at(26, 14), imagenDelVecino = "grudaFINAL.png", dialogo = dialogo44)
const nene     = new Vecino( posicionDelVecino = game.at(6, 8), imagenDelVecino = "neneJugandoFINAL.png", dialogo = dialogo45)
const maestra  = new Vecino( posicionDelVecino = game.at(29, 11), imagenDelVecino = "maestraFINAL.png", dialogo = dialogo46)
const metalero  = new Vecino( posicionDelVecino = game.at(7, 4), imagenDelVecino = "metaleroFINAL.png", dialogo = dialogo47)



const guardaBosque = new VecinoEspecialConMision( posicionDelVecino = game.at(18, 17), imagenDelVecino = "guardaBosqueFINAL.png", 
                                                  dialogo = guardaBosqueInicioChatBox, itemAEntregar = credencial, 
                                                  lineaFinal = guardaBosqueFinalChatBox, lineaIntermedio = guardaBosqueIntermedioChatBox)
const guardaBosqueInicioChatBox = new ChatBox (image = "GuardaBosqueInicioChatBox.png" , position = game.at(10,1))
const guardaBosqueIntermedioChatBox = new ChatBox (image = "GuardaBosqueIntermedioChatBox.png" , position = game.at(10,1))
const guardaBosqueFinalChatBox= new ChatBox (image = "GuardaBosqueFinalChatBox.png" , position = game.at(10,1)) 

const lucia = new VecinoPrincipal ( posicionDelVecino = game.at(19, 10), imagenDelVecino = "luciaFINAL.png", dialogo = luciaInicioChatBox,
                                             itemQueNecesita = morena, itemAEntregar = flores, 
                                             lineaFinal = luciaFinalChatBox, lineaIntermedio = luciaIntermedioChatBox)
const luciaInicioChatBox = new ChatBox (image = "LuciaInicioChatBox.png" , position = game.at(10,1))
const luciaIntermedioChatBox = new ChatBoxSuperCorto (image = "LuciaIntermedioChatBox.png" , position = game.at(10,1))
const luciaFinalChatBox= new ChatBox (image = "LuciaFinalChatBox.png" , position = game.at(10,1))                                             

const juli = new VecinoSolitarioConMision( posicionDelVecino = game.at(27, 7), imagenDelVecino = "juliRed.png", dialogo = juliInicioChatBox,
                                           itemQueNecesita = burbujero, itemAEntregar = hoja, 
                                           lineaFinal = juliFinalChatBox, lineaIntermedio = juliIntermedioChatBox)
const juliInicioChatBox = new ChatBox (image = "JuliInicioChatBox.png" , position = game.at(10,1))
const juliIntermedioChatBox = new ChatBox (image = "JuliIntermedioChatBox.png" , position = game.at(10,1))
const juliFinalChatBox= new ChatBox (image = "JuliFinalChatBox.png" , position = game.at(10,1))

const rami = new VecinoSolitarioConMision( posicionDelVecino = game.at(16,4), imagenDelVecino ="rami.png", dialogo = ramiInicioChatBox, 
                                           itemQueNecesita = puaGuitarra, itemAEntregar = transportadoraVacia, 
                                           lineaFinal = ramiFinalChatBox, lineaIntermedio = ramiIntermedioChatBox)
const ramiInicioChatBox = new ChatBox (image = "RamiInicioChatBox.png" , position = game.at(10,1))
const ramiIntermedioChatBox = new ChatBox (image = "RamiIntermedioChatBox.png" , position = game.at(10,1))
const ramiFinalChatBox= new ChatBoxLargo (image = "RamiFinalChatBox.png" , position = game.at(10,1))

const tomillo = new VecinoSolitarioConMision( posicionDelVecino = game.at(10,16), imagenDelVecino = "scoutRed.png", dialogo = tomilloScoutInicioChatBox,
                                              itemQueNecesita = moneda, itemAEntregar = bocadillos, 
                                              lineaFinal = tomilloScoutFinalChatBox, lineaIntermedio = tomilloScoutIntermedioChatBox)
const tomilloScoutInicioChatBox = new ChatBox (image = "TomilloScoutInicioChatBox.png" , position = game.at(10,1))
const tomilloScoutIntermedioChatBox = new ChatBox (image = "TomilloScoutIntermedioChatBox.png" , position = game.at(10,1))
const tomilloScoutFinalChatBox= new ChatBox (image = "TomilloScoutFinalChatBox.png" , position = game.at(10,1))

const doc = new VecinoPrincipalConMision( vecinoSecundario = vane , posicionDelVecino = game.at(30,3), imagenDelVecino="docRed.png" ,
                                          dialogo = docInicioChatBox, itemQueNecesita = dni, itemAEntregar = miel, 
                                          lineaFinal = docFinalChatBox, lineaIntermedio = docIntermedioChatBox)
const docInicioChatBox = new ChatBox (image = "DocInicioChatBox.png" , position = game.at(10,1))
const docIntermedioChatBox = new ChatBoxCorto (image = "DocIntermedioChatBox.png" , position = game.at(10,1))
const docFinalChatBox= new ChatBox (image = "DocFinalChatBox.png" , position = game.at(10,1))                                          

const poliMujer = new VecinoPrincipalConMision( vecinoSecundario = poliHombre, posicionDelVecino = game.at(4,4), imagenDelVecino="policiaMujerFINAL.png",
                                                dialogo = celestePoliciaInicioChatBox, itemQueNecesita = llave, itemAEntregar = linterna, 
                                                lineaFinal = celestePoliciaFinalChatBox, lineaIntermedio = celestePoliciaIntermedioChatBox)
const celestePoliciaInicioChatBox = new ChatBox (image = "CelestePoliciaInicioChatBox.png" , position = game.at(10,1))
const celestePoliciaIntermedioChatBox = new ChatBox (image = "CelestePoliciaIntermedioChatBox.png" , position = game.at(10,1))
const celestePoliciaFinalChatBox= new ChatBoxLargo (image = "CelestePoliciaFinalChatBox.png" , position = game.at(10,1))

const nino = new VecinoPrincipalConMision( vecinoSecundario = vete,  posicionDelVecino = game.at(25,6),imagenDelVecino = "nino.png", 
                                           dialogo = ninoInicioChatBox, itemQueNecesita = caramelos, itemAEntregar = moneda,
                                           lineaFinal = ninoFinalChatBox, lineaIntermedio = ninoIntermedioChatBox)
const ninoInicioChatBox = new ChatBox (image = "NinoInicioChatBox.png" , position = game.at(10,1))
const ninoIntermedioChatBox = new ChatBox (image = "NinoIntermedioChatBox.png" , position = game.at(10,1))
const ninoFinalChatBox= new ChatBox (image = "NinoFinalChatBox.png" , position = game.at(10,1))

const poliHombre = new VecinoSecundarioConMision( esIntearactuable = false, posicionDelVecino = game.at(2,15), imagenDelVecino = "policiaHombreFINAL.png",
                                                  dialogo = fernandoPoliciaInicioChatBox, itemAEntregar = llave, 
                                                  lineaFinal= fernandoPoliciaChatBoxPoliciaFinalChatBox, lineaIntermedio = fernandoPoliciaChatBoxePoliciaIntermedioChatBox)
const fernandoPoliciaInicioChatBox = new ChatBox (image = "FernandoPoliciaInicioChatBox.png" , position = game.at(10,1))
const fernandoPoliciaChatBoxePoliciaIntermedioChatBox = new ChatBoxCorto (image = "FernandoPoliciaIntermedioChatBox.png" , position = game.at(10,1))
const fernandoPoliciaChatBoxPoliciaFinalChatBox= new ChatBoxCorto (image = "FernandoPoliciaFinalChatBox.png" , position = game.at(10,1))

const vete = new VecinoSecundarioConMision( esIntearactuable = false, posicionDelVecino = game.at(11,14), imagenDelVecino = "veteRed.png", 
                                            dialogo = veteInicioChatBox, itemAEntregar = caramelos,
                                            lineaFinal = veteFinalChatBox, lineaIntermedio = veteIntermedioChatBox)
const veteInicioChatBox = new ChatBox (image = "VeteInicialChatBox.png" , position = game.at(10,1))
const veteIntermedioChatBox = new ChatBox (image = "VeteIntermedioChatBox.png" , position = game.at(10,1))
const veteFinalChatBox= new ChatBox (image = "VeteFinalChatBox.png" , position = game.at(10,1))

const vane = new VecinoSecundarioConMision( esIntearactuable = false, posicionDelVecino = game.at(30,3), imagenDelVecino ="vane.png", 
                                            dialogo = vaneInicioChatBox, itemAEntregar = dni, 
                                            lineaFinal = vaneFinalChatBox, lineaIntermedio = vaneIntermedioChatBox)
const vaneInicioChatBox = new ChatBox (image = "VaneInicialChatBox.png" , position = game.at(10,1))
const vaneIntermedioChatBox = new ChatBoxCorto (image = "VaneIntermedioChatBox.png" , position = game.at(10,1))
const vaneFinalChatBox= new ChatBoxCorto (image = "VaneFinalChatBox.png" , position = game.at(10,1))