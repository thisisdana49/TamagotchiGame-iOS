//
//  EditCaptainViewController.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/23/25.
//

import UIKit
import SnapKit

class EditCaptainViewController: BaseViewController {

    private let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
    }
    
    @objc
    private func saveButtonTapped() {
        // TODO: User Data에 저장하는 기능
        navigationController?.popViewController(animated: true)
    }
    
    override func setupUI() {
        view.backgroundColor = .base
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        navigationItem.title = "대장님 이름 정하기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "저장",
            style: .plain,
            target: self,
            action: #selector(saveButtonTapped)
            // TODO: ViewModel로 바인딩 
        )
    }
    
}
