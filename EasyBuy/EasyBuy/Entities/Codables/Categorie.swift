//
//  Categorie.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 13/05/21.
//

import Foundation

struct Categorie: Codable {
    let id,name: String?

    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    public init(from decoder: Decoder) throws {
        let installmentsResultsValues = try decoder.container(keyedBy: CodingKeys.self)
        id =  try installmentsResultsValues.decodeIfPresent(String.self, forKey: .id)
        name =  try installmentsResultsValues.decodeIfPresent(String.self, forKey: .name)
    }
}
