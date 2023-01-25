//
//  Fist.swift
//  FrenchGameFactory
//
//  Created by wassime lotfi on 23/10/2022.
//

import Foundation

////je crée la classe charactere avec ces propriété en les heritants de la classe mère weapon
class Fist : Weapon {
   init() {
        super.init(damage: 40, description: "Main géante protectrice")
    }
    
}
