//
//

import Foundation

struct Pokemon {
    let name: String
    var hp: Int
}

struct Position {
    let row, column: Int
}

struct PokeCorral {
    let owner: Trainer
    let columns = 10
    let rows = 10
    var pokemon: [(Position,Pokemon)]
    
}

struct Pokeball {
    let name = "ball"
    let hp: Int = 10
}

struct Trainer {
    var name: String
    var pokeballs: Int = 50
}

let bulbasaur = Pokemon(
    name: "bulbasaur",
    hp: 45
)

let ivysaur = Pokemon(
    name: "ivysaur",
    hp: 60
)

let venusaur = Pokemon(
    name: "venusaur",
    hp: 80
)

let charmander = Pokemon(
    name: "charmander",
    hp: 39
)

let charmeleon = Pokemon(
    name: "charmeleon",
    hp: 58
)

let charizard = Pokemon(
    name: "charizard",
    hp: 78
)

let squirtle = Pokemon(
    name: "squirtle",
    hp: 44
)

let wartortle = Pokemon(
    name: "wartortle",
    hp: 59
)

let blastoise = Pokemon(
    name: "blastoise",
    hp: 79
)

let pikachu = Pokemon(
    name: "pikachu",
    hp: 35
)

let pokemon: [Pokemon] = [
    bulbasaur,
    ivysaur,
    venusaur,
    charmander,
    charmeleon,
    charizard,
    squirtle,
    wartortle,
    blastoise,
    pikachu
]