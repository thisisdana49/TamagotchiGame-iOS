//
//  SelectionModalView.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/22/25.
//

import UIKit
import SnapKit

final class SelectionModalView: UIView {
    
    private let baseView = UIView()
    private let tamagotchiImageView = UIImageView()
    // TODO: Custom Label 분리
    private let badgeLabel = UILabel()
    private let separatorView = UIView()
    private let descLabel = UILabel()
    private let buttonStackView = UIStackView()
    private let cancelButton = UIButton()
    private let startButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
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
        
        badgeLabel.text = "방실방실 다마고치"
        badgeLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        badgeLabel.textColor = .point
        
        separatorView.backgroundColor = .point
        
        descLabel.text = "저는 방실방실 다마고치 매일 웃고 있어요"
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
