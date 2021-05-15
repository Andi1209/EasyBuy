//
//  ListToItemsWorker.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 14/05/21.

import UIKit

class ListToItemsWorker {
    
    func fetchCategories(country:String, completionHandler: @escaping (HTTPURLResponse, Result<[Categorie]>) -> Void) {
        Log.shared.reportLog(appDocument: AppDocument.logServices, parameters: [Params.proceso.rawValue:Processes.categoriesGet.rawValue])
        NetworkManager.requestBasicWithURLConvertible(uRLRequestConvertible:
                                                        APIRouter.categories(country:country)) { (response, result) in
            
            switch result {
            case .success(let rearchResults):
                guard let searchReponse = rearchResults as? [Categorie] else {
                    completionHandler(response, Result<[Categorie]>.failure(CustomErrors.errorGeneralResponse))
                    return
                }
                completionHandler(response,
                                  Result<[Categorie]>.success(searchReponse))
                Log.shared.reportLog(appDocument: AppDocument.logServices, parameters: [Params.proceso.rawValue:Processes.categoriesGet.rawValue,Params.response.rawValue:Params.succesResponse.rawValue])
            case .failure(let error):
                completionHandler(response, Result<[Categorie]>.failure(error))
                Log.shared.reportLog(appDocument: AppDocument.logServices, parameters: [Params.proceso.rawValue:Processes.categoriesGet.rawValue,Params.response.rawValue: error?.localizedDescription ?? "undescribed error"])
            }
        }
    }
    
    
    func fetchCategorieForID(country:String,category:String,offset:String,completionHandler: @escaping (HTTPURLResponse, Result<ItemsResult>) -> Void) {
        Log.shared.reportLog(appDocument: AppDocument.logServices, parameters: [Params.proceso.rawValue:Processes.categoriesGetForId.rawValue])
        NetworkManager.requestBasicWithURLConvertible(uRLRequestConvertible: APIRouter.searchItemCat(country: country, category: category, offset: offset)){ (response, result) in
            
            switch result {
            case .success(let rearchResults):
                guard let searchReponse = rearchResults as? ItemsResult else {
                    completionHandler(response, Result<ItemsResult>.failure(CustomErrors.errorGeneralResponse))
                    return
                }
                completionHandler(response,
                                  Result<ItemsResult>.success(searchReponse))
                Log.shared.reportLog(appDocument: AppDocument.logServices, parameters: [Params.proceso.rawValue:Processes.categoriesGetForId.rawValue,Params.response.rawValue:Params.succesResponse.rawValue])
            case .failure(let error):
                completionHandler(response, Result<ItemsResult>.failure(error))
                Log.shared.reportLog(appDocument: AppDocument.logServices, parameters: [Params.proceso.rawValue:Processes.categoriesGetForId.rawValue,Params.response.rawValue: error?.localizedDescription ?? "undescribed error"])
            }
        }
                                                        
    }
}

