//
//  LauncherViewControllerTests.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 14/05/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

@testable import EasyBuy
import XCTest

class LauncherViewControllerTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: LauncherViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        window = UIWindow()
        setupLauncherViewController()
    }
    
    override func tearDown(){
        window = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupLauncherViewController(){
        
        sut = LauncherViewController()
    }
    
    func loadView(){
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    
    // MARK: Test doubles
    
    class LauncherBusinessLogicSpy: LauncherBusinessLogic{
        var LoadInitalDataCalled = false
        
        func loadInitialInformation(request: Launcher.LoadInitalData.Request){
            LoadInitalDataCalled = true
        }
    }
    
    // MARK: Tests
    
    func testShouldLoadInitialInformationWhenViewIsLoaded(){
        // Given
        let spy = LauncherBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.LoadInitalDataCalled, "viewDidLoad() should ask the interactor to do something")
    }
    
    func testDisplayLoadInitialInformation(){
        // Given
        let viewModel = Launcher.LoadInitalData.ViewModel()
        
        // When
        loadView()
        sut.displayInitialInformation(viewModel: viewModel)
        
        // Then
        //XCTAssertEqual(sut.nameTextField.text, "", "displaySomething(viewModel:) should update the name text field")
    }
}
