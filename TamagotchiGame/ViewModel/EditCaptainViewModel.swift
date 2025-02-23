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
        let isSaveButtonEnabled: Driver<Bool>
        let guideMessage: Driver<String>
    }
    
    private let savedCaptainName = BehaviorRelay<String>(value: UserDataManager.captainNameRelay.value)
    private let isSaveButtonEnabled = BehaviorRelay<Bool>(value: false)
    private let guideMessage = BehaviorRelay<String>(value: "이름은 2자 이상 6자 이하로 입력해주세요.")
    
    func transform(input: Input) -> Output {
        input.captainName
            .map { name in
                if name.count >= 2 && name.count <= 6 {
                    self.isSaveButtonEnabled.accept(true)
                    self.guideMessage.accept("")
                } else {
                    self.isSaveButtonEnabled.accept(false)
                    self.guideMessage.accept("이름은 2자 이상 6자 이하로 입력해주세요.")
                }
                return name
            }
            .bind(to: savedCaptainName)
            .disposed(by: disposeBag)
        
        savedCaptainName
            .subscribe(onNext: { newName in
                if newName.count >= 2 && newName.count <= 6 {
                    UserDataManager.captainName = newName
                }
            })
            .disposed(by: disposeBag)
        
        return Output(
            savedCaptainName: savedCaptainName.asDriver(),
            isSaveButtonEnabled: isSaveButtonEnabled.asDriver(),
            guideMessage: guideMessage.asDriver()
        )
    }
    
    func saveCaptainName() {
        UserDataManager.captainName = savedCaptainName.value
    }
    
}
