//
//  Colossus.swift
//  FrenchGameFactory
//
//  Created by wassime lotfi on 21/10/2022.
//

import Foundation

////je crée la classe charactere avec ces propriété en les heritants de la classe mère Character
class Colossus: Character {

     init(name: String = ""){
         super.init(name: "", type: .Colossus, lives: 100, weapon: Fist())
    }
}
