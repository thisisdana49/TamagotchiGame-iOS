//
//  SelectionTypeView.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/22/25.
//

import UIKit
import SnapKit

final class SelectionTypeView: UIView {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    private func configureUI() {
        backgroundColor = .base
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints{
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        collectionView.backgroundColor = .base
    }
    
    private func setCollectionViewLayout() -> UICollectionViewFlowLayout {
        let inset: CGFloat = 16
        let spacing: CGFloat = 20
        let deviceWidth = UIScreen.main.bounds.width
        // TODO: Compositional Layout or FlowDelegate으로 변경
//        let deviceWidth = window?.window?.windowScene?.screen.bounds.width ?? 0
        print(#function, deviceWidth)
        let itemSize = deviceWidth - (inset * 2) - (spacing * 2)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemSize / 3, height: itemSize / 2)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        layout.scrollDirection = .vertical
        
        return layout
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
