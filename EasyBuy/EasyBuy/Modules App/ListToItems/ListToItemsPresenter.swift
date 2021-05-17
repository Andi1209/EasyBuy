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
    func presentgetNextPageItemInformation(response: ListToItems.GetCategorie.Response)
    func presentgetItemForNameInformation(response: ListToItems.GetItemForName.Response)
    func presentgetNextItemForNameInformation(response: ListToItems.GetItemForName.Response)
    func presentErroItemInformation(response:ServiceError.ErrorGeneral.Response)
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
        let itemsModel:[ItemModel] = getItemsModel(itemsCodable: response.itemsCodable)
        let viewModel = ListToItems.GetCategorie.ViewModel(items: itemsModel, areThereMoreItems: response.areThereMoreItems)
        viewController?.displayCategoreInformation(viewModel:viewModel)
    }
    
    func presentgetNextPageItemInformation(response: ListToItems.GetCategorie.Response) {
        let itemsModel:[ItemModel] = getItemsModel(itemsCodable: response.itemsCodable)
        let viewModel = ListToItems.GetCategorie.ViewModel(items: itemsModel, areThereMoreItems: response.areThereMoreItems)
        viewController?.displayNextPageItemInformation(viewModel:viewModel)
    }
    
    func presentgetItemForNameInformation(response: ListToItems.GetItemForName.Response) {
        let itemsModel:[ItemModel] = getItemsModel(itemsCodable: response.itemsCodable)
        let viewModel = ListToItems.GetItemForName.ViewModel(items: itemsModel, areThereMoreItems: response.areThereMoreItems)
        viewController?.displaygetItemForNameInformation(viewModel:viewModel)
    }
    
    func presentgetNextItemForNameInformation(response: ListToItems.GetItemForName.Response) {
        let itemsModel:[ItemModel] = getItemsModel(itemsCodable: response.itemsCodable)
        let viewModel = ListToItems.GetItemForName.ViewModel(items: itemsModel, areThereMoreItems: response.areThereMoreItems)
        viewController?.displayNextItemForNameInformation(viewModel: viewModel)
    }
    
    func presentErroItemInformation(response: ServiceError.ErrorGeneral.Response) {
        let viewModel = ServiceError.ErrorGeneral.ViewModel(errorMesage: response.error.getErrorMessage(), error: response.error)
        viewController?.displayErroItemInformation(viewModel: viewModel)
    }
    
    
    
    func getItemsModel(itemsCodable: [ItemCodable])->[ItemModel]{
        var itemsModel:[ItemModel] = []
        for item in itemsCodable {
            
            let condition:Bool = getCondition(condition: item.condition)
            let freeShipping:Bool = getFreeShipping(shipping: item.shipping)
            let installments:String = getInstallments(installments: item.installments)
            let address:String = getAddress(address: item.address)
            let attributes:[AttributesModel] = getAttributes(attributes: item.attributes)
            
            let itemModel = ItemModel(name: item.name,
                                      condition: condition,
                                      price: "\(item.price)",
                                      currency: item.currencyID,
                                      installments: installments,
                                      address: address,
                                      image: item.image,
                                      freeShipping: freeShipping, attributes: attributes)
            itemsModel.append(itemModel)
        }
        return itemsModel
    }
    
    
    func getCondition(condition:String)->Bool{
        switch condition {
        case "new":
            return false
        default:
            return true
        }
        
    }
    
    func getInstallments(installments: Installments?)->String{
        let amount = installments?.amount ?? 0
        let quantity = installments?.quantity ?? 0
        return "Compralo en \(quantity)x \(amount) "
    }
    
    func getAddress(address:Address?)->String{
        let district = address?.cityName ?? ""
        let city = address?.stateName ?? ""
        return "\(district) - \(city)"
    }
    
    func getFreeShipping(shipping:Shipping?)->Bool{
          return shipping?.freeShipping ?? false
    }
    
    
    func getAttributes(attributes:[Attribute]?)-> [AttributesModel] {
        var attributesModel :[AttributesModel] = []
        guard let attributes = attributes else {return attributesModel}
        for attribute in attributes {
            if attribute.id != "ITEM_CONDITION" {
                let title = attribute.name ?? ""
                let valor = attribute.valueName ?? ""
                let atributeStruct = AttributesModel(title: title, vale: valor)
                attributesModel.append(atributeStruct)
            }
        }
          return attributesModel
    }
    
    
}

