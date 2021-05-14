//
//  LauncherWorker.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 13/05/21.

import UIKit

class LauncherWorker {
    
    func fetchResultsBy(country:String, completionHandler: @escaping (HTTPURLResponse, Result<[Categorie]>) -> Void) {
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
        case .failure(let error):
             completionHandler(response, Result<[Categorie]>.failure(error))
        }
    }}}

