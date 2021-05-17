//
//  ItemModel.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 15/05/21.
//

import Foundation

class ItemModel {
    
    var name:String
    var condition:Bool
    var price:String
    var currency:String
    var installments:String
    var address:String
    var image:String
    var freeShipping:Bool
    var attributes:[AttributesModel]

    
    init(name:String, condition:Bool, price:String, currency:String, installments:String, address:String, image:String,freeShipping:Bool,attributes: [AttributesModel]) {
        self.name = name
        self.condition = condition
        self.price = price
        self.currency = currency
        self.installments = installments
        self.address = address
        self.image = image
        self.freeShipping = freeShipping
        self.attributes = attributes
    }
    
}

struct AttributesModel {
    var title:String
    var vale:String
}
