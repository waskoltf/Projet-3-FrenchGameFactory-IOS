//
//  Sword.swift
//  FrenchGameFactory
//
//  Created by wassime lotfi on 23/10/2022.
//

import Foundation

////je crée la classe charactere avec ces propriété en les heritants de la classe mère weapon
class Sword : Weapon {
   init() {
        super.init(damage: 50, description: "épée aiguisé")
    }
    
}
