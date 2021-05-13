//
//  LauncherRouter.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 13/05/21.

import UIKit

@objc protocol LauncherRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol LauncherDataPassing {
    var dataStore: LauncherDataStore? { get }
}

class LauncherRouter: NSObject, LauncherRoutingLogic, LauncherDataPassing {
    weak var viewController: LauncherViewController?
    var dataStore: LauncherDataStore?
    
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
    //LauncherViewController, destination:
    //SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: LauncherDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}

