//
//  UserDataManager.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/21/25.
//

import Foundation
import RxCocoa
import RxSwift

struct UserDataManager {
    @UserDefault("selectedTamagotchi", defaultValue: 0)
    static var selectedTamagotchi: Int

    @UserDefault("foodCount", defaultValue: 0)
    static var foodCount: Int

    @UserDefault("waterCount", defaultValue: 0)
    static var waterCount: Int

    @UserDefault("captainName", defaultValue: "대장")
    static var captainName: String {
        didSet {
            captainNameRelay.accept(captainName)
        }
    }
    
    static var captainNameRelay: BehaviorRelay<String> = {
        return BehaviorRelay(value: UserDataManager.captainName)
    }()
}
