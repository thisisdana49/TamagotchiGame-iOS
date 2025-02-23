//
//  SelectionTypeCollectionViewCell.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/22/25.
//

import UIKit
import SnapKit

class SelectionTypeCollectionViewCell: UICollectionViewCell {
    
    static let id = "SelectionTypeCollectionViewCell"
    
    let tamagotchiImageView = UIImageView()
    let badgeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureData(with element: Tamagotchi) {
        if !element.isReady {
            tamagotchiImageView.image = UIImage(named: "\(element.id)-6")
            badgeLabel.text = element.badge
        } else {
            tamagotchiImageView.image = .no
            badgeLabel.text = "준비중이에요"
        }
    }
    
    private func configureHierarchy() {
        addSubview(tamagotchiImageView)
        addSubview(badgeLabel)
    }
    
    private func configureLayout() {
        tamagotchiImageView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(110)
        }
        
        badgeLabel.snp.makeConstraints{
            $0.top.equalTo(tamagotchiImageView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    private func configureView() {
        tamagotchiImageView.image = ._1_1
        
        badgeLabel.text = "방실방실 다마고치"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
