//
//  EditCaptainViewController.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/23/25.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class EditCaptainViewController: BaseViewController {

    private let viewModel = EditCaptainViewModel()
    private let textField = UITextField()
    private let guideLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindViewModel() {
        let captainName = PublishSubject<String>()
        
        let input = EditCaptainViewModel.Input(captainName: captainName)
        let output = viewModel.transform(input: input)
        
        textField.rx.text
            .orEmpty
            .bind(to: captainName)
            .disposed(by: disposeBag)
        
        output.savedCaptainName
            .drive(textField.rx.text)
            .disposed(by: disposeBag)
    }
    
    @objc
    private func saveButtonTapped() {
        viewModel.saveCaptainName()
        navigationController?.popViewController(animated: true)
    }
    
    override func setupUI() {
        view.backgroundColor = .base
        view.addSubview(textField)
        view.addSubview(guideLabel)
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(16)
        }
        
        navigationItem.title = "대장님 이름 정하기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "저장",
            style: .plain,
            target: self,
            action: #selector(saveButtonTapped)
        )
    }
    
}
