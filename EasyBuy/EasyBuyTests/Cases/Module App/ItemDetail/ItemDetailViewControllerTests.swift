//
//  ItemDetailViewControllerTests.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 17/05/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

@testable import EasyBuy
import XCTest

class ItemDetailViewControllerTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: ItemDetailViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        window = UIWindow()
        setupItemDetailViewController()
    }
    
    override func tearDown(){
        window = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupItemDetailViewController(){
        
        sut = ItemDetailViewController()
    }
    
    func loadView(){
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    
    // MARK: Test doubles
    
    class ItemDetailBusinessLogicSpy: ItemDetailBusinessLogic{
        var LoadInitalDataCalled = false
        
        func loadInitialInformation(request: ItemDetail.LoadInitalData.Request){
            LoadInitalDataCalled = true
        }
    }
    
    // MARK: Tests
    
    func testShouldLoadInitialInformationWhenViewIsLoaded(){
        // Given
        let spy = ItemDetailBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.LoadInitalDataCalled, "viewDidLoad() should ask the interactor to do something")
    }
    
//    func testDisplayLoadInitialInformation(){
//        // Given
//        let viewModel = ItemDetail.LoadInitalData.ViewModel()
//        
//        // When
//        loadView()
//        sut.displayInitialInformation(viewModel: viewModel)
//        
//        // Then
//        //XCTAssertEqual(sut.nameTextField.text, "", "displaySomething(viewModel:) should update the name text field")
//    }
}
