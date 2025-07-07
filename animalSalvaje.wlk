import detective.*
import cosas.*

object oso {
    const property presa = detective
    var  property position  = game.at(1, 1) 
    const property debilidad = miel
    var property imagenActual =  "oso.gif"

    method image(){
        return imagenActual
    }

    method iniciar() {
        game.onTick(2000, "mover oso", {self.mover()})
    }

    method finalizar() {
        game.removeTickEvent("mover oso")
    }
    
    method nuevaPosicion(){
        return game.at(self.position().x() + self.xAMover(), self.position().y() + self.yAMover())
    }

    method mover() {
        if (self.estaAdyacenteAlDetective())
                self.responderADetectiveAdyacente()
            else
                self.avanzar()
    }

    method avanzar() {
        position = self.nuevaPosicion()
    }

    method responderADetectiveAdyacente() {
        if (self.debeAtacar())
            self.atacar()
          else
            self.dormirse()
    }

    method debeAtacar() {
        return not presa.tieneItem(debilidad)
    }

    method atacar() {
        game.addVisual(gameOver)
        self.finalizar()
        presa.gameOver()
    }

    method dormirse() {
        imagenActual = "osoDormido.gif"
        game.say(self, "Mmm... miel")
        self.finalizar()
    }

    method estaAdyacenteAlDetective() {
        const dx = (self.position().x() - presa.position().x()).abs()
        const dy = (self.position().y() - presa.position().y()).abs()
        return (dx + dy) == 0 || (dx + dy) == 1
    }

    method estaAlLadoEnX() {
        return self.distanciaX() == 1 and self.distanciaY() == 0
    }

    method estaAlLadoEnY() {
        return self.distanciaY() == 1 and self.distanciaX() == 0
    }

    method distanciaX() {
        return (self.position().x() - presa.position().x()).abs()
    }

    method distanciaY() {
        return (self.position().y() - presa.position().y()).abs()
    }

    method esInvisible() {
        return false
    }

    
    method xAMover() {
        return if(self.xDistancia() > 0) {
                 -1
        } else {
                 1
        }
    }

    method xDistancia() {
        return self.position().x() - presa.position().x()
    }

    method yAMover() {
        return if(self.yDistancia() > 0) {
                    -1
        } else {
                    1
        }
    }

    method yDistancia() {
        return self.position().y() - presa.position().y(

        )
    } 

    method dependeDeEscenario() {
        return true
    }

}

object gameOver {
        const property image = "gameover.png" 
        const property position = game.at(5, 0) 
    }