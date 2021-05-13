//
//  FontExtension.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 13/05/21.
//

import UIKit

extension UIFont {
    
    class func getFont(_ fontNameType:FontNameType, size:CGFloat)->UIFont{
        guard let font = UIFont(name: fontNameType.rawValue, size: size)
            else {
            fatalError("Error \(fontNameType.rawValue) not found")
        }
        
        return font
    }
    
    enum FontNameType:String{
        case bold = "SFProText-Bold"
        case semiBlod = "SFProText-Semibold"
        case medium = "SFProText-Medium"
        case regular = "SFProText-Regular"
    }
}

