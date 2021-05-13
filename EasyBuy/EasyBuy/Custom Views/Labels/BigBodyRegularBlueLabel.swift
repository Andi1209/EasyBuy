//
//  BigBodyRegularBlueLabel.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 13/05/21.
//

import UIKit

class BigBodyRegularBlueLabel: UILabel {
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

fileprivate extension BigBodyRegularBlueLabel {
    func configureLabel() {
        textColor = UIColor.blueApp
        numberOfLines = 0
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.getFont(.regular, size: 16))
    }
}
