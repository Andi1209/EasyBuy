//
//  Log.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 14/05/21.
//

import Foundation
import Firebase

class Log {
    
    static var shared : Log = {
        let instance = Log ()
        return instance
    }()
    private let db = Firestore.firestore()
    
    private init(){}
    
    
    func reportLog(appDocument:AppDocument,parameters:[String:Any]){
        #warning("OJO Descomentar cuando se termine el desarrrollo")
//        db.collection(appDocument.rawValue).addDocument(data: parameters) { (error) in
//            if let error = error {
//                print("Error to report log", error.localizedDescription)
//            }
//        }
    }
    
    
}
