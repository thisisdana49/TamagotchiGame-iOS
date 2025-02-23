//
//  SelectionModalViewController.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/22/25.
//

import UIKit

final class SelectionModalViewController: BaseViewController {

    private let viewModel: SelectionModalViewModel
    private let mainView: SelectionModalView
    
    init(tamagotchi: Tamagotchi) {
        self.viewModel = SelectionModalViewModel(tamagotchi: tamagotchi)
        self.mainView = SelectionModalView(tamagotchi: tamagotchi)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func bindViewModel() {
        let input = SelectionModalViewModel.Input(startButtonTap: mainView.startButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.startGame
            .drive(with: self) { owner, value in
                owner.showMainView(with: value)
            }
            .disposed(by: disposeBag)
        
        mainView.cancelButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func showMainView(with value: Tamagotchi) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else { return }
        let vc = TamagotchiViewController(tamagotchi: value)
                
        let nav = UINavigationController(rootViewController: vc)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
