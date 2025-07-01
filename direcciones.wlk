import wollok.game.*
object arriba {
  method siguientePosicion(pos) {
    return game.at(pos.x(), pos.y() + 1)
  }

  method entradaAlEscenarioDesdeBorde(pos) {
    return game.at(pos.x(), game.height() + 1)
  }
}

object abajo {
  method siguientePosicion(pos) {
    return game.at(pos.x(), pos.y() - 1)
  }

  method entradaAlEscenarioDesdeBorde(pos) {
    return game.at(pos.x(), 0)
  }
}

object izquierda {
  method siguientePosicion(pos) {
    return game.at(pos.x() - 1, pos.y())
  }

  method entradaAlEscenarioDesdeBorde(pos) {
    return game.at(game.width() - 1, pos.y())
  }
}

object derecha {
  method siguientePosicion(pos) {
    return game.at(pos.x() + 1, pos.y())
  }

  method entradaAlEscenarioDesdeBorde(pos) {
    return game.at(0, pos.y())
  }
}