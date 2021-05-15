//
//  BodyMediumLabel.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 14/05/21.
//

import UIKit

class BodyMediumLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureLabel()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

fileprivate extension BodyMediumLabel {
    func configureLabel() {
        textColor = UIColor.blackAlphaApp
        numberOfLines = 0
        font = UIFontMetrics(forTextStyle: .title2).scaledFont(for: UIFont.getFont(.medium, size: 11))
    }
}
