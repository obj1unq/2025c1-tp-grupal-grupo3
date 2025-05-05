import direcciones.*
//import obstaculo.*

object detective {
  var property position = game.at(3, 3)  // El detective empieza en (3, 3)

  // method iniciar() {
  //   // Movimiento con teclas WASD
  //   keyboard.i().onPressDo("w", { self.mover(arriba) })
  //   keyboard.i().onPressDo("s", { self.mover(abajo) })
  //   keyboard.i().onPressDo("a", { self.mover(izquierda) })
  //   keyboard.i().onPressDo("d", { self.mover(derecha) })
  // }

  method puedeMover() {
    return true        // implementar mas adelante: !estaHablando && !enCinematica
  }
  method image() {
    return "teemo.png"
  }
//   method validarMover(direccion) {
//         if(direccion.siguientePosicion(position) == null || 
//             // !direccion.siguientePosicion(position).canEnter(self) ||
//             obstaculo.ocupaCelda(direccion.siguientePosicion(position))) {
//         self.error("¡No puedo ir en esa dirección!")
//         }
//   }

  method mover(direccion) {
    if(self.puedeMover()) {
      //self.validarMover(direccion)
      position = direccion.siguientePosicion(position)
    }
  }
}




//        Verificamos si la nueva celda es válida y si no está ocupada por el obstáculo
//       if(nuevaPos != null && nuevaPos.canEnter(self) && !obstaculo.ocupaCelda(nuevaPos)) {
//         position = nuevaPos
//         self.moveTo(position)
//         estado.actualizar(self)
//       } else {
//         game.say(self, "¡No puedes moverte ahí! Hay un obstáculo.")
//       }
//     }
//   }
// }
