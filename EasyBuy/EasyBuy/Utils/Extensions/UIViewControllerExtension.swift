//
//  UIViewControllerExtension.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 18/05/21.
//

import UIKit

extension UIViewController {
    
    class func displaySpinner(onView: UIView, aIndicator:RotatingCirclesView) -> UIView {
        let spinnerView =  UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let aIndicator = aIndicator 
        let centerXConstraint = NSLayoutConstraint(item: aIndicator,
                                                  attribute: NSLayoutConstraint.Attribute.centerX,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: spinnerView, attribute: NSLayoutConstraint.Attribute.centerX,
                                                  multiplier: 1,
                                                  constant: 0)
        
        let centerYConstraint = NSLayoutConstraint(item: aIndicator,
                                                  attribute: NSLayoutConstraint.Attribute.centerY,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: spinnerView, attribute: NSLayoutConstraint.Attribute.centerY,
                                                  multiplier: 1,
                                                  constant: 0)
        
        let heightConstraint = NSLayoutConstraint(item: aIndicator,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant:  (spinnerView.bounds.height*0.06))
        
        let widthConstraint = NSLayoutConstraint(item: aIndicator,
                                                  attribute: NSLayoutConstraint.Attribute.width,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant:  (spinnerView.bounds.width*0.8))
        spinnerView.addConstraints([centerYConstraint,centerXConstraint, heightConstraint,widthConstraint])
        aIndicator.config(width: (spinnerView.bounds.width*0.8), height: spinnerView.bounds.height*0.06)
        aIndicator.animate(aIndicator.circle1, counter: 1)
        aIndicator.animate(aIndicator.circle2, counter: 3)
        DispatchQueue.main.async {
            spinnerView.addSubview(aIndicator)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner: UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
