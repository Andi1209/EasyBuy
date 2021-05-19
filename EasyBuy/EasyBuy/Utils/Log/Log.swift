//
//  Log.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 14/05/21.
//

import Foundation
import Firebase

class Log {
    
    private var parametersDefault:[String:Any] = [:]
    static var shared : Log = {
        let instance = Log ()
        return instance
    }()
    private let db = Firestore.firestore()
    
    private init(){}
    
    
    func reportLog(appDocument:AppDocument,parametersProcess:[String:Any]){
        getParamtrosGenerales()
        let parameters = parametersDefault.merging(parametersProcess, uniquingKeysWith: { (first, _) in first })
        db.collection(appDocument.rawValue).addDocument(data: parameters) { (error) in
            if let error = error {
                print("Error to report log", error.localizedDescription)
            }
        }
    }
    
    
    private func getParamtrosGenerales(){
        let nowFormat = getCurrentDateString()
        let id = UserDefaults.standard.getAppToDiveceId()
        parametersDefault = ["Date:":nowFormat,"id":id]
    }
    
    
    private func getCurrentDateString()->String{
        let now = Date()
        let formatterDate = DateFormatter()
        formatterDate.locale = Locale(identifier: "en_US")
        formatterDate.dateFormat = "dd/MM/yyyy HH:mm:ss"
        return formatterDate.string(from: now)
    }
    
    
    
    
    
}
