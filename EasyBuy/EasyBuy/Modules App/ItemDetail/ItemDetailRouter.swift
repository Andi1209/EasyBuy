//
//  ItemDetailRouter.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 17/05/21.

import UIKit

@objc protocol ItemDetailRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ItemDetailDataPassing {
    var dataStore: ItemDetailDataStore? { get }
}

class ItemDetailRouter: NSObject, ItemDetailRoutingLogic, ItemDetailDataPassing {
    weak var viewController: ItemDetailViewController?
    var dataStore: ItemDetailDataStore?
    
}

