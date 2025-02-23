//
//  SelectionModalView.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/22/25.
//

import UIKit
import SnapKit

final class SelectionModalView: UIView {
    
    // TODO: baseView 클릭 시 모달창 dismiss
    private let baseView = UIView()
    private let tamagotchiImageView = UIImageView()
    private let badgeLabel = CustomBadgeLabel()
    private let separatorView = UIView()
    private let descLabel = UILabel()
    private let buttonSeparatorView = UIView()
    private let buttonStackView = UIStackView()
    let cancelButton = UIButton()
    let startButton = UIButton()
    
    init(tamagotchi: Tamagotchi) {
        super.init(frame: .zero)
        
        configureHierarchy()
        configureLayout()
        configureView()
        configure(with: tamagotchi)
    }
    
    private func configure(with tamagotchi: Tamagotchi) {
        tamagotchiImageView.image = UIImage(named: "\(tamagotchi.id)-6")
        badgeLabel.text = tamagotchi.badge
        descLabel.text = tamagotchi.desc
    }
    
    private func configureHierarchy() {
        addSubview(baseView)
        baseView.addSubview(tamagotchiImageView)
        baseView.addSubview(badgeLabel)
        baseView.addSubview(separatorView)
        baseView.addSubview(descLabel)
        baseView.addSubview(buttonSeparatorView)
        baseView.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(startButton)
    }
    
    private func configureLayout() {
        baseView.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(36)
            $0.verticalEdges.equalToSuperview().inset(200)
        }
        
        separatorView.snp.makeConstraints{
            $0.centerY.equalToSuperview().offset(20)
            $0.horizontalEdges.equalToSuperview().inset(40)
            $0.height.equalTo(1)
        }
        
        badgeLabel.snp.makeConstraints{
            $0.bottom.equalTo(separatorView.snp.top).offset(-24)
            $0.centerX.equalToSuperview()
        }
        
        tamagotchiImageView.snp.makeConstraints{
            $0.bottom.equalTo(badgeLabel.snp.top).offset(-12)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(140)
        }
        
        descLabel.snp.makeConstraints{
            $0.top.equalTo(separatorView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }

        buttonStackView.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        buttonSeparatorView.snp.makeConstraints{
            $0.bottom.equalTo(buttonStackView.snp.top)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
    }
    
    private func configureView() {
        backgroundColor = .modal
        
        baseView.backgroundColor = .base
        baseView.layer.cornerRadius = 8
        baseView.layer.masksToBounds = true

        tamagotchiImageView.image = ._1_1
        
        badgeLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        badgeLabel.textColor = .point
        
        separatorView.backgroundColor = .point
        buttonSeparatorView.backgroundColor = .systemGray4
        
        descLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        descLabel.textColor = .point
        descLabel.textAlignment = .center
        descLabel.numberOfLines = 0

        buttonStackView.distribution = .fillEqually
        
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(.point, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        cancelButton.backgroundColor = .dim
        
        startButton.setTitle("시작하기", for: .normal)
        startButton.setTitleColor(.point, for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        startButton.backgroundColor = .base
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
