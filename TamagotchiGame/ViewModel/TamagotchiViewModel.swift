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
        // TODO: Driver? Observable? 무슨 타입을 써야 적합한가...🤨
        let tamagotchiLevel: Observable<Int>
        let dialogue: Observable<String>
    }
    
    private let disposBag = DisposeBag()
    
    private let tamagotchi: BehaviorRelay<Tamagotchi>
    private let captain: BehaviorRelay<Captain>
    
    override init() {
        // TODO: UserDefaults에서 저장된 정보를 가져올 수 있도록 하기!!
        let tamagotchi = Tamagotchi(id: 1, foodCount: 0, waterCount: 0)
        let captain = Captain(name: "대장")
        self.tamagotchi = BehaviorRelay(value: tamagotchi)
        self.captain = BehaviorRelay(value: captain)
    }
    
    private func transform(input: Input) -> Output {
        // TODO: 두 로직을 합칠 수 있을 것 같음
        input.giveFood
            .bind(with: self) { owner, value in
                var newTamagotchi = owner.tamagotchi.value
                newTamagotchi.foodCount += 1
                owner.tamagotchi.accept(newTamagotchi)
            }
            .disposed(by: disposBag)

        input.giveWater
            .bind(with: self) { owner, value in
                var newTamagotchi = owner.tamagotchi.value
                newTamagotchi.waterCount += 1
                owner.tamagotchi.accept(newTamagotchi)
            }
            .disposed(by: disposBag)
        
        var tamagotchiLevel: Observable<Int> {
            return tamagotchi.map { $0.level }
        }
        var dialogue: Observable<String> {
            return tamagotchi.map { _ in
                DialogueManager.getRandomDialogue(captainName: self.captain.value.name)
            }
        }
        
        return Output(tamagotchiLevel: tamagotchiLevel,
                      dialogue: dialogue)
    }
    
}
