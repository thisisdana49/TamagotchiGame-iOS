//
//  CustomUnderLineTextField.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/24/25.
//

import UIKit

final class CustomUnderLineTextField: UITextField {

    private let underlineLayer = CALayer()

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        borderStyle = .none
        layer.addSublayer(underlineLayer)

        underlineLayer.backgroundColor = UIColor.point.cgColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateUnderline()
    }

    private func updateUnderline() {
        let underlineHeight: CGFloat = 1
        let yPosition = bounds.height - underlineHeight
        underlineLayer.frame = CGRect(x: 0, y: yPosition, width: bounds.width, height: underlineHeight)
    }
}
