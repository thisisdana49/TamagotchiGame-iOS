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

final class EditCaptainViewController: BaseViewController {
    
    private let viewModel = EditCaptainViewModel()
    private let textField = CustomUnderLineTextField()
    private let guideLabel = UILabel()
    private let saveButton = UIBarButtonItem()
    
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
        
        
        output.isSaveButtonEnabled
            .drive(saveButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.guideMessage
            .drive(guideLabel.rx.text)
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
        
        textField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(32)
        }
        
        guideLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(28)
        }
        
        textField.textColor = .point
        guideLabel.textColor = .point
        
        textField.font = .systemFont(ofSize: 15, weight: .semibold)
        guideLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        navigationItem.title = "대장님 이름 정하기"
        saveButton.title = "저장"
        saveButton.isEnabled = false
        navigationItem.rightBarButtonItem = saveButton
        saveButton.target = self
        saveButton.action = #selector(saveButtonTapped)
        textField.text = UserDataManager.captainName
    }
    
}
