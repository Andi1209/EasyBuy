//
//  ItemDetailInteractorTests.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 17/05/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

@testable import EasyBuy
import XCTest

class ItemDetailInteractorTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: ItemDetailInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        setupItemDetailInteractor()
    }
    
    override func tearDown(){
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupItemDetailInteractor(){
        sut = ItemDetailInteractor()
    }
    
    // MARK: Test doubles
    
    class ItemDetailPresentationLogicSpy: ItemDetailPresentationLogic{
        
        var presentInitialInformationCalled = false
        
        func presentInitialInformation(response: ItemDetail.LoadInitalData.Response){
            presentInitialInformationCalled = true
        }
    }
    
    // MARK: Tests
    
    func testPresentInitialInformation(){
        // Given
        let spy = ItemDetailPresentationLogicSpy()
        sut.presenter = spy
        let request = ItemDetail.LoadInitalData.Request()
        
        // When
        sut.loadInitialInformation(request: request)
        
        // Then
        XCTAssertTrue(spy.presentInitialInformationCalled, "loadInitialInformation(request:) should ask the presenter to format the result")
    }
}
