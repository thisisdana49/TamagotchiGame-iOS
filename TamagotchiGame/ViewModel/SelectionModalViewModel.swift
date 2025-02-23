//
//  SelectionModalViewModel.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/21/25.
//

import Foundation
import RxCocoa
import RxSwift

final class SelectionModalViewModel: BaseViewModel {
    
    struct Input {
        let startButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let startGame: Driver<Tamagotchi>
    }
    
    private let tamagotchi: Tamagotchi
    private let startGameRelay = PublishRelay<Tamagotchi>()
    
    init(tamagotchi: Tamagotchi) {
        self.tamagotchi = tamagotchi
    }
    
    func transform(input: Input) -> Output {
        input.startButtonTap
            .map { self.tamagotchi }
            .bind(with: self, onNext: { owner, value in
                UserDataManager.selectedTamagotchi = owner.tamagotchi.id
                print("selectedTamagotchi saved", owner.tamagotchi.id)
                owner.startGameRelay.accept(value)
            })
            .disposed(by: disposeBag)
        
        return Output(startGame: startGameRelay.asDriver(onErrorDriveWith: .empty()))
    }
    
}
