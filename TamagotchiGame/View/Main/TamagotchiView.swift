//
//  TamagotchiView.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/21/25.
//

import UIKit
import SnapKit

final class TamagotchiView: UIView {
    
    private let dialogueImageView = UIImageView()
    let dialogueLabel = UILabel()
    private let tamagotchiImageView = UIImageView()
    private let badgeLabel = UILabel()
    private let statusLabel = UILabel()
    private let foodStackView = UIStackView()
    let foodTextField = UITextField()
    private let waterStackView = UIStackView()
    let foodButton = UIButton()
    let waterTextField = UITextField()
    let waterButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    private func configureHierarchy() {
        addSubview(tamagotchiImageView)
        addSubview(dialogueImageView)
        addSubview(dialogueLabel)
        addSubview(badgeLabel)
        addSubview(statusLabel)
        addSubview(foodStackView)
        addSubview(waterStackView)
        foodStackView.addArrangedSubview(foodTextField)
        foodStackView.addArrangedSubview(foodButton)
        waterStackView.addArrangedSubview(waterTextField)
        waterStackView.addArrangedSubview(waterButton)
    }
    
    private func configureLayout() {
        tamagotchiImageView.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.size.equalTo(180)
        }
        
        dialogueImageView.snp.makeConstraints {
            $0.bottom.equalTo(tamagotchiImageView.snp.top)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(240)
            $0.height.equalTo(150)
        }
        
        dialogueLabel.snp.makeConstraints{
            $0.center.equalTo(dialogueImageView)
            $0.edges.equalTo(dialogueImageView)
        }
        
        badgeLabel.snp.makeConstraints{
            $0.top.equalTo(tamagotchiImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        statusLabel.snp.makeConstraints{
            $0.top.equalTo(badgeLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        foodStackView.snp.makeConstraints{
            $0.top.equalTo(statusLabel.snp.bottom).offset(44)
            $0.horizontalEdges.equalToSuperview().inset(100)
            $0.height.equalTo(40)
        }
        
        waterStackView.snp.makeConstraints{
            $0.top.equalTo(foodStackView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(100)
            $0.height.equalTo(40)
        }
        
        foodTextField.snp.makeConstraints{
            $0.width.equalTo(140)
        }
        
        waterTextField.snp.makeConstraints{
            $0.width.equalTo(140)
        }
    }
    
    private func configureView() {
        backgroundColor = .base
        
        tamagotchiImageView.image = ._1_1
        
        dialogueImageView.image = .bubble
        
        dialogueLabel.text = "안녕하세요, 대장님!"
        dialogueLabel.textAlignment = .center
        dialogueLabel.numberOfLines = 0
        
        badgeLabel.text = "방실방실 다마고치"
        
        statusLabel.text = "LV1 · 밥알 0개 · 물방울 0개"
        
        foodStackView.distribution = .fillProportionally
        foodStackView.spacing = 8
        
        waterStackView.distribution = .fillProportionally
        waterStackView.spacing = 8
        
        foodTextField.borderStyle = .roundedRect
        
        foodButton.setTitle("밥먹기", for: .normal)
        foodButton.setTitleColor(.black, for: .normal)
        
        waterTextField.borderStyle = .roundedRect
        
        waterButton.setTitle("물먹기", for: .normal)
        waterButton.setTitleColor(.black, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
