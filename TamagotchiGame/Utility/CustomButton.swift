//
//  CustomButton.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/24/25.
//

import UIKit

final class CustomButton: UIButton {

    enum ButtonType {
        case food
        case water

        var title: String {
            switch self {
            case .food: return "밥주기"
            case .water: return "물주기"
            }
        }

        var image: UIImage? {
            switch self {
            case .food: return UIImage(systemName: "leaf.circle")?.withTintColor(.point).withRenderingMode(.alwaysOriginal)
            case .water: return UIImage(systemName: "drop.circle")?.withTintColor(.point).withRenderingMode(.alwaysOriginal)
            }
        }
    }

    init(type: ButtonType) {
        super.init(frame: .zero)
        configureButton(for: type)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureButton(for: .food)
    }

    private func configureButton(for type: ButtonType) {
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        config.image = type.image
        config.imagePlacement = .leading
        config.imagePadding = 6
        config.cornerStyle = .medium
        config.background.strokeColor = .point
        config.background.strokeWidth = 1

        var titleAttr = AttributedString(type.title)
        titleAttr.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        titleAttr.foregroundColor = .point
        config.attributedTitle = titleAttr

        self.configuration = config
        self.tintColor = .point
        self.configuration?.baseBackgroundColor = .base
        self.configuration?.baseForegroundColor = .point
    }
}
