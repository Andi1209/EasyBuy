//
//  UserDefaultsExtensions.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 18/05/21.
//

import Foundation

enum DefaultKeys: String {
    case contrytId
    case appToDiveceId
}

extension UserDefaults {
    
    
    func setCurrencyContry (value: String) {
        set(value, forKey: DefaultKeys.contrytId.rawValue)
    }
    
    func removeCurrencyContry(){
        removeObject(forKey: DefaultKeys.contrytId.rawValue)
    }
    
    func getCurrencyContry() -> String {
        return string(forKey: DefaultKeys.contrytId.rawValue) ?? ""
    }
    
    func setAppToDiveceId (value: String) {
        set(value, forKey: DefaultKeys.appToDiveceId.rawValue)
    }
    
    func removeAppToDiveceId(){
        removeObject(forKey: DefaultKeys.appToDiveceId.rawValue)
    }
    
    func getAppToDiveceId() -> String {
        return string(forKey: DefaultKeys.appToDiveceId.rawValue) ?? ""
    }
    
       
    
}
