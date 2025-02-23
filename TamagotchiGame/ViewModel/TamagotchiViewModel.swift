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
        let tamagotchiImage: Observable<String>
        let tamagotchiStatus: Observable<String>
        let dialogue: Observable<String>
    }
    
    private let tamagotchi: BehaviorRelay<Tamagotchi>
    private let captain: BehaviorRelay<Captain>
    private let dialogueSubject = BehaviorRelay<String>(value: "반갑구만 반가워요~!")
    
    init(tamagotchi: Tamagotchi) {
        // TODO: UserDefaults에서 저장된 정보를 가져올 수 있도록 하기!!
        print("Main view model init", tamagotchi)
        let captain = Captain(name: "대장")
        self.tamagotchi = BehaviorRelay(value: tamagotchi)
        self.captain = BehaviorRelay(value: captain)
    }
    
    func transform(input: Input) -> Output {
        let tamagotchiImage = tamagotchi.map { value in
            // TODO: 멋이 없어서 리팩토링 때에 수정 필요
            let level = value.level == 0 ? 1 : (value.level == 10 ? 9 : value.level)
            return "\(value.id)-\(level)"
        }
        
        var tamagotchiStatus = tamagotchi.map { $0.status }
        let dialogue = dialogueSubject.asObservable()
        
        // TODO: 두 로직을 합칠 수 있을 것 같음
        input.foodButtonTap
            .withLatestFrom(input.giveFood)
            .map { Int($0) ?? 1 }
            .bind(with: self) { owner, value in
                if value > 99 {
                    owner.dialogueSubject.accept("밥알은 한 번에 99개까지 먹을 수 있어요! 🍚")
                    return
                }
                
                var newTamagotchi = owner.tamagotchi.value
                newTamagotchi.foodCount += value
                owner.tamagotchi.accept(newTamagotchi)
                owner.dialogueSubject.accept("냠냠~ JMT네요~ 😋")
            }
            .disposed(by: disposeBag)

        input.waterButtonTap
            .withLatestFrom(input.giveWater)
            .map { Int($0) ?? 1 }
            .bind(with: self) { owner, value in
                if value > 99 {
                    owner.dialogueSubject.accept("물방울은 한 번에 49개까지 먹을 수 있어요! 💦")
                    return
                }
                
                var newTamagotchi = owner.tamagotchi.value
                newTamagotchi.waterCount += value
                owner.tamagotchi.accept(newTamagotchi)
                owner.dialogueSubject.accept("꿀꺽~ 수분 충전 완료!! 😚")
            }
            .disposed(by: disposeBag)
        // TODO: 레벨이 변경 될 때 레벨 변경 문구를 띄우려면???
//        tamagotchi
//            .map { $0.level }
//            .distinctUntilChanged()
//            .bind(with: self) { owner, newLevel in
//                if newLevel == 0 { return }
//                owner.dialogueSubject.accept("레벨 \(newLevel)로 성장했어요! 🎉")
//            }
//            .disposed(by: disposeBag)
        
        return Output(tamagotchiImage: tamagotchiImage,
                      tamagotchiStatus: tamagotchiStatus,
                      dialogue: dialogue)
    }
    
}
