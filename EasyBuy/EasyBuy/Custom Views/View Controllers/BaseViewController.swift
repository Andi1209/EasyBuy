//
//  BaseViewController.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 13/05/21.
//

import UIKit

enum NavigationBarType {
    case back
    case none
}

class BaseViewController: UIViewController{
    
    
    var navigationBar = UIView()
    var titleLabelNavigationBar = BigBodyRegularGreenLabel()
    var backButtonNavigationBar = UIButton(type: .custom)
    var rightButtonNavigationBar = UIButton(type: .custom)
    var actionLeftButtonNAvigationBar: (()->Void) = {}
    var withAnimation:Bool = true
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpConstraints()
    }
    
    override func viewDidLoad() {
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupUI() {
        view.addSubview(navigationBar)
        navigationBar.addSubview(backButtonNavigationBar)
        navigationBar.addSubview(titleLabelNavigationBar)
        navigationBar.addSubview(rightButtonNavigationBar)
        let imageTemplate = UIImage(named: "bagTobuy")!
        backButtonNavigationBar.setImage(imageTemplate, for: .normal)
        backButtonNavigationBar.imageView?.contentMode = .scaleAspectFit
        backButtonNavigationBar.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
        titleLabelNavigationBar.textAlignment = .center
        titleLabelNavigationBar.text = ""
        titleLabelNavigationBar.numberOfLines = 0

    }
    
    func setUpConstraints() {
        setUpNavigationBarConstraints()
        setUpBackButtonNBBConstraints()
        setUpTitleConstraints()
        setRightButtonNBBConstraints()
    }
    
    @objc func actionBack() {
        actionLeftButtonNAvigationBar()
        self.navigationController?.popViewController(animated: withAnimation)
    }
    
    func setEnableNavigationbar(type: NavigationBarType) {
        switch type {
        case .back:
            backButtonNavigationBar.isHidden = false
        case .none:
            //menuButtonNavigationBar.isHidden = true
            backButtonNavigationBar.isHidden = true
        }
        
        navigationBar.isHidden = false
    }
    
    func setTitleLabelNavigationBar(title: String, colortext:UIColor) {
        titleLabelNavigationBar.text = title
        titleLabelNavigationBar.textColor = colortext
    }
    
}


extension BaseViewController {
    func setUpNavigationBarConstraints() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        let leftConstraint = NSLayoutConstraint(item: navigationBar,
                                                attribute: NSLayoutConstraint.Attribute.leading,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: view, attribute: NSLayoutConstraint.Attribute.leading,
                                                multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: navigationBar,
                                                 attribute: NSLayoutConstraint.Attribute.trailing,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: view,
                                                 attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1,
                                                 constant: 0)
        let topConstraint = NSLayoutConstraint(item: navigationBar,
                                               attribute: NSLayoutConstraint.Attribute.top,
                                               relatedBy: NSLayoutConstraint.Relation.equal,
                                               toItem: view, attribute: NSLayoutConstraint.Attribute.topMargin,
                                               multiplier: 1,
                                               constant: 5)
        let heightConstraint = NSLayoutConstraint(item: navigationBar,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant:  (self.view.bounds.height*0.044))
        view.addConstraints([leftConstraint, rightConstraint, topConstraint, heightConstraint])
    }
    
    func setUpBackButtonNBBConstraints() {
        backButtonNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        let leftConstraint = NSLayoutConstraint(item: backButtonNavigationBar,
                                                attribute: NSLayoutConstraint.Attribute.leading,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: navigationBar, attribute: NSLayoutConstraint.Attribute.leading,
                                                multiplier: 1, constant: 16)
        let widthConstraint = NSLayoutConstraint(item: backButtonNavigationBar,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1,
                                                 constant: (self.view.bounds.height*0.04))
        let centerConstraint = NSLayoutConstraint(item: backButtonNavigationBar,
                                                  attribute: NSLayoutConstraint.Attribute.centerY,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: navigationBar, attribute: NSLayoutConstraint.Attribute.centerY,
                                                  multiplier: 1,
                                                  constant: 0)
        let heightConstraint = NSLayoutConstraint(item: backButtonNavigationBar,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: (self.view.bounds.height*0.04))
        view.addConstraints([leftConstraint, widthConstraint, centerConstraint, heightConstraint])
    }
    func setUpTitleConstraints() {
        titleLabelNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        let leftConstraint = NSLayoutConstraint(item: titleLabelNavigationBar,
                                                attribute: NSLayoutConstraint.Attribute.leading,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: backButtonNavigationBar, attribute: NSLayoutConstraint.Attribute.trailing,
                                                multiplier: 1, constant: 10)
        let rightConstraint = NSLayoutConstraint(item: titleLabelNavigationBar,
                                                 attribute: NSLayoutConstraint.Attribute.trailing,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: rightButtonNavigationBar,
                                                 attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1,
                                                 constant: -10)
        let centerConstraint = NSLayoutConstraint(item: titleLabelNavigationBar,
                                                  attribute: NSLayoutConstraint.Attribute.centerY,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: navigationBar, attribute: NSLayoutConstraint.Attribute.centerY,
                                                  multiplier: 1,
                                                  constant: 0)
        let heightConstraint = NSLayoutConstraint(item: titleLabelNavigationBar,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: self.view.bounds.height*0.04)
        view.addConstraints([leftConstraint, rightConstraint, centerConstraint, heightConstraint])
    }
    
    func setRightButtonNBBConstraints() {
        rightButtonNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        let rightConstraint = NSLayoutConstraint(item: rightButtonNavigationBar,
                                                 attribute: NSLayoutConstraint.Attribute.trailing,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: navigationBar, attribute: NSLayoutConstraint.Attribute.trailing,
                                                 multiplier: 1, constant: -16)
        let widthConstraint = NSLayoutConstraint(item: rightButtonNavigationBar,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1,
                                                 constant: (self.view.bounds.height*0.04))
        let centerConstraint = NSLayoutConstraint(item: rightButtonNavigationBar,
                                                  attribute: NSLayoutConstraint.Attribute.centerY,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: navigationBar, attribute: NSLayoutConstraint.Attribute.centerY,
                                                  multiplier: 1,
                                                  constant: 0)
        let heightConstraint = NSLayoutConstraint(item: rightButtonNavigationBar,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: (self.view.bounds.height*0.04))
        view.addConstraints([rightConstraint , widthConstraint, centerConstraint, heightConstraint])
    }
    
    
   
    
}
