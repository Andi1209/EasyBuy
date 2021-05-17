//
//  DobleExtension.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 17/05/21.
//

import Foundation


extension Double {
    
    
    
    func getPriceFormat()->String{
        let number = NSNumber(value: self)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        return formatter.string(from: number) ?? "" //5,432.10
    }
    
    
}
