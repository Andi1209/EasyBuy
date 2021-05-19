//
//  GeolocalizationManager.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 18/05/21.
//

import Foundation
import UIKit
import CoreLocation

enum LocationStatus: String {
    case denied
    case notDetermined
    case authorized
    case disable
}

protocol LocationServiceDelegate: AnyObject {
    func setCountryLocation(country: String)
}

class GeoLocationManager: NSObject{
    
    static let sharedInstance: GeoLocationManager = GeoLocationManager()
    var locationManager: CLLocationManager?
    var lastLocation: CLLocation?
    weak var delegate: LocationServiceDelegate?
    var locationLoaded = false
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
    }
        
    func requestPermission() {
        locationLoaded = false
        if CLLocationManager.authorizationStatus() == .notDetermined{
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.requestAlwaysAuthorization()
        }else{
            startUpdatingLocation()
        }
        locationManager?.delegate = self
    }
    
    func startUpdatingLocation() {
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        self.locationManager?.stopUpdatingLocation()
    }
    
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ codeCountry: String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       placemarks?.first?.isoCountryCode,
                       error)
        }
    }

}

extension GeoLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let _ = error as NSError? {
                self.delegate?.setCountryLocation(country: Contries.CO.rawValue)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else { return }
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        if locValue.longitude != 0 && !locationLoaded {
            locationLoaded = true
            
            fetchCityAndCountry(from: location) { city, country, codeCountry, error in
                guard let codeCountry = codeCountry ,error == nil else { return }
                self.delegate?.setCountryLocation(country: codeCountry)
            }
            
            locationManager?.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if CLLocationManager.locationServicesEnabled() {
        switch status {
            case .notDetermined:
                requestPermission()
            case .authorizedWhenInUse, .authorizedAlways:
                startUpdatingLocation()
            case .restricted, .denied:
                self.delegate?.setCountryLocation(country: Contries.CO.rawValue)
            @unknown default:
                self.delegate?.setCountryLocation(country: Contries.CO.rawValue)
            }
        } else {
            self.delegate?.setCountryLocation(country: Contries.CO.rawValue)
            self.locationLoaded = false
        }
    }
}

