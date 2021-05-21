//
//  APIConstant.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 13/05/21.
//

import Foundation

public protocol URLRequestConvertible{
    func asURLRequest() -> URLRequest
}

extension URLRequestConvertible{
    public var urlRequest: URLRequest? { return asURLRequest() }
}

extension URLRequest: URLRequestConvertible{
    public func asURLRequest() -> URLRequest { return self }
}

enum Result<Value> {
    case success(Value)
    case failure(NSError?)
    
    var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    var isFailure: Bool {
        return !isSuccess
    }
    
    var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }

}

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

public typealias Parameters = [String: Any]

enum URLK: String {
    case searchItem = "sites/$SITE_ID/search"
    case categories = "sites/$SITE_ID/categories"
}

enum HTTPHeaderField: String {
    case authorization = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "accept"
    case acceptEncoding = "Accept-Encoding"
}



enum ContentType: String {
    case json = "application/json"
    case bearer = "Bearer "
}

func returnUrl(api: APIRouter) -> URL {
    switch api {
    case .categories, .searchItemCat ,.searchItem:
        return Environment.getBaseURL
    }
}


