//
//  SettingsViewModel.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/21/25.
//

import Foundation
import RxCocoa
import RxSwift

final class SettingsViewModel: BaseViewModel {
    
    // TODO: 하드코딩X, icon도 설정 하기
    enum SettingOption: CaseIterable {
        case editName
        case changeTamagotchi
        case resetData
        
        var title: String {
            switch self {
            case .editName: return "내 이름 설정하기"
            case .changeTamagotchi: return "다마고치 변경하기"
            case .resetData: return "데이터 초기화하기"
            }
        }
    }
    
    struct Input {
        let selectSetting: PublishSubject<SettingOption>
    }
    
    struct Output {
        let settingsOptions: Driver<[SettingOption]>
        let selectedAction: Driver<SettingOption>
    }
    
    private let settingsOptions = BehaviorRelay<[SettingOption]>(value: SettingOption.allCases)
    private let selectedAction = PublishRelay<SettingOption>()
    
    func transform(input: Input) -> Output {
        input.selectSetting
            .bind(to: selectedAction)
            .disposed(by: disposeBag)
        
        return Output(
            settingsOptions: settingsOptions.asDriver(),
            selectedAction: selectedAction.asDriver(onErrorDriveWith: .empty())
        )
    }
}
