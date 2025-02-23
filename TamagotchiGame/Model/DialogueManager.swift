//
//  DialogueManager.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/21/25.
//

import Foundation

struct DialogueManager {
//    static func getRandomDialogue(captainName: String) -> String {
    static func getRandomDialogue() -> String {
        let dialogues = [
            "좋은 하루예요!",
            "배고파요!",
            "보고싶었다구요~",
            "깃허브 푸시 까먹으시면 안돼요~",
            "얼른 취직해서 맛있는거 사주세용!!"
        ]
        
        return dialogues.randomElement() ?? "보고싶었다구요~"
    }
}
