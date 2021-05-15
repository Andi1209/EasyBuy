//
//  ListToItemsInteractor.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 14/05/21.
//

import UIKit

protocol ListToItemsBusinessLogic {
    func loadInitialInformation(request: ListToItems.LoadInitalData.Request)
    func getCategoreInformation(request: ListToItems.GetCategorie.Request)
}

protocol ListToItemsDataStore {
}

class ListToItemsInteractor: ListToItemsBusinessLogic, ListToItemsDataStore {
    
    var presenter: ListToItemsPresentationLogic?
    var worker: ListToItemsWorker = ListToItemsWorker()
    var caregories: [Categorie] = []
    
    func loadInitialInformation(request: ListToItems.LoadInitalData.Request) {
        worker.fetchCategories(country: "MCO") { (response, result) in
            switch result {
            case .success:
                guard let results = result.value else {
                    return
                }
                let response = ListToItems.LoadInitalData.Response(caregories: results)
                self.presenter?.presentInitialInformation(response: response)
            case .failure (_):
                let response = ListToItems.ErrorCategorias.Response()
                self.presenter?.presentInitialInformationError(response: response)
            }
        }
    }
    
    func getCategoreInformation(request: ListToItems.GetCategorie.Request) {
        worker.fetchCategorieForID(country: "MCO", category: request.category, offset: request.offset) { (response, result) in
            switch result {
            case .success:
                guard let results = result.value else {
                    return
                }
                let response = ListToItems.GetCategorie.Response()
                self.presenter?.presentCategoreInformation(response: response)
            case .failure (_):
                let response = ListToItems.ErrorCategorias.Response()
                self.presenter?.presentInitialInformationError(response: response)
            }
        }
    }
}

