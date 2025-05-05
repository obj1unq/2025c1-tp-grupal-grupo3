import wollok.game.*
object arriba {
  method siguientePosicion(pos) {
    return game.at(pos.x(), pos.y() + 1)
  }
}

object abajo {
  method siguientePosicion(pos) {
    return game.at(pos.x(), pos.y() - 1)
  }
}

object izquierda {
  method siguientePosicion(pos) {
    return game.at(pos.x() - 1, pos.y())
  }
}

object derecha {
  method siguientePosicion(pos) {
    return game.at(pos.x() + 1, pos.y())
  }
}