//
//  BasicNetworkEngineTest.swift
//  EasyBuyTests
//
//  Created by Andres Felipe Nunez on 14/05/21.
//

@testable import EasyBuy
import Foundation


class BasicNetworkEngineTest: NetworkEngine{
    
    var getUrl: URL {
      return URL(string: "/token")!
    }
    
    var response = HTTPURLResponse(url: URL(string: "/token")!,
                                   statusCode: 200,
                                   httpVersion: nil,
                                   headerFields: nil)
    
    var nameMockArchive:String = ""
    
    override func requestGeneric(request: URLRequest, completion: @escaping (Data?, HTTPURLResponse?, NSError?) -> Void) -> URLSessionDataTask {
       
        
        do {
            // Se genera una URL session Mock para retornar
            let mock = MockURLSessionDataTask(completionHandler: { (data, _, _) in }, url: URLRequest.init(url: getUrl), queue: nil)
            
            switch response?.statusCode {
            case 200:
                let data = try Data.fromJSON(fileName: nameMockArchive)
                DispatchQueue.main.async {
                    completion(data,self.response,nil)
                }
            case 404:
                DispatchQueue.main.async {
                    completion(nil,nil,CustomErrors.errorGeneralResponse)
                }
            case 500:
                DispatchQueue.main.async {
                    completion(nil,nil,nil)
                }
            default:
                DispatchQueue.main.async {
                    completion(nil,nil,nil)
                }
            }
            
            return mock
        }catch{
            let mock = MockURLSessionDataTask(completionHandler: { (_, _, _) in }, url: URLRequest.init(url: getUrl), queue: nil)
            DispatchQueue.main.async {
                completion(nil,nil,nil)
            }
            return mock
        }
    }
     
}

