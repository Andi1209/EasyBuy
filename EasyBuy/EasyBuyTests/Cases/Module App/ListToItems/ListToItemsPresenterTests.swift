//
//  ListToItemsPresenterTests.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 16/05/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

@testable import EasyBuy
import XCTest

class ListToItemsPresenterTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: ListToItemsPresenter!
    var spy: ListToItemsDisplayLogicSpy!
    var interactor: ListToItemsInteractor!
    var responseGetCategorie: ListToItems.GetCategorie.Response!
    var responseGetItemForName:ListToItems.GetItemForName.Response!
    var totalItems = 100
    var curretItems = 50
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        setupListToItemsPresenter()
    }
    
    override func tearDown(){
        sut = nil
        spy = nil
        interactor = nil
        responseGetCategorie = nil
        responseGetItemForName = nil
        super.tearDown()
    }
    
    // MARK: Test setup

    func setupListToItemsPresenter(){
        sut = ListToItemsPresenter()
        spy = ListToItemsDisplayLogicSpy()
        sut.viewController = spy
        interactor = ListToItemsInteractor()

    }
    
    
    // MARK: Given
    func getItemsResutl()->[ItemCodable]{
        return interactor.returnItemCodable(items: Seeds.items.resustItemsResults?.items ?? [])
        
    }
    
    func getareThereMoreItems()->Bool {
        return  interactor.areThereMoreItems(totalItems: totalItems, curretItems: curretItems)
    }
    
    func getGetCategories(itemCodables: [ItemCodable],areThereMoreItems: Bool){
        responseGetCategorie = ListToItems.GetCategorie.Response(itemsCodable: itemCodables, areThereMoreItems: areThereMoreItems)
    }
    
    func getGetItemForName(itemCodables: [ItemCodable],areThereMoreItems: Bool){
        responseGetItemForName = ListToItems.GetItemForName.Response(itemsCodable: itemCodables, areThereMoreItems: areThereMoreItems)
    }
    
    func givenResponseGetCategorie(){
        let itemsCodable  = getItemsResutl()
        let areThereMoreItems = getareThereMoreItems()
        getGetCategories(itemCodables: itemsCodable, areThereMoreItems: areThereMoreItems)
    }
    
    func givenResponseGetItemForName(){
        let itemsCodable  = getItemsResutl()
        let areThereMoreItems = getareThereMoreItems()
        getGetItemForName(itemCodables: itemsCodable, areThereMoreItems: areThereMoreItems)
    }
    
    
    
    // MARK: Test doubles
    
    class ListToItemsDisplayLogicSpy: ListToItemsDisplayLogic{
        
        var loadInitalDataCalled = false
        var errorLoadInitalDataCalled = false
        var categoreInformation = false
        var nextPageItemInformation = false
        var getItemForNameInformation = false
        var nextItemForNameInformatio = false
        var erroItemInformation = false
        
        func displayInitialInformation(viewModel: ListToItems.LoadInitalData.ViewModel){
            loadInitalDataCalled = true
        }
        
        
        func displayInitialInformationError(viewModel: ListToItems.ErrorCategorias.ViewModel) {
            errorLoadInitalDataCalled = true
        }
        
        func displayCategoreInformation(viewModel: ListToItems.GetCategorie.ViewModel) {
            categoreInformation = true
        }
        
        func displayNextPageItemInformation(viewModel: ListToItems.GetCategorie.ViewModel) {
            nextPageItemInformation = true
        }
        
        func displaygetItemForNameInformation(viewModel: ListToItems.GetItemForName.ViewModel) {
            getItemForNameInformation = true
        }
        
        func displayNextItemForNameInformation(viewModel: ListToItems.GetItemForName.ViewModel) {
            nextItemForNameInformatio = true
        }
        
        func displayErroItemInformation(viewModel: ServiceError.ErrorGeneral.ViewModel) {
            erroItemInformation = true
        }
    }
    
    // MARK: Tests
    
    func test_givePresentInitialInformation_whenSucces(){
        // Given
        let response = ListToItems.LoadInitalData.Response(caregories: Seeds.items.resulstCategories)
        
        // When
        sut.presentInitialInformation(response: response)
        
        // Then
        XCTAssertTrue(spy.loadInitalDataCalled, "presentInitialInformation(response:) should ask the view controller to display the result")
    }
    
    
    func test_givePresentInitialInformationError_whenSucces(){
        // Given
        let response = ListToItems.ErrorCategorias.Response()
        // When
        sut.presentInitialInformationError(response: response)
        
        // Then
        XCTAssertTrue(spy.errorLoadInitalDataCalled, "presentInitialInformationError(response:) should ask the view controller to display the result")
    }
    
    func test_givePresentCategoreInformation_whenSucces(){
        // Given
        givenResponseGetCategorie()
        // When
        sut.presentCategoreInformation(response: responseGetCategorie)
        // Then
        XCTAssertTrue(spy.categoreInformation, "presentCategoreInformation(response:) should ask the view controller to display the result")
    }
    
    func test_givePresentgetNextPageItemInformation_whenSucces(){
        // Given
        givenResponseGetCategorie()
        // When
        sut.presentgetNextPageItemInformation(response: responseGetCategorie)
        
        // Then
        XCTAssertTrue(spy.nextPageItemInformation, "presentgetNextPageItemInformation(response:) should ask the view controller to display the result")
    }
    
    
    func test_givePresentgetItemForNameInformation_whenSucces(){
        // Given
        givenResponseGetItemForName()
        // When
        sut.presentgetItemForNameInformation(response: responseGetItemForName)
        
        // Then
        XCTAssertTrue(spy.getItemForNameInformation, "presentgetItemForNameInformation(response:) should ask the view controller to display the result")
    }
    
    func test_givePresentgetNextItemForNameInformation_whenSucces(){
        // Given
        givenResponseGetItemForName()
        // When
        sut.presentgetNextItemForNameInformation(response: responseGetItemForName)
        
        // Then
        XCTAssertTrue(spy.nextItemForNameInformatio, "presentgetNextItemForNameInformation(response:) should ask the view controller to display the result")
    }
    
    
    func test_givePresentErroItemInformation_whenSucces(){
        // Given
        let response = ServiceError.ErrorGeneral.Response(error: CustomErrors.errorGeneralResponse)
        // When
        sut.presentErroItemInformation(response: response)
        
        // Then
        XCTAssertTrue(spy.erroItemInformation, "presentErroItemInformation(response:) should ask the view controller to display the result")
    }
}
