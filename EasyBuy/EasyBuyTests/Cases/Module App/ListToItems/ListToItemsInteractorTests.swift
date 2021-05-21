//
//  ListToItemsInteractorTests.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 16/05/21.
//
//

@testable import EasyBuy
import XCTest

class ListToItemsInteractorTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: ListToItemsInteractor!
    var spyWorker: ListToItemsWorkerSpy!
    var spy: ListToItemsPresentationLogicSpy!
    var requestLoadInitalData: ListToItems.LoadInitalData.Request!
    var requestGetCategorie: ListToItems.GetCategorie.Request!
    var requestGetItemForName: ListToItems.GetItemForName.Request!
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        setupListToItemsInteractor()
    }
    
    override func tearDown(){
        sut = nil
        spyWorker = nil
        spy = nil
        requestLoadInitalData = nil
        requestGetCategorie = nil
        requestGetItemForName = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupListToItemsInteractor(){
        sut = ListToItemsInteractor()
        spyWorker = ListToItemsWorkerSpy()
        spy = ListToItemsPresentationLogicSpy()
        sut.presenter = spy
        sut.worker = spyWorker
        requestLoadInitalData = ListToItems.LoadInitalData.Request()
        requestGetCategorie = ListToItems.GetCategorie.Request(category: "MCO1747")
        requestGetItemForName = ListToItems.GetItemForName.Request(name: "Control")
    }
    
    // MARK: Test doubles
    
    class ListToItemsPresentationLogicSpy: ListToItemsPresentationLogic{
    
        var presentInitialInformationCalled = false
        var presentInitialInformationError = false
        var presentCategoreInformation = false
        var presentgetNextPageItemInformation = false
        var presentgetItemForNameInformation = false
        var presentgetNextItemForNameInformation = false
        var presentErroItemInformation = false
        
        func presentInitialInformation(response: ListToItems.LoadInitalData.Response){
            presentInitialInformationCalled = true
        }
        
        
        func presentInitialInformationError(response: ListToItems.ErrorCategorias.Response) {
            presentInitialInformationError = true
        }
        
        func presentCategoreInformation(response: ListToItems.GetCategorie.Response) {
            presentCategoreInformation = true
        }
        
        func presentgetNextPageItemInformation(response: ListToItems.GetCategorie.Response) {
            presentgetNextPageItemInformation = true
        }
        
        func presentgetItemForNameInformation(response: ListToItems.GetItemForName.Response) {
            presentgetItemForNameInformation = true
        }
        
        func presentgetNextItemForNameInformation(response: ListToItems.GetItemForName.Response) {
            presentgetNextItemForNameInformation = true
        }
        
        func presentErroItemInformation(response: ServiceError.ErrorGeneral.Response) {
            presentErroItemInformation = true
        }
    }
    
    class ListToItemsWorkerSpy:ListToItemsWorker{
        var fetchResultsCalled = false
        var customError:NSError?
        
        override func fetchCategories(country: String, completionHandler: @escaping (HTTPURLResponse, Result<[Categorie]>) -> Void) {
            fetchResultsCalled = true
            if customError == nil{
                completionHandler(HTTPURLResponse(), Result<[Categorie]>.success(Seeds.items.resulstCategories))
            }else{
                completionHandler(HTTPURLResponse(), Result<[Categorie]>.failure(customError))
            }
        }
        
        override func fetchCategorieForID(country: String, category: String, offset: String, completionHandler: @escaping (HTTPURLResponse, Result<ItemsResult>) -> Void) {
            fetchResultsCalled = true
            if customError == nil{
                completionHandler(HTTPURLResponse(), Result<ItemsResult>.success(Seeds.items.resustItemsResults!))
            }else{
                completionHandler(HTTPURLResponse(), Result<ItemsResult>.failure(customError))
            }
        }
        
        override func fetchItemForName(country: String, name: String, offset: String, completionHandler: @escaping (HTTPURLResponse, Result<ItemsResult>) -> Void) {
            fetchResultsCalled = true
            if customError == nil{
                completionHandler(HTTPURLResponse(), Result<ItemsResult>.success(Seeds.items.resustItemsResults!))
            }else{
                completionHandler(HTTPURLResponse(), Result<ItemsResult>.failure(customError))
            }
        }
    }
    
    // MARK: Tests
    
    func test_givePresentInitialInformation_whenSucces(){
        // When
        sut.loadInitialInformation(request: requestLoadInitalData)
        // Then
        XCTAssertTrue(spy.presentInitialInformationCalled, "loadInitialInformation(request:) should ask the presenter to format the result")
    }
    
    
    func test_giveLoadInitialInformation_WhenError(){
        // Given
        spyWorker.customError = CustomErrors.errorGeneralResponse
        // When
        sut.loadInitialInformation(request: requestLoadInitalData)
        
        // Then
        XCTAssertTrue(spy.presentInitialInformationError, "ErrorloadInitialInformation(request:) should ask the presenter to format the result")
    }
    
    func test_giveGetCategoreInformation_whenSucces(){
        // When
        sut.getCategoreInformation(request: requestGetCategorie)
        
        // Then
        XCTAssertTrue(spy.presentCategoreInformation, "getCategoreInformation(request:) should ask the presenter to format the result")
    }
    
    func test_giveGetCategoreInformation_whenError(){
        // Given
        spyWorker.customError = CustomErrors.errorGeneralResponse
        // When
        sut.getCategoreInformation(request: requestGetCategorie)
        
        // Then
        XCTAssertTrue(spy.presentErroItemInformation, "getCategoreInformation Error(request:) should ask the presenter to format the result")
    }
    
    
    func test_giveGetNextPageItemInformation_whenSucces(){
        // When
        sut.getNextPageItemInformation(request: requestGetCategorie)
        
        // Then
        XCTAssertTrue(spy.presentgetNextPageItemInformation, "getNextPageItemInformation(request:) should ask the presenter to format the result")
    }
    
    func test_giveGetNextPageItemInformation_whenError(){
        // Given
        spyWorker.customError = CustomErrors.errorGeneralResponse
        // When
        sut.getNextPageItemInformation(request: requestGetCategorie)
        
        // Then
        XCTAssertTrue(spy.presentErroItemInformation, "getNextPageItemInformation Error(request:) should ask the presenter to format the result")
    }
    
    
    func test_giveGetItemForNameInformation_whenSucces(){
        // When
        sut.getItemForNameInformation(request: requestGetItemForName)
        
        // Then
        XCTAssertTrue(spy.presentgetItemForNameInformation, "getItemForNameInformation(request:) should ask the presenter to format the result")
    }
    
    func test_giveGetItemForNameInformation_whenError(){
        // Given
        spyWorker.customError = CustomErrors.errorGeneralResponse
        // When
        sut.getItemForNameInformation(request: requestGetItemForName)
        // Then
        XCTAssertTrue(spy.presentErroItemInformation, "getItemForNameInformation Error (request:) should ask the presenter to format the result")
    }
    
    
    func test_giveGetNextItemForNameInformation_whenSucces(){
        // When
        sut.getNextItemForNameInformation(request: requestGetItemForName)
        
        // Then
        XCTAssertTrue(spy.presentgetNextItemForNameInformation, "getNextItemForNameInformation(request:) should ask the presenter to format the result")
    }
    
    func test_giveGetNextItemForNameInformation_whenError(){
        // Given
        spyWorker.customError = CustomErrors.errorGeneralResponse
        // When
        sut.getNextItemForNameInformation(request: requestGetItemForName)
        
        // Then
        XCTAssertTrue(spy.presentErroItemInformation, "getNextItemForNameInformation(request:) should ask the presenter to format the result")
    }
    
    
}
