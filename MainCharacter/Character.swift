//
//  Character.swift
//  FrenchGameFactory
//
//  Created by wassime lotfi on 21/10/2022.
//

import Foundation

// je crée la classe charactere avec ces propriété

enum CharacterType {
    case Warrior
    case Dwarf
    case Colossus
    case Magus
    
    var name: String {
        switch self {
        case .Warrior:
            return "Warrior 🤺"
        case .Dwarf:
            return "Dwarf 🪵🪓"
        case .Colossus:
            return "Colossus 🦍"
        case .Magus:
            return "Magus 🩺🧙🏼‍♂️"
        }
    }
}

class Character {
    var name: String
    var type: CharacterType
    var lives: Int
    var weapon: Weapon
    
//    je les initialise car je vais les utiliser juste après avec une instance
    
    init(name: String, type: CharacterType, lives: Int, weapon: Weapon) {
        self.name = name
        self.type = type
        self.lives = lives
        self.weapon = weapon
    }
    
    func getDescription() -> String {
        return "Le personnage \(type), a \(lives) points de vie et \(weapon.damage) points de dégâts. Son arme est \(weapon.description)"
    }
}
