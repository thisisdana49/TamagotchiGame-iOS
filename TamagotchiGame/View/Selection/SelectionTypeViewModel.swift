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
        let tamagotchiList: Driver<[Tamagotchi]>
    }
    
    private let tamagotchiType = BehaviorRelay(value: 0)
    private let tamagotchiList = BehaviorRelay<[Tamagotchi]>(value: [
        Tamagotchi(id: 1, foodCount: 0, waterCount: 0),
        Tamagotchi(id: 2, foodCount: 0, waterCount: 0),
        Tamagotchi(id: 3, foodCount: 0, waterCount: 0)
    ])
    
    func transform(input: Input) -> Output {
        input.selectType
            .bind(to: tamagotchiType)
            .disposed(by: disposeBag)
        
        return Output(tamagotchiType: tamagotchiType.asDriver(),
                      tamagotchiList: tamagotchiList.asDriver())
        // MARK: error 처리가 필요할까? error가 발생하는 가능성이 0.1이라도 있나?
    }
    
}
