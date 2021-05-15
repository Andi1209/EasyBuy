//
//  LauncherPresenter.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 13/05/21.

import UIKit

protocol LauncherPresentationLogic {
    func presentInitialInformation(response: Launcher.LoadInitalData.Response)
}

class LauncherPresenter: LauncherPresentationLogic {
    weak var viewController: LauncherDisplayLogic?
    
    func presentInitialInformation(response: Launcher.LoadInitalData.Response) {
        let viewModel = Launcher.LoadInitalData.ViewModel()
        viewController?.displayInitialInformation(viewModel: viewModel)
    }
}

