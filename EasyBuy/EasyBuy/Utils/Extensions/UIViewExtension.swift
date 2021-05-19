//
//  UIViewExtension.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 14/05/21.
//

import UIKit


extension UIView {
    
    func setupGradient(){
        let gradient: CAGradientLayer = CAGradientLayer()
        var gradienColorSet: [[CGColor]] = []
        let colorIndex: Int = 0
        
        gradienColorSet = [[UIColor.yellowApp.cgColor,UIColor.yellowAlphaApp.cgColor]]
        
        gradient.frame = self.bounds
        gradient.colors = gradienColorSet[colorIndex]
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    
    func roundClipsToBounds(){
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
    }
    
    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 1
     }

}
