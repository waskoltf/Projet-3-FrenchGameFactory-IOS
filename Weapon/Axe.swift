//
//  Axe.swift
//  FrenchGameFactory
//
//  Created by wassime lotfi on 23/10/2022.
//

import Foundation

////je crée la classe charactere avec ces propriété en les heritants de la classe mère weapon
class Axe : Weapon {
    init() {
        super.init(damage: 70, description: "Hache dure en acier")
    }
    
}
