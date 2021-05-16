//
//  NetworkEngine.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 13/05/21.
//

import Foundation

protocol BasicNetworkEngineProtocol: AnyObject {
    func requestGeneric(request: URLRequest, completion: @escaping(Data?, HTTPURLResponse?, NSError?) -> Void) -> URLSessionDataTask
}

class NetworkEngine: BasicNetworkEngineProtocol {
    
    let  session: URLSession
    let  responseQueue: DispatchQueue?
    
    static let shared =
        NetworkEngine(
      session: .shared,
          responseQueue: .main
          )
    
    init(session: URLSession,
         responseQueue: DispatchQueue?) {
      self.session = session
      self.responseQueue = responseQueue
    }
    
    func requestGeneric(request: URLRequest, completion: @escaping(Data?, HTTPURLResponse?, NSError?) -> Void) -> URLSessionDataTask {
        veriedInternetConection {(data, response, error) in
            completion(data, response, error)
            return
        }
        
        printerNetworkDebugRequest(request: request)
        let task = session.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(nil, nil, CustomErrors.errorGeneralResponse)
                }
                return
            }
            
            self.printerNetworkDebugResponse(response: response,
                                             data: data ?? Data(),
                                             error: error ?? NSError(domain: "", code: 0, userInfo: nil))
            
            guard let resultData = data else {
                DispatchQueue.main.async {
                    completion(nil, nil, CustomErrors.errorGeneralResponse)
                }
                return
            }
            
            self.manageHttpCodeResponse(response: response, realData: resultData, error: error, completion: { (data, response, error) in
                completion(data, response, error)
            })
        }
        task.resume()
        return task
    }
    
    func veriedInternetConection(completion: @escaping(Data?, HTTPURLResponse?, NSError?) -> Void) {
        if ReachabilityManager.checkReachable() == .unreachable {
            completion(nil, nil, CustomErrors.errorNetworkConection)
            return
        }
    }
    
    func manageHttpCodeResponse(response: HTTPURLResponse,
                                realData: Data,
                                error: Error?,
                                completion: @escaping(Data?, HTTPURLResponse?, NSError?) -> Void) {
        switch response.statusCode {
        case 200:
            DispatchQueue.main.async {
                completion(realData, response, nil)
            }
        default:
                DispatchQueue.main.async {
                    completion(realData, response, CustomErrors.errorGeneralResponse)
                }
        }
    }
    
    func printerNetworkDebugRequest(request: URLRequest) {
        print("**********REQUEST**********")
        print("*****Request URL: \(request)")
        print("*****Request HeaderFields: \(String(describing: request.allHTTPHeaderFields))")
        let stringPrintData = String(NSString(data: request.httpBody ?? Data(),
                                              encoding: String.Encoding.utf8.rawValue) ?? "")
        print("*****Request Body: \(stringPrintData)")
    }

    func printerNetworkDebugResponse(response: HTTPURLResponse, data: Data, error: Error) {
        print("*****Response*****")
        print("*****Response http: \(response)")
        print("*****Response error: \(String(describing: error))")
        print(String(NSString(data: data ,
                                                        encoding: String.Encoding.utf8.rawValue) ?? ""))
    }
}


