//
//  StringExtension.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 19/05/21.
//

import Foundation



extension String {
    

    func getCountryService()->String{
        
        switch self {
        case "CO" :
            return "MCO"
        case "AR":
            return "MLA"
        case "BR":
            return "MLB"
        default:
            return "MCO"
        }
    
}
}
