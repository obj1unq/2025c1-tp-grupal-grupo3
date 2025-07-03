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
    }
    
    method nuevaPosicion(){
        return game.at(self.position().x() + self.xAMover(), self.position().y() + self.yAMover())
    }

    method mover() {
        position = self.nuevaPosicion()
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


    //  method xLimitado(){
    //     return 4.max(presa.position().x())
    // }

    // method yLimitado() {
    //     return 4.max(presa.position().y())
    // }


    // method encuentro() {
    //     if(self.posicionParaEncuentro()) {
    //          self.activarEncuentro()
    //     }
    // }

    // method activarEncuentro() {
    //     if(presa.tieneMiel()) {
    //          self.cambiarEstado(tranquilo)
    //     } else {
    //          self.atacar()
    //     }
    // }
}