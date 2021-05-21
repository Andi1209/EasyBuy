//
//  LauncherInteractorTests.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 14/05/21.
//
//

@testable import EasyBuy
import XCTest
import CoreLocation

class LauncherInteractorTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: LauncherInteractor!
    var exp:XCTestExpectation!
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        setupLauncherInteractor()
    }
    
    override func tearDown(){
        sut = nil
        exp = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupLauncherInteractor(){
        sut = LauncherInteractor()
        exp = expectation(description: "Localization")
    }
    
    // MARK: Test doubles
    
    class LauncherPresentationLogicSpy: LauncherPresentationLogic{
        
        var presentInitialInformationCalled = false
        var exp:XCTestExpectation?
        
        func presentInitialInformation(response: Launcher.LoadInitalData.Response){
            presentInitialInformationCalled = true
            exp?.fulfill()
        }
    }
    
    // MARK: Tests
    
    func testPresentInitialInformation(){
        // Given
        let spy = LauncherPresentationLogicSpy()
        spy.exp = exp
        sut.presenter = spy
        let request = Launcher.LoadInitalData.Request()
        
        
        let latitude  = Double(4.5981531147211013)
        let longitude = Double(-74.075876484916315)
        let coordinate = CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude)
        let location = CLLocation.init(coordinate: coordinate,
                                       altitude: 0,
                                       horizontalAccuracy: 0,
                                       verticalAccuracy: 0,
                                       timestamp: Date())
        
        let locationMager = LocationManager.init()
        locationMager.location = location
        
        // When
        sut.loadInitialInformation(request: request)
        GeoLocationManager.sharedInstance.locationManager(locationMager, didUpdateLocations: [])
        wait(for: [exp], timeout: 5)
        // Then
        XCTAssertTrue(spy.presentInitialInformationCalled, "loadInitialInformation(request:) should ask the presenter to format the result")
    }
}


final class LocationManager: CLLocationManager {


    // Allow location to be set for testing. If it is set, the set value will be returned, else the current location.
    private var _location: CLLocation?
    @objc dynamic override var location: CLLocation? {
        get {
            let usedLocation = _location ?? super.location
            return usedLocation
        }
        set {
            self._location = newValue
        }
    }

} //
