//
//  ItemsResult.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 13/05/21.
//

import Foundation

struct ItemsResult: Codable {
    
    let siteID:String?
    let query:String?
    let paging:Paging?
    let items:[Item]?

    enum CodingKeys: String, CodingKey {
        case siteID = "site_id"
        case query = "query"
        case paging = "paging"
        case items = "results"
    }
    
    public init(from decoder: Decoder) throws {
        let searchResultsValues = try decoder.container(keyedBy: CodingKeys.self)
        siteID =  try searchResultsValues.decodeIfPresent(String.self, forKey: .siteID)
        query =  try searchResultsValues.decodeIfPresent(String.self, forKey: .query)
        paging =  try searchResultsValues.decodeIfPresent(Paging.self, forKey: .paging)
        items =  try searchResultsValues.decodeIfPresent([Item].self, forKey: .items)
        
    }
}
