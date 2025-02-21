//
//  Tamagotchi.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/21/25.
//

import Foundation

struct Tamagotchi {
    var id: Int
    var foodCount: Int
    var waterCount: Int
    
    var level: Int {
        return (foodCount / 5) + (waterCount / 2)
    }
}
