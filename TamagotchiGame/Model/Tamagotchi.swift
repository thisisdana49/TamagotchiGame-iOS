//
//  Tamagotchi.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/21/25.
//

import Foundation

struct Tamagotchi {
    let id: Int
    let foodCount: Int
    let waterCount: Int
    
    var level: Int {
        return (foodCount / 5) + (waterCount / 2)
    }
}
