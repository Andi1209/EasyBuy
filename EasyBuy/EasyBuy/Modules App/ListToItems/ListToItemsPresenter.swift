//
//  ListToItemsPresenter.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 14/05/21.


import UIKit

protocol ListToItemsPresentationLogic {
    func presentInitialInformation(response: ListToItems.LoadInitalData.Response)
    func presentInitialInformationError(response: ListToItems.ErrorCategorias.Response)
    func presentCategoreInformation(response: ListToItems.GetCategorie.Response)
}

class ListToItemsPresenter: ListToItemsPresentationLogic {
    
    weak var viewController: ListToItemsDisplayLogic?
    
    func presentInitialInformation(response: ListToItems.LoadInitalData.Response) {
        let viewModel = ListToItems.LoadInitalData.ViewModel(caregories: response.caregories)
        viewController?.displayInitialInformation(viewModel: viewModel)
    }
    
    func presentInitialInformationError(response: ListToItems.ErrorCategorias.Response) {
        let messageError = NSLocalizedString("listToItems.label.errorCategorias", comment: "")
        let viewModel = ListToItems.ErrorCategorias.ViewModel(messageErrorCategories: messageError)
        viewController?.displayInitialInformationError(viewModel:viewModel)
    }
    
    func presentCategoreInformation(response: ListToItems.GetCategorie.Response) {
        let viewModel = ListToItems.GetCategorie.ViewModel()
        viewController?.displayCategoreInformation(viewModel:viewModel)
    }
    
    
}

