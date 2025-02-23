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
    let tamagotchiImageView = UIImageView()
    private let badgeLabel = CustomBadgeLabel()
    let statusLabel = UILabel()
    private let foodStackView = UIStackView()
    let foodTextField = CustomUnderLineTextField()
    private let waterStackView = UIStackView()
    let foodButton = CustomButton(type: .food)
    let waterTextField = CustomUnderLineTextField()
    let waterButton = CustomButton(type: .water)
    
    init(tamagotchi: Tamagotchi) {
        super.init(frame: .zero)
        
        configureHierarchy()
        configureLayout()
        configureView()
        configure(with: tamagotchi)
    }
    
    private func configure(with tamagotchi: Tamagotchi) {
        tamagotchiImageView.image = UIImage(named: "\(tamagotchi.id)-1")
        badgeLabel.text = tamagotchi.badge
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
            $0.bottom.equalTo(tamagotchiImageView.snp.top).offset(-8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(240)
            $0.height.equalTo(150)
        }
        
        dialogueLabel.snp.makeConstraints{
            $0.center.equalTo(dialogueImageView)
            $0.edges.equalTo(dialogueImageView).inset(16)
        }
        
        badgeLabel.snp.makeConstraints{
            $0.top.equalTo(tamagotchiImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        statusLabel.snp.makeConstraints{
            $0.top.equalTo(badgeLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        foodStackView.snp.makeConstraints{
            $0.top.equalTo(statusLabel.snp.bottom).offset(44)
            $0.horizontalEdges.equalToSuperview().inset(84)
            $0.height.equalTo(40)
        }
        
        waterStackView.snp.makeConstraints{
            $0.top.equalTo(foodStackView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(84)
            $0.height.equalTo(40)
        }
        
        foodTextField.snp.makeConstraints{
            $0.width.equalTo(140)
        }
        
        foodButton.snp.makeConstraints{
            $0.height.equalTo(40)
        }
        
        waterTextField.snp.makeConstraints{
            $0.width.equalTo(140)
        }
        
        waterButton.snp.makeConstraints{
            $0.height.equalTo(40)
        }
    }
    
    private func configureView() {
        backgroundColor = .base
        
        tamagotchiImageView.image = ._1_1
        
        dialogueImageView.image = .bubble
        
        dialogueLabel.textAlignment = .center
        dialogueLabel.numberOfLines = 0
        dialogueLabel.textColor = .point
        dialogueLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        badgeLabel.font = .systemFont(ofSize: 15, weight: .bold)
        
        statusLabel.textColor = .point
        statusLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        foodStackView.alignment = .center
        foodStackView.distribution = .fill
        foodStackView.spacing = 8
        
        waterStackView.alignment = .center
        waterStackView.distribution = .fillProportionally
        waterStackView.spacing = 8
        
        foodTextField.placeholder = "밥주세용"
        foodTextField.textAlignment = .center

        waterTextField.placeholder = "물주세용"
        waterTextField.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
