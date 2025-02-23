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

class SettingsViewController: BaseViewController {

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
                cell.textLabel?.text = element.title
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
            print("reset data tapped")
        }
    }
    
    override func setupUI() {
        view.backgroundColor = .base
        view.addSubview(tableView)
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        tableView.backgroundColor = .base
        tableView.rowHeight = 100
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

}
