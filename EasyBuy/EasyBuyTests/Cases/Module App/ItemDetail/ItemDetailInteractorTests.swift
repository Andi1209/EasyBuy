//
//  ItemDetailInteractorTests.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 17/05/21.
//
//

@testable import EasyBuy
import XCTest

class ItemDetailInteractorTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: ItemDetailInteractor!
    var spy: ItemDetailPresentationLogicSpy!
    var item: ItemModel!
    
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        setupItemDetailInteractor()
    }
    
    override func tearDown(){
        sut = nil
        spy = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupItemDetailInteractor(){
        sut = ItemDetailInteractor()
        spy = ItemDetailPresentationLogicSpy()
        sut.presenter = spy
        item = ItemModelMock().initMock()
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
        let request = ItemDetail.LoadInitalData.Request()
        // When
        sut.item = item
        sut.loadInitialInformation(request: request)
        
        // Then
        XCTAssertTrue(spy.presentInitialInformationCalled, "loadInitialInformation(request:) should ask the presenter to format the result")
    }
}
