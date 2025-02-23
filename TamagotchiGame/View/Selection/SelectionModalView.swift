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
    // TODO: Custom Label 분리
    private let badgeLabel = UILabel()
    private let separatorView = UIView()
    private let descLabel = UILabel()
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
        badgeLabel.text = tamagotchi.type
        descLabel.text = tamagotchi.desc
    }
    
    private func configureHierarchy() {
        addSubview(baseView)
        baseView.addSubview(tamagotchiImageView)
        baseView.addSubview(badgeLabel)
        baseView.addSubview(separatorView)
        baseView.addSubview(descLabel)
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
    }
    
    private func configureView() {
        backgroundColor = .modal
        
        baseView.backgroundColor = .base
        baseView.layer.cornerRadius = 8

        
        tamagotchiImageView.image = ._1_1
        
        badgeLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        badgeLabel.textColor = .point
        
        separatorView.backgroundColor = .point
        
        descLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descLabel.textColor = .point
        descLabel.textAlignment = .center
        descLabel.numberOfLines = 0

        buttonStackView.distribution = .fillEqually
        
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(.point, for: .normal)
        
        startButton.setTitle("시작하기", for: .normal)
        startButton.setTitleColor(.point, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
