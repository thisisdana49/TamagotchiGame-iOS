//
//  EditCaptainViewModel.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/23/25.
//

import Foundation
import RxCocoa
import RxSwift

final class EditCaptainViewModel: BaseViewModel {
    

    struct Input {
        let captainName: PublishSubject<String>
    }
    
    struct Output {
        let savedCaptainName: Driver<String>
    }
    
    private let savedCaptainName = BehaviorRelay<String>(value: UserDataManager.captainName)
    
    func transform(input: Input) -> Output {
        input.captainName
            .bind(to: savedCaptainName)
            .disposed(by: disposeBag)
        
        return Output(savedCaptainName: savedCaptainName.asDriver())
    }
    
    func saveCaptainName() {
        UserDataManager.captainName = savedCaptainName.value
    }
    
}
