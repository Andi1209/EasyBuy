//
//  SubtitleBoldLabel.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 13/05/21.
//

import UIKit

class SubtitleBoldLabel: UILabel {
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

fileprivate extension SubtitleBoldLabel {
    func configureLabel() {
        textColor = UIColor.blackLightDarkApp
        numberOfLines = 0
        font = UIFontMetrics(forTextStyle: .title2).scaledFont(for: UIFont.getFont(.bold, size: 16))
    }
}
