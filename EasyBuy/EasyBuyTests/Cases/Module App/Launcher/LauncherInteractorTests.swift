//
//  LauncherInteractorTests.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 14/05/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

@testable import EasyBuy
import XCTest

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
                
        // When
        sut.loadInitialInformation(request: request)
        GeoLocationManager.sharedInstance.locationManager(GeoLocationManager.sharedInstance.locationManager!, didUpdateLocations: [])
        wait(for: [exp], timeout: 5)
        // Then
        XCTAssertTrue(spy.presentInitialInformationCalled, "loadInitialInformation(request:) should ask the presenter to format the result")
    }
}
