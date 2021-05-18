//
//  ItemDetailModels.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 17/05/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

enum ItemDetail {
    // MARK: Use cases
    
    enum LoadInitalData {
        struct Request {
        }
        struct Response {
            var item:ItemModel
        }
        struct ViewModel {
            var item:ItemModel
            var headerSellerInformation:String
            var headerFeatureInformation:String
        }
    }
}

