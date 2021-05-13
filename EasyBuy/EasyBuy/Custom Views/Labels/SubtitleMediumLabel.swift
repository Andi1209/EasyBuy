//
//  SubtitleMediumLabel.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 13/05/21.
//

import UIKit

class SubtitleMediumLabel: UILabel {
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

fileprivate extension SubtitleMediumLabel {
    func configureLabel() {
        textColor = UIColor.black
        numberOfLines = 0
        font = UIFontMetrics(forTextStyle: .title2).scaledFont(for: UIFont.getFont(.medium, size: 16))
    }
}
