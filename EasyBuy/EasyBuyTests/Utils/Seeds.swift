//
//  Seeds.swift
//  EasyBuyTests
//
//  Created by Andres Felipe Nunez on 14/05/21.
//

import Foundation
@testable import EasyBuy

struct Seeds {
    class Bar {}
    struct items {
        
        static var resulstCategories:[Categorie]{
            return getCategories() ?? []
        }
        
        static var resustItemsResults:ItemsResult?{
        return getItemsResult()
        }
        
        private static func getCategories()->[Categorie]?{
            let testBundle = Bundle(for: Seeds.Bar.self)
            let path = testBundle.path(forResource: "Categories", ofType: "json")
            let data =  try! Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
            let decoder = JSONDecoder()
            guard let searchResultsCodable = try? decoder.decode([Categorie].self, from: data) else {
                return nil
            }
            return searchResultsCodable
        }
        
        private static func getItemsResult()->ItemsResult?{
            let testBundle = Bundle(for: Seeds.Bar.self)
            let path = testBundle.path(forResource: "ItemsResult", ofType: "json")
            let data =  try! Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
            let decoder = JSONDecoder()
            guard let searchResultsCodable = try? decoder.decode(ItemsResult.self, from: data) else {
                return nil
            }
            return searchResultsCodable
        }
    
 
        
    }
}
