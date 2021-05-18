//
//  ItemDetailRouter.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 17/05/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

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
    
    // MARK: Routing
    
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier:
    //"SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source:
    //ItemDetailViewController, destination:
    //SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: ItemDetailDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}

