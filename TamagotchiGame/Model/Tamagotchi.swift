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
    var desc: String {
        switch self.id {
        case 1:
            return "저는 따끔따끔 다마고치 저를 지키는 가시가 있답니다\n대장님이 겪을 상처를 이 가시로 다 무찌를 거예요!!\n제가 지켜드릴게요 대장님!"
        case 2:
            return "저는 방실방실 다마고치 매일 웃고 있어요\n저와 함께 하신다면 저처럼 웃을 날이 많아지실 거예요\n저와 함께 가지 않으실래요?"
        case 3:
            return "저는 반짝반짝 다마고치 빛나는 얼굴이 특징이랍니다\n누가 뭐래도 중요한 건 예쁘고 빛나는 거 아닐까요?\n저를 고른다면 후회하지 않으실 거예요😎"
        default:
            return "준비중이에요"
        }
    }
}
