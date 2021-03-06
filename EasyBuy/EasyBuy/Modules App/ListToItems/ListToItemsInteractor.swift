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
    func getNextPageItemInformation(request: ListToItems.GetCategorie.Request)
    func getItemForNameInformation(request: ListToItems.GetItemForName.Request)
    func getNextItemForNameInformation(request: ListToItems.GetItemForName.Request)
}

protocol ListToItemsDataStore {
    var item:ItemModel? { get set }
}

class ListToItemsInteractor: ListToItemsBusinessLogic, ListToItemsDataStore {
    
    var presenter: ListToItemsPresentationLogic?
    var worker: ListToItemsWorker = ListToItemsWorker()
    var caregories: [Categorie] = []
    var offset: Int = 0
    var totalItemsGet : Int = 0
    var currencyTotalItems : Int = 0
    var item: ItemModel?
    
    func loadInitialInformation(request: ListToItems.LoadInitalData.Request) {
        worker.fetchCategories(country: UserDefaults.standard.getCurrencyContry()) { (response, result) in
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
        configInitialParametrs()
        worker.fetchCategorieForID(country: UserDefaults.standard.getCurrencyContry(), category: request.category, offset: "\(offset)") { (response, result) in
            switch result {
            case .success:
                guard let results = result.value else {
                    return
                }
                
                guard let items = results.items else {
                    return
                }
                if items.count > 0 {
                    let itemCodables: [ItemCodable] = self.returnItemCodable(items: items)
                    self.totalItemsGet = results.paging?.total ?? 0
                    self.currencyTotalItems = itemCodables.count
                    let areThereMoreItems = self.areThereMoreItems(totalItems: self.totalItemsGet, curretItems: self.currencyTotalItems)
                    let response = ListToItems.GetCategorie.Response(itemsCodable: itemCodables, areThereMoreItems: areThereMoreItems)
                    self.presenter?.presentCategoreInformation(response: response)
                }else{
                    let response = ServiceError.ErrorGeneral.Response(error: CustomErrors.errorNoData)
                    self.presenter?.presentErroItemInformation(response: response)
                }
            case .failure (let error):
                let response = ServiceError.ErrorGeneral.Response(error: error ?? CustomErrors.errorGeneralResponse)
                self.presenter?.presentErroItemInformation(response: response)
            }
        }
    }
    
    
    func getNextPageItemInformation(request: ListToItems.GetCategorie.Request) {
        offset += 1
        worker.fetchCategorieForID(country: UserDefaults.standard.getCurrencyContry(), category: request.category, offset: "\(offset)") { (response, result) in
            switch result {
            case .success:
                guard let results = result.value else {
                    return
                }
                
                guard let items = results.items else {
                    return
                }
                if items.count > 0 {
                    let itemCodables: [ItemCodable] = self.returnItemCodable(items: items)
                    self.currencyTotalItems += itemCodables.count
                    let areThereMoreItems = self.areThereMoreItems(totalItems: self.totalItemsGet, curretItems: self.currencyTotalItems)
                    let response = ListToItems.GetCategorie.Response(itemsCodable: itemCodables,areThereMoreItems: areThereMoreItems)
                    self.presenter?.presentgetNextPageItemInformation(response: response)
                }else{
                    let response = ServiceError.ErrorGeneral.Response(error: CustomErrors.errorNoData)
                    self.presenter?.presentErroItemInformation(response: response)
                }
            case .failure (let error):
                let response = ServiceError.ErrorGeneral.Response(error: error ?? CustomErrors.errorGeneralResponse)
                self.presenter?.presentErroItemInformation(response: response)
            }
        }
    }
    
    func getItemForNameInformation(request: ListToItems.GetItemForName.Request) {
        configInitialParametrs()
        worker.fetchItemForName(country: UserDefaults.standard.getCurrencyContry(), name: request.name, offset: "\(offset)") { (response, result) in
            switch result {
            case .success:
                guard let results = result.value else {
                    return
                }
                
                guard let items = results.items else {
                    return
                }
                if items.count > 0 {
                    let itemCodables: [ItemCodable] = self.returnItemCodable(items: items)
                    self.totalItemsGet = results.paging?.total ?? 0
                    self.currencyTotalItems = itemCodables.count
                    let areThereMoreItems = self.areThereMoreItems(totalItems: self.totalItemsGet, curretItems: self.currencyTotalItems)
                    let response = ListToItems.GetItemForName.Response(itemsCodable: itemCodables, areThereMoreItems: areThereMoreItems)
                    self.presenter?.presentgetItemForNameInformation(response: response)
                }else{
                    let response = ServiceError.ErrorGeneral.Response(error: CustomErrors.errorNoData)
                    self.presenter?.presentErroItemInformation(response: response)
                }
            case .failure (let error):
                let response = ServiceError.ErrorGeneral.Response(error: error ?? CustomErrors.errorGeneralResponse)
                self.presenter?.presentErroItemInformation(response: response)
            }
        }
    }
    
    func getNextItemForNameInformation(request: ListToItems.GetItemForName.Request) {
        offset += 1
        worker.fetchItemForName(country: UserDefaults.standard.getCurrencyContry(), name: request.name, offset: "\(offset)") { (response, result) in
            switch result {
            case .success:
                guard let results = result.value else {
                    return
                }
                
                guard let items = results.items else {
                    return
                }
                if items.count > 0 {
                    let itemCodables: [ItemCodable] = self.returnItemCodable(items: items)
                    self.currencyTotalItems += itemCodables.count
                    let areThereMoreItems = self.areThereMoreItems(totalItems: self.totalItemsGet, curretItems: self.currencyTotalItems)
                    let response = ListToItems.GetItemForName.Response(itemsCodable: itemCodables, areThereMoreItems: areThereMoreItems)
                    self.presenter?.presentgetNextItemForNameInformation(response: response)
                }else{
                    let response = ServiceError.ErrorGeneral.Response(error: CustomErrors.errorNoData)
                    self.presenter?.presentErroItemInformation(response: response)
                }
            case .failure (let error):
                let response = ServiceError.ErrorGeneral.Response(error: error ?? CustomErrors.errorGeneralResponse)
                self.presenter?.presentErroItemInformation(response: response)
            }
        }
    }
    
    
    
    func configInitialParametrs(){
        offset = 0
        self.totalItemsGet = 0
        self.currencyTotalItems = 0
    }
    
    
    func returnItemCodable(items:[Item])->[ItemCodable]{
        var itemCodables: [ItemCodable] = []
        
        for item in items {
            
            let itemCodable = ItemCodable(name: item.title ?? "",
                                          price: item.price ?? 0,
                                          condition: item.condition ?? "",
                                          soldQuantity: item.soldQuantity ?? 0,
                                          currencyID: item.currencyID ?? "",
                                          installments: item.installments,
                                          address: item.address,
                                          image: item.thumbnail ?? "",
                                          shipping: item.shipping,
                                          attributes: item.attributes)
            itemCodables.append(itemCodable)
        }
        
        return itemCodables
    }
    
    func areThereMoreItems(totalItems:Int,curretItems:Int)->Bool{
        return curretItems >= totalItems ? false : true
    }

}

