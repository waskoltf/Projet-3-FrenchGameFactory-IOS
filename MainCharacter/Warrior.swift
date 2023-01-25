//
//  Warrior.swift
//  FrenchGameFactory
//
//  Created by wassime lotfi on 21/10/2022.
//

import Foundation

////je crée la classe charactere avec ces propriété en les heritants de la classe mère Character
class Warrior: Character {

     init(name: String = "") {
         super.init(name: "", type: .Warrior, lives: 60, weapon: Sword())
    }
}
