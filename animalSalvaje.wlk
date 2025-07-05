import detective.*

object oso {
    const property presa = detective
    var  property position  = game.at(1, 1) 

    method image(){
        return "oso.gif"
    }

    method iniciar() {
        game.onTick(2000, "mover oso", {self.mover()})
    }

    method finalizar() {
        game.removeTickEvent("mover oso")
        game.say(self, "Mmm... miel 😴")
    }
    
    method nuevaPosicion(){
        return game.at(self.position().x() + self.xAMover(), self.position().y() + self.yAMover())
    }

    method mover() {
        // if (not self.hayDetectiveEnNuevaPosicion())
        //         position = self.nuevaPosicion()
        //     else 
        //         game.addVisual(gameOver)
        
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
        return not presa.tieneMiel()
    }

    method atacar() {
        game.addVisual(gameOver)
        self.finalizar()
    }

    method dormirse() {
        game.say(self, "Mmm... miel 😴")
        self.finalizar()
    }

    method estaAdyacenteAlDetective() {
        const dx = (self.position().x() - presa.position().x()).abs()
        const dy = (self.position().y() - presa.position().y()).abs()
        return (dx + dy) == 1
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
        const property image = ".png" 
        const property position = game.at(0, 0) 
    }