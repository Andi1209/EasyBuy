//
//  LauncherInteractor.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 13/05/21.
//

import UIKit

protocol LauncherBusinessLogic {
    func loadInitialInformation(request: Launcher.LoadInitalData.Request)
}

protocol LauncherDataStore {

}

class LauncherInteractor: LauncherBusinessLogic, LauncherDataStore {
    var presenter: LauncherPresentationLogic?
    var worker: LauncherWorker = LauncherWorker()

    
    func loadInitialInformation(request: Launcher.LoadInitalData.Request) {
        let response = Launcher.LoadInitalData.Response()
        presenter?.presentInitialInformation(response: response)
    }
}

