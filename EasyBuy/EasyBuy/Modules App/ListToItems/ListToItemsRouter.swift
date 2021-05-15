//
//  ListToItemsRouter.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 14/05/21.

import UIKit

@objc protocol ListToItemsRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ListToItemsDataPassing {
    var dataStore: ListToItemsDataStore? { get }
}

class ListToItemsRouter: NSObject, ListToItemsRoutingLogic, ListToItemsDataPassing {
    weak var viewController: ListToItemsViewController?
    var dataStore: ListToItemsDataStore?
    
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
    //ListToItemsViewController, destination:
    //SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: ListToItemsDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}

