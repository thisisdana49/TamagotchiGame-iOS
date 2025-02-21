//
//  TamagotchiViewModel.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/21/25.
//

import Foundation
import RxCocoa
import RxSwift

final class TamagotchiViewModel: BaseViewModel {
    
    struct Input {
        let giveFood: BehaviorSubject<Int>
        let giveWater: BehaviorSubject<Int>
    }
    
    struct Output {
        let tamagotchiLevel: BehaviorSubject<Int>
        let dialogue: BehaviorSubject<String>
    }
    
    private let disposBag = DisposeBag()
    
    private let tamagotchi: BehaviorSubject<Tamagotchi>
    private let captain: BehaviorSubject<Captain>
    
    override init() {
        // TODO: UserDefaults에서 저장된 정보를 가져올 수 있도록 하기!!
        let tamagotchi = Tamagotchi(id: 1, foodCount: 0, waterCount: 0)
        let captain = Captain(name: "대장")
        self.tamagotchi = BehaviorSubject(value: tamagotchi)
        self.captain = BehaviorSubject(value: captain)
    }
    
    private func transform(input: Input) -> Output {
        // TODO: 두 로직을 합칠 수 있을 것 같음
        input.giveFood
            .bind(with: self) { owner, value in
                // TODO: Driver로 바꾸기
                var newTamagotchi = try! owner.tamagotchi.value()
                newTamagotchi.foodCount += 1
                owner.tamagotchi.onNext(newTamagotchi)
            }
            .disposed(by: disposBag)

        input.giveWater
            .bind(with: self) { owner, value in
                var newTamagotchi = try! owner.tamagotchi.value()
                newTamagotchi.waterCount += 1
                owner.tamagotchi.onNext(newTamagotchi)
            }
            .disposed(by: disposBag)
        
        let tamagotchiLevel = BehaviorSubject(value: 0)
        let dialogue = BehaviorSubject(value: DialogueManager.getRandomDialogue(captainName: "대장"))
        
        return Output(tamagotchiLevel: tamagotchiLevel,
                      dialogue: dialogue)
    }
    
}
