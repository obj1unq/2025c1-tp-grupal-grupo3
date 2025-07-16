import audioManager.*
import detective.*
import cosas.*

object oso {
    const property presa = detective
    var  property position  = game.at(5, 5) 
    const property debilidad = miel
    var property imagenActual =  "oso.gif"
    var property activo = true
    var property dormido = false


    method image(){
        return imagenActual
    }

    method iniciar() {
        game.onTick(2000, "mover oso", {self.mover()})
        osoCorriendo.shouldLoop(true)
  		osoCorriendo.volume(0.5)
		osoCorriendo.play()
    }

    method finalizar() {
        if (activo) {
            game.removeTickEvent("mover oso")
            osoCorriendo.stop()
            //rugidoOso.stop()
            activo = false
        }
    }
    
    method nuevaPosicion(){
        return game.at(self.position().x() + self.xAMover(), self.position().y() + self.yAMover())
    }

    // method mover() {
    //     if (self.estaAdyacenteAlDetective())
    //             self.responderADetectiveAdyacente()
    //         else
    //             self.avanzar()
    // }

    method mover() {
    if (self.puedeActuar())
        self.responderSegunProximidad()
    }

    method puedeActuar() {
        return activo and presa.estaVivo()
    }

    method responderSegunProximidad() {
        if (self.estaAdyacenteAlDetective()){
            self.responderADetectiveAdyacente()
        }else{
            self.avanzar()
        }
    }
    
    method avanzar() {
        position = self.nuevaPosicion()
    }

    method responderADetectiveAdyacente() {
        if (self.debeAtacar()){
            self.atacar()
        }else{
            game.say(detective, "uff la miel me salvó")
            self.dormirse()
        }
    }

    method debeAtacar() {
        return not presa.tieneItem(debilidad)
    }

    method atacar() {
        game.addVisual(gameOver)
        self.finalizar()
        //osoCorriendo.stop()
        // rugidoOso.shouldLoop(true)
  		// rugidoOso.volume(0.5)
        // rugidoOso.play()
        presa.gameOver()
        audioManager.detenerMusica()
        finDeJuegoMusica.shouldLoop(true)
        finDeJuegoMusica.play()
        rugidoOso.shouldLoop(true)
  		rugidoOso.volume(0.5)
        rugidoOso.play()


    }

    method dormirse() {
        if (not dormido) {
            imagenActual = "osoDormido.gif"
            game.say(self, "Mmm... miel")
            dormido = true
            self.finalizar()
        }
    }

    method reiniciar() {
        activo = true
        dormido = false
        imagenActual = "oso.gif"
        osoCorriendo.stop()  
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
        const property image = "PantallaPerder.png" 
        const property position = game.at(0, 0) 
}

const rugidoOso = new Sound(file = "osoRugido.mp3")
const osoCorriendo = new Sound(file = "osoCorriendo.mp3")
const finDeJuegoMusica = new Sound(file = "finDeJuegoMusica.mp3")