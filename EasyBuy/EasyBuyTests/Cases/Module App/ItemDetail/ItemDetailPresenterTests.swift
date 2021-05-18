//
//  ItemDetailPresenterTests.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 17/05/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

@testable import EasyBuy
import XCTest

class ItemDetailPresenterTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: ItemDetailPresenter!
    var item: ItemModel!
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        setupItemDetailPresenter()
    }
    
    override func tearDown(){
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupItemDetailPresenter(){
        sut = ItemDetailPresenter()
        item = ItemModelMock().initMock()
    }
    
    // MARK: Test doubles
    
    class ItemDetailDisplayLogicSpy: ItemDetailDisplayLogic{
        var LoadInitalDataCalled = false
        
        func displayInitialInformation(viewModel: ItemDetail.LoadInitalData.ViewModel){
            LoadInitalDataCalled = true
        }
    }
    
    // MARK: Tests
    
    func testPresentInitialInformation(){
        // Given
        let spy = ItemDetailDisplayLogicSpy()
        sut.viewController = spy
        
       
        let response = ItemDetail.LoadInitalData.Response(item: item)
        
        // When
        sut.presentInitialInformation(response: response)
        
        // Then
        XCTAssertTrue(spy.LoadInitalDataCalled, "presentInitialInformation(response:) should ask the view controller to display the result")
    }
}
