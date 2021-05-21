//
//  ListToItemsModels.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 14/05/21.

import UIKit

enum ListToItems {
    // MARK: Use cases
    
    enum LoadInitalData {
        struct Request {
        }
        struct Response {
            var caregories: [Categorie]
        }
        struct ViewModel {
            var caregories: [Categorie]
        }
    }
    
    enum GetCategorie {
        struct Request {
            var category: String
        }
        struct Response {
            var itemsCodable: [ItemCodable]
            var areThereMoreItems: Bool
        }
        struct ViewModel {
            var items:[ItemModel]
            var areThereMoreItems: Bool
        }
    }
    
    enum GetItemForName {
        struct Request {
            var name: String
        }
        struct Response {
            var itemsCodable: [ItemCodable]
            var areThereMoreItems: Bool
        }
        struct ViewModel {
            var items:[ItemModel]
            var areThereMoreItems: Bool
        }
    }
    
    
    enum ErrorCategorias {
        struct Request {
        }
        struct Response {
        }
        struct ViewModel {
            var messageErrorCategories:String
        }
    }
}

struct ItemCodable {
    var name:String
    var price: Double
    var condition:String
    var soldQuantity: Int
    var currencyID: String
    var installments: Installments?
    var address:Address?
    var image:String
    var shipping:Shipping?
    var attributes:[Attribute]?
}
