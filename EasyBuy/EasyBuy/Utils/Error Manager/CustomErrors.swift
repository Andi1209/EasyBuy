//
//  CustomErrors.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 13/05/21.
//

import Foundation

let kErrorGeneralResponse = 1000
let kErrorNetworkConection = 1001
let KEnoDataFound = 1002


struct CustomErrors {
     static let errorGeneralResponse = NSError(domain: "1000",
                                       code: kErrorGeneralResponse,
                                       userInfo: ["message":
                                        NSLocalizedString("service.error.errorGeneralResponse",
                                                          comment: "")])

    static let errorNetworkConection = NSError(domain: "1001",
                                              code: kErrorNetworkConection,
                                              userInfo: ["message":
                                                NSLocalizedString("service.error.errorNetworkConexion",
                                                                  comment: "")])
    static let errorNoData = NSError(domain: "1002",
                                                code: KEnoDataFound,
                                                userInfo: ["message":NSLocalizedString("service.error.noData",
                                                                                       comment: "")])
    
}

