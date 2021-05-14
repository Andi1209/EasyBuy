//
//  Installments.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 13/05/21.
//

import Foundation

struct Installments: Codable {
    let quantity: Int?
    let amount, rate: Double?
    let currencyID: String?

    enum CodingKeys: String, CodingKey {
        case quantity, amount, rate
        case currencyID = "currency_id"
    }
    
    public init(from decoder: Decoder) throws {
        let installmentsResultsValues = try decoder.container(keyedBy: CodingKeys.self)
        quantity =  try installmentsResultsValues.decodeIfPresent(Int.self, forKey: .quantity)
        amount =  try installmentsResultsValues.decodeIfPresent(Double.self, forKey: .amount)
        rate =  try installmentsResultsValues.decodeIfPresent(Double.self, forKey: .rate)
        currencyID =  try installmentsResultsValues.decodeIfPresent(String.self, forKey: .currencyID)
    }
}
