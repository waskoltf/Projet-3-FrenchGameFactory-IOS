//
//  Magus.swift
//  FrenchGameFactory
//
//  Created by wassime lotfi on 21/10/2022.
//

import Foundation
////je crée la classe charactere avec ces propriété en les heritants de la classe mère Character

class Magus: Character {
    var mana: Int
    init(mana: Int = 30) {
        self.mana = mana
        super.init(name: "", type:.Magus, lives: 100, weapon: Wand())
    }
}
