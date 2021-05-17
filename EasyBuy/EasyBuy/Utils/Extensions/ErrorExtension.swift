//
//  ErrorExtension.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 16/05/21.
//

import Foundation

extension NSError {
    func getErrorMessage() -> String {
        return userInfo["message"] as? String ?? ""
    }
}

