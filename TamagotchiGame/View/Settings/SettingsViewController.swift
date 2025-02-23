//
//  SettingsViewController.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/23/25.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class SettingsViewController: BaseViewController {

    let viewModel = SettingsViewModel()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindViewModel() {
        let selectSetting = PublishSubject<SettingsViewModel.SettingOption>()
        let input = SettingsViewModel.Input(selectSetting: selectSetting)
        let output = viewModel.transform(input: input)
        
        output.settingsOptions
            .drive(tableView.rx.items(cellIdentifier: SettingsTableViewCell.identifier, cellType: SettingsTableViewCell.self)) { (row, element, cell) in
                cell.configureData(with: element)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(SettingsViewModel.SettingOption.self)
            .bind(to: selectSetting)
            .disposed(by: disposeBag)
        
        output.selectedAction
            .drive(with: self) { owner, setting in
                owner.handleSettingSelection(setting)
            }
            .disposed(by: disposeBag)
    }
    
    private func handleSettingSelection(_ setting: SettingsViewModel.SettingOption) {
        switch setting {
        case .editName:
            let vc = EditCaptainViewController()
            navigationController?.pushViewController(vc, animated: true)
        case .changeTamagotchi:
            let vc = SelectionTypeViewController()
            navigationController?.pushViewController(vc, animated: true)
        case .resetData:
            showResetAlert()
        }
    }
    
    private func showResetAlert() {
        let confirmAction = UIAlertAction(title: "웅", style: .destructive) { [weak self] _ in
            self?.resetData()
        }
        
        AlertManager.shared.showAlert(
            on: self,
            title: "리셋할까요?",
            message: "모든 데이터가 초기화되니 다시 한 번 생각을...",
            actions: [UIAlertAction(title: "취소!", style: .cancel), confirmAction]
        )
    }
    
    private func resetData() {
        viewModel.resetData()
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else { return }
        let vc = SelectionTypeViewController(isOnboarding: true)
                
        let nav = UINavigationController(rootViewController: vc)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
    
    override func setupUI() {
        navigationItem.title = "설정"
        
        view.backgroundColor = .base
        view.addSubview(tableView)
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        tableView.backgroundColor = .base
        tableView.rowHeight = 56
        tableView.separatorColor = .point
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

}
