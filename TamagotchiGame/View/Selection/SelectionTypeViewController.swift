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
    private let isOnboarding: Bool
    
    init(isOnboarding: Bool = false) {
        self.isOnboarding = isOnboarding
        super.init(nibName: nil, bundle: nil)
    }
    
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
        
        output.selectedTamagotchi
            .drive(with: self) { owner, value in
                let vc = SelectionModalViewController(tamagotchi: value, isOnboarding: owner.isOnboarding)
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = .crossDissolve
                owner.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }

    override func setupUI() {
        navigationItem.title = isOnboarding ? "다마고치 선택하기": "다마고치 변경하기"
        mainView.collectionView.register(SelectionTypeCollectionViewCell.self, forCellWithReuseIdentifier: SelectionTypeCollectionViewCell.id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
