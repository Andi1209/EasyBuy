//
//  ErrorGeneral.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 14/05/21.
//

import UIKit

enum ServiceError {
    // MARK: Use cases
    
    enum ErrorGeneral {
        struct Request {
        }
        struct Response {
            let error: NSError
        }
        
        struct ViewModel {
            let errorMesage: String
            let error: NSError
        }
    }
    
}
