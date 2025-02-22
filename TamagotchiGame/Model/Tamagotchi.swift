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
    var type: String {
        switch self.id {
        case 1:
            return "따끔따끔 다마고치"
        case 2:
            return "방실방실 다마고치"
        case 3:
            return "반짝반짝 다마고치"
        default:
            return "준비중이에요"
        }
    }
}
