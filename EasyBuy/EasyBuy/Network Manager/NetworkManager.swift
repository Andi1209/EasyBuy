//
//  NetworkManager.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 13/05/21.
//

import Foundation

struct NetworkManager {
    
    static var networkEngine: NetworkEngine = NetworkEngine.shared
    static var dataTask: URLSessionDataTask?
    
    static func requestBasicWithURLConvertible(uRLRequestConvertible: URLRequestConvertible,
                                               completion: @escaping(_ http: HTTPURLResponse, _ result: Result<Any>) -> Void) {
        
        NetworkManager.dataTask = nil
        dataTask = networkEngine.requestGeneric(request: uRLRequestConvertible.asURLRequest()) {(resultData, response, error) in
            NetworkManager.dataTask = nil
            if error != nil {
                completion(response ?? HTTPURLResponse.init(), Result<Any>.failure(error))
                return
            }
            
            guard let data = resultData else {
                completion(response ?? HTTPURLResponse.init(),
                           Result<Any>.failure(CustomErrors.errorGeneralResponse))
                return
            }
            
            apiDecodeController(data: data, uRLRequestConvertible: uRLRequestConvertible,
                                response: response ?? HTTPURLResponse.init(),
                                completion: { (resultData, response) in
                                    completion(resultData, response)
            })
        }
    }
    
    static func apiDecodeController(data: Data,
                                    uRLRequestConvertible: URLRequestConvertible,
                                    response: HTTPURLResponse,
                                    completion: @escaping(HTTPURLResponse, Result<Any>) -> Void) {
        let api = uRLRequestConvertible as? APIRouter
        let decoder = JSONDecoder()
        
        switch api.self {
        case  .categories?:
            guard let categoriesCodable = try? decoder.decode([Categorie].self, from: data) else {
                completion(response,
                           Result<Any>.failure(CustomErrors.errorGeneralResponse))
                return
            }
            completion(response, Result<Any>.success(categoriesCodable))
        case  .searchItemCat?:
            guard let itemListCodable = try? decoder.decode(ItemsResult.self, from: data) else {
                completion(response,
                           Result<Any>.failure(CustomErrors.errorGeneralResponse))
                return
            }
            completion(response, Result<Any>.success(itemListCodable))
        case  .searchItem?:
            guard let itemListCodable = try? decoder.decode(ItemsResult.self, from: data) else {
                completion(response,
                           Result<Any>.failure(CustomErrors.errorGeneralResponse))
                return
            }
            completion(response, Result<Any>.success(itemListCodable))
        case .none:
            break
            
        }
    }
}
