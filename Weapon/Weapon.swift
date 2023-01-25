//
//  Weapon.swift
//  FrenchGameFactory
//
//  Created by wassime lotfi on 23/10/2022.
//
import Foundation

//je crée la classe charactere avec ces propriété

class Weapon {
    var damage: Int
    var description: String
    
//    je les initialise car je vais les utiliser juste après avec une instance
    
    init(damage:Int, description:String){
        self.damage = damage
        self.description = description
    }
}

