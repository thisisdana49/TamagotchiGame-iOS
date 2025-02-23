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
        
        var icon: String {
            switch self {
            case .editName:
                return "pencil"
            case .changeTamagotchi:
                return "moon.fill"
            case .resetData:
                return "arrow.clockwise"
            }
        }
        
        var detail: String {
            switch self {
            case .editName:
                return UserDataManager.captainNameRelay.value
            default:
                return ""
            }
        }
    }
    
    override init() {
        super.init()
        UserDataManager.captainNameRelay
            .subscribe(with: self, onNext: { owner, value in
                owner.settingsOptions.accept(SettingOption.allCases)
            })
            .disposed(by: disposeBag)
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
    
    func resetData() {
        UserDataManager.captainName = "대장"
        UserDataManager.selectedTamagotchi = -1
        UserDataManager.foodCount = 0
        UserDataManager.waterCount = 0
    }
}
