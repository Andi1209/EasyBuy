//
//  BigTitleSemiboldLabel.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 13/05/21.
//

import UIKit

class BigTitleSemiboldLabel: UILabel {
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

fileprivate extension BigTitleSemiboldLabel {
    func configureLabel() {
        textColor = UIColor.blackLightApp
        numberOfLines = 0
        font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: UIFont.getFont(.semiBlod, size: 21))
    }
}
