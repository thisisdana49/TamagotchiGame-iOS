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
    
    let viewModel = TamagotchiViewModel()
    let mainView = TamagotchiView()
    
    
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
        
        output.dialogue
            .bind(with: self) { owner, value in
                owner.mainView.dialogueLabel.rx.text.onNext(value)
            }
            .disposed(by: disposeBag)
    }
    
}
