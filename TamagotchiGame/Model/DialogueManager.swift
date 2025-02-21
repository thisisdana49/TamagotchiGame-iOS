//
//  DialogueManager.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/21/25.
//

import Foundation

struct DialogueManager {
    static func getRandomDialouge(captainName: String) -> String {
        let dialogues = [
            "좋은 하루예요, \(captainName)님!",
            "\(captainName)님, 배고파요!",
            "밥과 물을 잘먹었더니 레벨업 했어요 고마워요, \(captainName)님!"
        ]
        
        return dialogues.randomElement() ?? "\(captainName)님, 보고싶었어요~"
    }
}
