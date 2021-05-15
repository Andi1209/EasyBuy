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
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        setupLauncherInteractor()
    }
    
    override func tearDown(){
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupLauncherInteractor(){
        sut = LauncherInteractor()
    }
    
    // MARK: Test doubles
    
    class LauncherPresentationLogicSpy: LauncherPresentationLogic{
        
        var presentInitialInformationCalled = false
        
        func presentInitialInformation(response: Launcher.LoadInitalData.Response){
            presentInitialInformationCalled = true
        }
    }
    
    // MARK: Tests
    
    func testPresentInitialInformation(){
        // Given
        let spy = LauncherPresentationLogicSpy()
        sut.presenter = spy
        let request = Launcher.LoadInitalData.Request()
        
        // When
        sut.loadInitialInformation(request: request)
        
        // Then
        XCTAssertTrue(spy.presentInitialInformationCalled, "loadInitialInformation(request:) should ask the presenter to format the result")
    }
}
