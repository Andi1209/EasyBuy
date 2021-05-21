//
//  LogEnum.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 14/05/21.
//

import Foundation


enum AppDocument:String {
    case logServices = "logServices"
}


enum Processes:String {
    case categoriesGet = "Getcategories"
    case categoriesGetForId = "GetcategorieForId"
}



enum Params:String {
    case proceso = "proceso"
    case response = "response"
    case succesResponse = "succesResponse"
}
