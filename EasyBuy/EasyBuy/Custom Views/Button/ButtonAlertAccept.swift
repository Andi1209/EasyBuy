//
//  ButtonAlertAccept.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 16/05/21.
//

import UIKit


class ButtonAlertAccept: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpButton()
    }
    func setUpButton() {
        setTitleColor(UIColor.blackAlphaApp, for: .normal)
        titleLabel?.font = UIFontMetrics(forTextStyle: .title2).scaledFont(for: UIFont.getFont(.bold, size: 14))
    }

}

