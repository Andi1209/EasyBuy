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
    //var name: String { get set }
}

class LauncherInteractor: LauncherBusinessLogic, LauncherDataStore {
    var presenter: LauncherPresentationLogic?
    var worker: LauncherWorker = LauncherWorker()
    //var name: String = ""
    
    func loadInitialInformation(request: Launcher.LoadInitalData.Request) {
        worker.fetchResultsBy(country: "MCO") { (response, result) in
            switch result {
            case .success:
                guard let results = result.value else {
                    return
                }
                print(results)
            case .failure (let error):
               break
            }
        }
    }
}

