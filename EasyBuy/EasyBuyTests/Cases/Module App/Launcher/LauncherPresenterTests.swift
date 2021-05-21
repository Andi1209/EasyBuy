//
//  LauncherPresenterTests.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 14/05/21.
//
//

@testable import EasyBuy
import XCTest

class LauncherPresenterTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: LauncherPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        setupLauncherPresenter()
    }
    
    override func tearDown(){
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupLauncherPresenter(){
        sut = LauncherPresenter()
    }
    
    // MARK: Test doubles
    
    class LauncherDisplayLogicSpy: LauncherDisplayLogic{
        var LoadInitalDataCalled = false
        
        func displayInitialInformation(viewModel: Launcher.LoadInitalData.ViewModel){
            LoadInitalDataCalled = true
        }
    }
    
    // MARK: Tests
    
    func testPresentInitialInformation(){
        // Given
        let spy = LauncherDisplayLogicSpy()
        sut.viewController = spy
        let response = Launcher.LoadInitalData.Response()
        
        // When
        sut.presentInitialInformation(response: response)
        
        // Then
        XCTAssertTrue(spy.LoadInitalDataCalled, "presentInitialInformation(response:) should ask the view controller to display the result")
    }
}
