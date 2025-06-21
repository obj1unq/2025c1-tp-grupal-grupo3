import detective.*
class Interactuable {
  method interactuarCon(detective) 
  
}

class ObjetoInvisible {
  const property posicion
  
  method esInvisible(){
    return true
  }

  method image() {
    return "objetoinvisible.png"
  }

  method position() {
    return posicion
  }

}

const panaderiaCelda1 = new ObjetoInvisible(posicion = game.at(1,2))
const panaderiaCelda2 = new ObjetoInvisible(posicion = game.at(1,3))
const panaderiaCelda3 = new ObjetoInvisible(posicion = game.at(1,4))
const panaderiaCelda4 = new ObjetoInvisible(posicion = game.at(2,2))
const panaderiaCelda5 = new ObjetoInvisible(posicion = game.at(2,3))
const panaderiaCelda6 = new ObjetoInvisible(posicion = game.at(2,4))
const panaderiaCelda7 = new ObjetoInvisible(posicion = game.at(3,2))
const panaderiaCelda8 = new ObjetoInvisible(posicion = game.at(3,3))
const panaderiaCelda9 = new ObjetoInvisible(posicion = game.at(3,4))



object panaderia {
  const property celdasOcupadas = #{
    panaderiaCelda1, panaderiaCelda2, panaderiaCelda3, panaderiaCelda4, panaderiaCelda5, panaderiaCelda6, 
   panaderiaCelda7,panaderiaCelda8, panaderiaCelda9}

  method agregarVisual(){
    return celdasOcupadas.forEach({celda => game.addVisual(celda)})
  }

}



