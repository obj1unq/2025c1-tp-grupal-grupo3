import detective.*
object lucia {
    var property position = game.at(1, 2)

    method image() {
        return "lucia1.png"
    }

    method interactuarCon(detective) {
        return game.say(self, "¡Hola! ¿Estás buscando una mascota perdida?")
        
    }
}

