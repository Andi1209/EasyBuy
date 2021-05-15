//
//  APIRouter.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 13/05/21.
//

import Foundation
import UIKit

enum APIRouter: URLRequestConvertible{
    case searchItem(name:String, country:String, offset:String)
    case categories(country:String)
    case searchItemCat(country:String,category:String,offset:String)
    
    private var method: HTTPMethod{
        switch self {
        case .categories, .searchItemCat ,.searchItem:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .categories(let country):
            return URLK.categories.rawValue.replacingOccurrences(of: "$SITE_ID", with: country)
        case .searchItemCat(let country,_,_):
            return  URLK.searchItem.rawValue.replacingOccurrences(of: "$SITE_ID", with: country)
        case .searchItem(_ , let country, _):
            return  URLK.searchItem.rawValue.replacingOccurrences(of: "$SITE_ID", with: country)
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .categories(_):
            return nil
        case .searchItemCat( _, let category,let offset):
            return ["category":category,"offset":offset,"limit":"40"]
        case .searchItem(let name, _, let offset):
            return ["q":name,"offset":offset,"limit":"40"]
        }
    }
    
    
    
    
    func asURLRequest() -> URLRequest {
        var url: URL
        var urlRequest: URLRequest
        
        switch self {
        case .categories,.searchItemCat ,.searchItem:
            
            url = returnUrl(api: self)
            url = url.appendingPathComponent(path)
            let urlString =  url.absoluteString
            var urlComponents =  URLComponents(string: urlString)
            
            if parameters != nil {
                let parameters =  self.parameters!.stringFromHttpParameters()
                urlComponents?.query  =  parameters.removingPercentEncoding
            }
            
            let urlSearch = urlComponents?.url
            
            urlRequest = URLRequest(url: urlSearch!)
            
            urlRequest.httpMethod = method.rawValue
            
        }
        return urlRequest
    }
    
}

