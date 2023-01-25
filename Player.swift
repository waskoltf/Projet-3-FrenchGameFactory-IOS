//
//  Player.swift
//  FrenchGameFactory
//
//  Created by wassime lotfi on 24/10/2022.
//

import Foundation

//Je crée une class player pour pouvoir l'utiliser par la suite

class Player {
    
    var name: String
    var characters: [Character] = []
    
    init(name: String, characters: [Character]) {
        self.name = name
        self.characters = characters
    }
}
