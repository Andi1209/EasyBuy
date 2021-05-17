//
//  ImageViewExtension.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 17/05/21.
//

import UIKit

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
