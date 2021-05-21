//
//  ListToItemsRouter.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 14/05/21.

import UIKit

@objc protocol ListToItemsRoutingLogic {
    func routeToDetalleToItem()
}

protocol ListToItemsDataPassing {
    var dataStore: ListToItemsDataStore? { get }
    var item:ItemModel? { get set }
}

class ListToItemsRouter: NSObject, ListToItemsRoutingLogic, ListToItemsDataPassing {
    
    
    weak var viewController: ListToItemsViewController?
    var dataStore: ListToItemsDataStore?
    var item: ItemModel?
    
    // MARK: Routing
    
    func routeToDetalleToItem() {
        let destinationVC = ItemDetailViewController()
        guard let item = item else {return}
        dataStore?.item = item
        var destinationDS = destinationVC.router!.dataStore!
        passDataToDetalleToItem(source: dataStore!, destination: &destinationDS)
        navigateToDetalleToItem(source: viewController ?? ListToItemsViewController(), destination: destinationVC)
    }
    
    
    // MARK: Navigation
    
    func navigateToDetalleToItem(source: ListToItemsViewController, destination: ItemDetailViewController) {
        let navigation = UINavigationController(rootViewController: destination)
        navigation.modalPresentationStyle = .overFullScreen
        navigation.modalTransitionStyle = .coverVertical
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataToDetalleToItem(source: ListToItemsDataStore, destination: inout ItemDetailDataStore) {
        destination.item = source.item
    }
}

