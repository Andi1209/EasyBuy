//
//  ListToItemsViewControllerTests.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 16/05/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

@testable import EasyBuy
import XCTest

class ListToItemsViewControllerTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: ListToItemsViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        window = UIWindow()
        setupListToItemsViewController()
    }
    
    override func tearDown(){
        window = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupListToItemsViewController(){
        
        sut = ListToItemsViewController()
    }
    
    func loadView(){
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    
    // MARK: Test doubles
    
//    class ListToItemsBusinessLogicSpy: ListToItemsBusinessLogic{
//        var LoadInitalDataCalled = false
//        
//        func loadInitialInformation(request: ListToItems.LoadInitalData.Request){
//            LoadInitalDataCalled = true
//        }
//    }
//    
//    // MARK: Tests
//    
//    func testShouldLoadInitialInformationWhenViewIsLoaded(){
//        // Given
//        let spy = ListToItemsBusinessLogicSpy()
//        sut.interactor = spy
//        
//        // When
//        loadView()
//        
//        // Then
//        XCTAssertTrue(spy.LoadInitalDataCalled, "viewDidLoad() should ask the interactor to do something")
//    }
//    
//    func testDisplayLoadInitialInformation(){
//        // Given
//        let viewModel = ListToItems.LoadInitalData.ViewModel()
//        
//        // When
//        loadView()
//        sut.displayInitialInformation(viewModel: viewModel)
//        
//        // Then
//        //XCTAssertEqual(sut.nameTextField.text, "", "displaySomething(viewModel:) should update the name text field")
//    }
}
