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
        let giveFood: ControlProperty<String>
        let foodButtonTap: ControlEvent<Void>
        let giveWater: ControlProperty<String>
        let waterButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        // TODO: Driver? Observable? 무슨 타입을 써야 적합한가...🤨
        let tamagotchiLevel: Observable<Int>
        let dialogue: Observable<String>
    }
    
    private let tamagotchi: BehaviorRelay<Tamagotchi>
    private let captain: BehaviorRelay<Captain>
    
    override init() {
        // TODO: UserDefaults에서 저장된 정보를 가져올 수 있도록 하기!!
        let tamagotchi = Tamagotchi(id: 1, foodCount: 0, waterCount: 0)
        let captain = Captain(name: "대장")
        self.tamagotchi = BehaviorRelay(value: tamagotchi)
        self.captain = BehaviorRelay(value: captain)
    }
    
    func transform(input: Input) -> Output {
        // TODO: 두 로직을 합칠 수 있을 것 같음
        input.foodButtonTap
            .withLatestFrom(input.giveFood)
            .map { Int($0) ?? 1 }
            .bind(with: self) { owner, value in
                print("given food: ", value)
                var newTamagotchi = owner.tamagotchi.value
                newTamagotchi.foodCount += value
                owner.tamagotchi.accept(newTamagotchi)
                print("total food: ", newTamagotchi.foodCount)
            }
            .disposed(by: disposeBag)

        input.waterButtonTap
            .withLatestFrom(input.giveWater)
            .map { Int($0) ?? 1 }
            .bind(with: self) { owner, value in
                print("given water: ", value)
                var newTamagotchi = owner.tamagotchi.value
                newTamagotchi.waterCount += value
                owner.tamagotchi.accept(newTamagotchi)
                print("total water: ", newTamagotchi.waterCount)
            }
            .disposed(by: disposeBag)
        
        var tamagotchiLevel: Observable<Int> {
            return tamagotchi.map { $0.level }
        }
        
        // TODO: 상황에 따라 적절한 이야기를 설정하기
        var dialogue: Observable<String> {
            return tamagotchi.map { _ in
                DialogueManager.getRandomDialogue(captainName: self.captain.value.name)
            }
        }
        
        return Output(tamagotchiLevel: tamagotchiLevel,
                      dialogue: dialogue)
    }
    
}
