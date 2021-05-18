//
//  RotatingCirclesView.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 18/05/21.
//

import UIKit

class RotatingCirclesView: UIView {
    
    var circle1: UIView!
    var circle2: UIView!
    var finish:Bool!
    private var positions : [CGRect]!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(width:CGFloat, height:CGFloat){
        finish = false
        translatesAutoresizingMaskIntoConstraints = false
        
        let midel = width - (width/2) - 50
        addPositions(width: width, height: height, midel: midel)
        
        circle1 = UIView(frame: CGRect(x: midel, y: 0, width: height, height: height))
        circle2 = UIView(frame: CGRect(x: midel + 100, y:  0, width: height, height: height))
        
        circle1.backgroundColor = UIColor.yellowApp.withAlphaComponent(0.9)
        circle1.layer.cornerRadius = circle1.frame.width / 2
        circle1.layer.zPosition = 2
        
        circle2.backgroundColor = UIColor.yellowAlphaApp.withAlphaComponent(0.6)
        circle2.layer.cornerRadius = circle2.frame.width / 2
        circle2.layer.zPosition = 1
    
        addSubview(circle1)
        addSubview(circle2)
    }
    
    
    private func addPositions(width:CGFloat, height:CGFloat, midel:CGFloat ){
        let heightPlusTen = height + 10
        let heightlessTen = height - 10
        
        let midelPlusTen = midel + 10
        let midelPlusFourty = midel + 40
        let midelPlusNine = midel + 90
        
        
        positions = [CGRect(x: midelPlusTen, y: 0, width: height, height: height),
                                    CGRect(x: midelPlusFourty, y: -5, width: heightPlusTen, height: heightPlusTen),
                                    CGRect(x: midelPlusNine, y: 0, width: height, height: height),
                                    CGRect(x: midelPlusFourty, y: 5, width: heightlessTen, height: heightlessTen)]
    }
    
    func animate(_ circle: UIView, counter:Int){
        var counter = counter
        print("Ejecutando")
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear,animations: {
            circle.frame = self.positions[counter]
            circle.layer.cornerRadius = circle.frame.width / 2
            
            switch counter {
            case 1:
                if circle == self.circle1 { self.circle1.layer.zPosition  = 2 }
            case 3:
                if circle == self.circle1 { self.circle1.layer.zPosition  = 0 }
            default:
                break
            }
        } ) { (completion)  in
            switch counter {
            case 0...2:
                counter += 1
            case 3:
                counter = 0
            default:
                break
            }
            if !self.finish {
                self.animate(circle, counter: counter)
            }else{
                self.circle1.removeFromSuperview()
                self.circle2.removeFromSuperview()
            }
        }
           
    }
    
}

