//
//  SelectionTypeViewModel.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/22/25.
//

import Foundation
import RxCocoa
import RxSwift

final class SelectionTypeViewModel: BaseViewModel {
    
    struct Input {
        let selectType: PublishSubject<Int>
    }
    
    struct Output {
        let tamagotchiType: Driver<Int>
        let selectedTamagotchi: Driver<Tamagotchi>
        let tamagotchiList: Driver<[Tamagotchi]>
    }
    
    private let tamagotchiType = BehaviorRelay<Int>(value: 0)
    private let selectedTamagotchi = PublishRelay<Tamagotchi>()
    private let tamagotchiList = BehaviorRelay<[Tamagotchi]>(value: [
        Tamagotchi(id: 1, isReady: false, foodCount: 0, waterCount: 0),
        Tamagotchi(id: 2, isReady: false, foodCount: 0, waterCount: 0),
        Tamagotchi(id: 3, isReady: false, foodCount: 0, waterCount: 0)
    ] + (4...20).map { index in
        Tamagotchi(id: index, isReady: true, foodCount: 0, waterCount: 0)
    })
    
    func transform(input: Input) -> Output {
        input.selectType
            .map { index in
                return self.tamagotchiList.value[index]
            }
            .bind(to: selectedTamagotchi)
            .disposed(by: disposeBag)
        
        return Output(tamagotchiType: tamagotchiType.asDriver(),
                      selectedTamagotchi: selectedTamagotchi.asDriver(onErrorDriveWith: .empty()),
                      tamagotchiList: tamagotchiList.asDriver())
        // MARK: error 처리가 필요할까? error가 발생하는 가능성이 0.1이라도 있나?
    }
    
}
