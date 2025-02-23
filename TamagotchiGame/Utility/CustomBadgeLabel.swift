//
//  CustomBadgeLabel.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/22/25.
//

import UIKit

final class CustomBadgeLabel: UILabel {

    private var padding: UIEdgeInsets {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    init(padding: UIEdgeInsets = UIEdgeInsets(top: 6.0, left: 8.0, bottom: 6.0, right: 8.0)) {
        self.padding = padding
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        self.padding = UIEdgeInsets(top: 4.0, left: 8.0, bottom: 4.0, right: 8.0)
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        self.font = .systemFont(ofSize: 13, weight: .bold)
        self.textColor = .point
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.point.cgColor
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        self.textAlignment = .center
    }

    override func drawText(in rect: CGRect) {
        let insetRect = rect.inset(by: padding)
        super.drawText(in: insetRect)
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }
}
