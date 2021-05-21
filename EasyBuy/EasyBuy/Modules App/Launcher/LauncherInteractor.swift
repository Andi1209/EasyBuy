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
        GeoLocationManager.sharedInstance.delegate = self
        GeoLocationManager.sharedInstance.requestPermission()
        
    }
}


extension LauncherInteractor: LocationServiceDelegate {
    func setCountryLocation(country: String) {
        UserDefaults.standard.setCurrencyContry(value: country.getCountryService())
        let response = Launcher.LoadInitalData.Response()
        self.presenter?.presentInitialInformation(response: response)
    }
    
}
