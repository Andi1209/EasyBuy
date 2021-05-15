//
//  LauncherRouter.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 13/05/21.

import UIKit

@objc protocol LauncherRoutingLogic {
    func routeToListToItems()
}

protocol LauncherDataPassing {
    var dataStore: LauncherDataStore? { get }
}

class LauncherRouter: NSObject, LauncherRoutingLogic, LauncherDataPassing {
    weak var viewController: LauncherViewController?
    var dataStore: LauncherDataStore?
    
    // MARK: Routing
    func routeToListToItems()
    {
        let destinationVC = ListToItemsViewController()
        navigateToListToItems(source: viewController ?? LauncherViewController(), destination: destinationVC)
    }
    
    // MARK: Navigation
    
    func navigateToListToItems(source: LauncherViewController, destination: ListToItemsViewController)
    {
        let navigation = UINavigationController(rootViewController: destination)
        navigation.modalPresentationStyle = .overFullScreen
        navigation.modalTransitionStyle = .coverVertical
        source.show(destination, sender: nil)
    }
}

