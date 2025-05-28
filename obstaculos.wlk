/*object obstaculos {
    const obstaculosTotales = [arbol1, arbol2, casa1]

    method ocupaCelda(posicion) {
        return obstaculosTotales.any({ obstaculos => obstaculos.ocupaCelda(posicion) })
  }
}*/

class Visual {
  method esTransitable() {
      return true
  }
}


class Muro inherits Visual{
  const property position

  override method esTransitable(){
    return false
  }

  method image() {
    return "obstaculo.png"
  }
}