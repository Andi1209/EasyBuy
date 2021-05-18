//
//  ItemDetailPresenter.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 17/05/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol ItemDetailPresentationLogic {
    func presentInitialInformation(response: ItemDetail.LoadInitalData.Response)
}

class ItemDetailPresenter: ItemDetailPresentationLogic {
    weak var viewController: ItemDetailDisplayLogic?
    
    func presentInitialInformation(response: ItemDetail.LoadInitalData.Response) {
        let headerSellerInformation = NSLocalizedString("itemDetail.label.headerSellerInformation", comment: "")
        let headerFeatureInformation = NSLocalizedString("itemDetail.label.headerFeatureInformation", comment: "")
        let viewModel = ItemDetail.LoadInitalData.ViewModel(item: response.item,headerSellerInformation: headerSellerInformation,headerFeatureInformation: headerFeatureInformation)
        viewController?.displayInitialInformation(viewModel: viewModel)
    }
}

