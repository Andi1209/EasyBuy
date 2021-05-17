//
//  AlertViewController.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 16/05/21.
//

import UIKit

class AlertViewController: UIViewController {
    
    
    
    @IBOutlet weak var viewManiAlert: UIView!
    @IBOutlet weak var viewHeaderAlert: UIView!
    @IBOutlet weak var textToAlert: BodyMediumLabel!
    @IBOutlet weak var buttonAccept: UIButton!
    
    
    typealias RightAction = () -> Void
    
    var rightAction: RightAction
    var textAlert:String = ""
    var textButton:String = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()
        viewManiAlert.dropShadow()
        textToAlert.text = textAlert
        viewManiAlert.layer.masksToBounds = true
        viewManiAlert.layer.cornerRadius = 8
        buttonAccept.setTitle(textButton, for: .normal)
        buttonAccept.addTarget(self, action:#selector(actionRightButton) , for: .touchUpInside)
        // Do any additional setup after loading the view.
    }

    init(text:String, actionButton: @escaping RightAction={}) {
        self.textAlert = text
        rightAction = actionButton
        textButton = "Acceptar"
        super.init(nibName: "AlertViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        rightAction = {}
        self.textAlert = ""
        self.textButton = ""
        super.init(coder: aDecoder)
    }


    @objc func actionRightButton(){
        self.dismiss(animated: true) {
            self.rightAction()
        }
    }

}
