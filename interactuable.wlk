import detective.*
class Interactuable {
  var property esIntearactuable = true
  method interactuarCon(detective) 
 
  method cambiarANoInteractuable() {
    esIntearactuable = false
  }

  method cambiarAInteractuable() {
    esIntearactuable = true
  }

  method puedeInteractuar

}

class ObjetoInvisible {
  const property posicion
  
  // method esInvisible(){
  //   return true
  // }

  method image() {
    return "objetoinvisible.png"
  }

  method position() {
    return posicion
  }
}

