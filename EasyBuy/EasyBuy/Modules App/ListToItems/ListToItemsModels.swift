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
            var offset: String
        }
        struct Response {
        }
        struct ViewModel {
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

