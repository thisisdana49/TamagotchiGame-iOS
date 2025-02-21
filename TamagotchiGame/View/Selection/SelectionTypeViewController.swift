//
//  SelectionTypeViewController.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/22/25.
//

import UIKit
import RxCocoa
import RxSwift

final class SelectionTypeViewController: BaseViewController {

    private let mainView = SelectionTypeView()
    private let viewModel = SelectionTypeViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindViewModel() {
        let selectType = PublishSubject<Int>()
        let input = SelectionTypeViewModel.Input(selectType: selectType)
        let output = viewModel.transform(input: input)
        
        output.tamagotchiList
            .asDriver()
            .drive(mainView.collectionView.rx.items(cellIdentifier: SelectionTypeCollectionViewCell.id, cellType: SelectionTypeCollectionViewCell.self)) { (item, element, cell) in
                cell.configureData(with: element)
            }
            .disposed(by: disposeBag)
        
        
        mainView.collectionView.rx.itemSelected
            .bind(with: self) { owner, value in
                selectType.onNext(value.item)
            }
            .disposed(by: disposeBag)
        
        output.tamagotchiType
            .bind(with: self) { owner, value in
                let vc = SelectionModalViewController()
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = .crossDissolve
                owner.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }

    override func setupUI() {
        mainView.collectionView.register(SelectionTypeCollectionViewCell.self, forCellWithReuseIdentifier: SelectionTypeCollectionViewCell.id)
    }
    
}
