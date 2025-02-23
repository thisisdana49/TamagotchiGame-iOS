//
//  TamagotchiViewController.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/21/25.
//

import UIKit
import RxCocoa
import RxSwift

final class TamagotchiViewController: BaseViewController {
    
    let viewModel: TamagotchiViewModel
    private let mainView: TamagotchiView
    
    init(tamagotchi: Tamagotchi) {
        self.viewModel = TamagotchiViewModel(tamagotchi: tamagotchi)
        self.mainView = TamagotchiView(tamagotchi: tamagotchi)
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindViewModel() {
        let input = TamagotchiViewModel.Input(giveFood: mainView.foodTextField.rx.text.orEmpty,
                                              foodButtonTap: mainView.foodButton.rx.tap,
                                              giveWater: mainView.waterTextField.rx.text.orEmpty,
                                              waterButtonTap: mainView.waterButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.tamagotchiImage
            .bind(with: self) { owner, value in
                print(value)
                owner.mainView.tamagotchiImageView.image = UIImage(named: value)
            }
            .disposed(by: disposeBag)
        
        output.tamagotchiStatus
            .bind(with: self) { owner, value in
                owner.mainView.statusLabel.rx.text.onNext(value)
                owner.mainView.waterTextField.rx.text.onNext("")
                owner.mainView.foodTextField.rx.text.onNext("")
            }
            .disposed(by: disposeBag)
        
        output.dialogue
            .bind(with: self) { owner, value in
                owner.mainView.dialogueLabel.rx.text.onNext(value)
            }
            .disposed(by: disposeBag)
    }
    
    @objc
    private func searchButtonTapped() {
        let vc = SettingsViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func setupUI() {
        navigationItem.title = "\(UserDataManager.captainName)님의 다마고치"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "person.circle")?.withTintColor(.point).withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(searchButtonTapped)
        )
    }
}
