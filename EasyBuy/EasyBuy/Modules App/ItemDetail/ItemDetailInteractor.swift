//
//  ItemDetailInteractor.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 17/05/21.
//

import UIKit

protocol ItemDetailBusinessLogic {
    func loadInitialInformation(request: ItemDetail.LoadInitalData.Request)
}

protocol ItemDetailDataStore {
    var item:ItemModel? { get set }
}

class ItemDetailInteractor: ItemDetailBusinessLogic, ItemDetailDataStore {
    var presenter: ItemDetailPresentationLogic?
    var worker: ItemDetailWorker = ItemDetailWorker()
    var item:ItemModel?
    
    func loadInitialInformation(request: ItemDetail.LoadInitalData.Request){
        guard let item = self.item else {return}
        let response = ItemDetail.LoadInitalData.Response(item: item)
        presenter?.presentInitialInformation(response: response)
    }
}

